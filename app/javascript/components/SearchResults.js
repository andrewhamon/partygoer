import React, { Component } from 'react'

import Loader from 'react-loader'

import './SearchResults.scss'

import { graphql } from 'react-apollo'
import gql from 'graphql-tag'

const FetchSearchResults = gql`
  query FetchSearchResults($query: String!) {
    searchResults(query: $query) {
      id
      uri
      name
      artists
    }
  }
`

const CreateSubmission = gql`
  mutation CreateSubmission($spotifyTrackId: String!) {
    createSubmission(input: { spotifyTrackId: $spotifyTrackId }) {
      id
    }
  }
`

@graphql(FetchSearchResults, { skip: (ownProps) => !ownProps.query })
@graphql(CreateSubmission)
export default class SearchResults extends Component {
  createSubmission (spotifyTrackUri) {
    this.props.mutate({ variables: { spotifyTrackId: spotifyTrackUri }})
      .then((data) => this.props.onDone())
  }

  render () {
    const { data } = this.props
    if (!data) return null

    if (data.loading) {
      return (
        <Loader
          lines={9}
          length={6}
          width={2}
          radius={5}
          corners={1}
          rotate={0}
          direction={1}
          color='rgba(0, 0, 0, 0.3)'
        />
      )
    }

    const tracks = data.searchResults

    return (
      <div className='search-results'>
        {tracks.map((track) => (
          <div className='search-result' key={track.id}>
            <div className='track' onClick={() => this.createSubmission(track.uri)}>
              <div className='name'>{track.name}</div>
              <div className='artists'>{track.artists.join(', ')}</div>
            </div>
          </div>
        ))}
      </div>
    )
  }
}

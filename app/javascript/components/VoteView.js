import React, { Component } from 'react'
import FlipMove from 'react-flip-move'

import TrackSearch from './TrackSearch'
import Submission from './Submission'

import './VoteView.scss'

import withPartyUpdates from '../queries/withPartyUpdates'

@withPartyUpdates
export default class VoteView extends Component {
  componentDidMount () {
    this.props.subscribeToPartyChanged()
  }

  render () {
    const { data } = this.props
    if (!data || data.loading) return null

    const activeSubmissions = data.party.activeSubmissions

    return (
      <div className='vote-view'>
        <TrackSearch />

        <div className='queue'>
          <img className='album-art' src={activeSubmissions[0].track.image} />

          <FlipMove>
            {activeSubmissions.map((submission) => (
              <div key={submission.id}>
                <Submission {...submission} votable />
              </div>
            ))}
          </FlipMove>
        </div>
      </div>
    )
  }
}

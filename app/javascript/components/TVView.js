import React, { Component } from 'react'
import TrackList from './TrackList'
import NowPlaying from './NowPlaying'
import HowToVote from './HowToVote'

import filter from 'lodash/filter'

import './TVView.scss'

import withPartyUpdates from '../queries/withPartyUpdates'

@withPartyUpdates
export default class TVView extends Component {
  componentDidMount () {
    this.props.subscribeToPartyChanged()
  }

  render () {
    const { data } = this.props
    if (data.loading) return null

    const nowPlaying = data.party.active_submissions[0] || { track: { artists: [] } }

    const queuedSubmissions = data.party.active_submissions

    return (
      <div className='tvView'>
        <div className='nowPlaying'>
          <NowPlaying
            image={nowPlaying.track.image}
            name={nowPlaying.track.name}
            artists={nowPlaying.track.artists}
            score={nowPlaying.score}
          />
        </div>
        <div className='queue'>
          <p className='upNext'>UP NEXT</p>
          <TrackList submissions={filter(queuedSubmissions, { playing: false })} />
          <HowToVote />
        </div>
      </div>
    )
  }
}

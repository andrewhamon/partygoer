import React from 'react'
import classNames from 'classnames'

import './Submission.scss'

import Score from './Score'
import PlayingIndicator from './PlayingIndicator'
import VoteControls from './VoteControls'

export default ({ id, track, myVote, score, playing, votable, className }) => (
  <div className={classNames('submission', className, { playing })}>
    <PlayingIndicator />

    <div className='track'>
      <div className='name'>{track.name}</div>
      <div className='artists'>{track.artists.join(', ')}</div>
    </div>

    <div className='submission-aside'>
      {votable
        ? <VoteControls submissionId={id} direction={(myVote || {}).direction} score={score} />
        : <Score score={score} />}
    </div>
  </div>
)

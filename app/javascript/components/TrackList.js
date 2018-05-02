import React from 'react'
import FlipMove from 'react-flip-move'

import Submission from './Submission'

import './TrackList.scss'

export default ({ submissions }) => (
  <div className='trackList'>
    <FlipMove>
      {submissions.map(({ id, score, track }, index) =>
        <div key={id}>
          <Submission track={track} score={score} />
        </div>
      )}
    </FlipMove>
  </div>
)

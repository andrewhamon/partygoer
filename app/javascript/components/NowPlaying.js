import React from 'react'
import './NowPlaying.scss'

import CrossfadeImage from './CrossfadeImage'

export default ({ image, name, artists, score }) => (
  <div className='nowPlaying'>
    <CrossfadeImage src={image} />

    <div className='currentTrack'>
      <div className='trackInfo'>
        <div className='name'>{name}</div>
        <div className='artists'>{artists.join(', ')}</div>
      </div>
      <div className='score'>{formatScore(score)}</div>
    </div>
  </div>
)

function formatScore (score) {
  if (score > 0) {
    return `+${score}`
  }
  return score
}

import React from 'react'

export default ({ score }) => (
  <div className='score'>{formatScore(score)}</div>
)

function formatScore (score) {
  if (score > 0) {
    return `+${score}`
  }

  return score
}

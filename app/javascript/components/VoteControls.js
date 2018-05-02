import React, { Component } from 'react'
import classNames from 'classnames'
import { graphql } from 'react-apollo'
import gql from 'graphql-tag'

import './VoteControls.scss'

import Score from './Score'
import { FetchParty } from '../queries/withPartyUpdates'

const CreateVote = gql`
  mutation CreateVote($submissionId: ID!, $direction: VoteDirection!) {
    createVote(input: { submissionId: $submissionId, direction: $direction }) {
      id
    }
  }
`

@graphql(CreateVote)
export default class VoteControls extends Component {
  upvote () {
    this.props.mutate({
      variables: { submissionId: this.props.submissionId, direction: "UP" },
      refetchQueries: [{ query: FetchParty }]
    })
  }

  downvote () {
    this.props.mutate({
      variables: { submissionId: this.props.submissionId, direction: "DOWN" },
      refetchQueries: [{ query: FetchParty }]
    })
  }

  render () {
    const { direction, score } = this.props

    return (
      <div className='vote-controls'>
        <a
          className={classNames('upvote', { selected: direction === 'UP' })}
          onClick={(event) => this.upvote()}
        />

        <Score score={score} />

        <a
          className={classNames('downvote', { selected: direction === 'DOWN' })}
          onClick={(event) => this.downvote()}
        />
      </div>
    )
  }
}

function formatScore (score) {
  if (score > 0) {
    return `+${score}`
  }

  if (score === 0) {
    return '—'
  }

  return score
}

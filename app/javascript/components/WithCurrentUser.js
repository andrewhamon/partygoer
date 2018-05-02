import React, { Component } from 'react'

import withCurrentUser from '../queries/withCurrentUser'

@withCurrentUser
export default class WithCurrentUser extends Component {
  constructor () {
    super()
    this.state = { loaded: false }
  }

  componentDidMount () {
    if (!localStorage.getItem('token')) {
      this.props.mutate()
        .then(({ data }) => localStorage.setItem('token', data.createUser.token))
        .then(() => this.setState({ loaded: true }))
    } else {
      this.setState({ loaded: true })
    }
  }

  render () {
    if (this.state.loaded) {
      return this.props.children
    }

    return null
  }
}

import React, { Component } from 'react'

import Authenticate from './Authenticate'

import withCurrentUser from '../queries/withCurrentUser'

@withCurrentUser
export default class WithCurrentUser extends Component {
  constructor () {
    super()
    this.state = { currentUserSet: false }
  }

  componentDidMount () {
    if (localStorage.getItem('token')) {
      this.setState({ currentUserSet: true })
    }
  }

  render () {
    if (this.state.currentUserSet) {
      return this.props.children
    } else {
      return <Authenticate />
    }
  }
}

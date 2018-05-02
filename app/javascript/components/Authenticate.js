import React, { Component } from 'react'
import './Authenticate.scss'

import { graphql } from 'react-apollo'
import gql from 'graphql-tag'
import Cleave from 'cleave.js/react';
import 'cleave.js/dist/addons/cleave-phone.i18n'

const CreateUser = gql`
  mutation CreateUser ($phoneNumber: String!) {
    createUser(input: { phoneNumber: $phoneNumber }) { token }
  }
`

const VerifyUser = gql`
  mutation VerifyUser ($token: String!, $pin: String!) {
    verifyUser(input: { token: $token, pin: $pin }) { verified }
  }
`

import logo from '../images/logo.png'

@graphql(CreateUser, { name: 'createUser' })
@graphql(VerifyUser, { name: 'verifyUser' })
export default class Authenticate extends Component {
  sendVerification (event) {
    event.preventDefault()
    const phoneNumber = event.target[0].value.replace(/\s/, '')
    this.props.createUser({ variables: { phoneNumber } })
      .then((data) => this.setState({ token: data.data.createUser.token }))
  }

  verifyUser (event) {
    event.preventDefault()
    const pin = event.target[0].value.replace(/P-/, '')
    this.props.verifyUser({ variables: { token: this.state.token, pin }})
      .then((data) => this.verified(data.token))
  }

  verified (token) {
    localStorage.setItem('token', token)
    window.location.reload()
  }

  render () {
    return (
      <div className='authenticate'>
        <img className='logo' src={logo} width='166' />

        <p>
          Welcome to the party. To sign up, please give us your phone number.
          We do this to prevent spam—we'll never text you aside from sending
          you a quick verification code right now.
        </p>

        <form onSubmit={(event) => { this.sendVerification(event) }}>
          <Cleave
            placeholder='Phone number'
            options={{
              blocks: [2, 3, 3, 4],
              prefix: "+1",
              delimeter: " "
            }}
          />

          <input type='submit' value='Send Verification' />
        </form>

        <form onSubmit={(event) => { this.verifyUser(event) }}>
          <Cleave
            placeholder='PIN'
            options={{
              blocks: [1,4],
              prefix: "P",
              delimiter: "-"
            }}
          />

          <input type='submit' value='Verify PIN' />
        </form>
      </div>
    )
  }
}

import React from 'react'
import ReactDOM from 'react-dom'
import Application from '../components/Application'

import "../styles/index.scss"

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(<Application />, document.querySelector('main'))
})

let lastPing = Math.floor(Date.now() / 1000)

function updatePing () {
  const nextPing = Math.floor(Date.now() / 1000)

  if (nextPing - lastPing > 5) {
    window.location.reload(true)
  }

  lastPing = nextPing
}

setInterval(updatePing, 2000)

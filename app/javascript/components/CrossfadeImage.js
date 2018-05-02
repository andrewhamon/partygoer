import React, { Component } from 'react'

import './CrossfadeImage.scss'

export default class CrossfadeImage extends Component {
  constructor (props) {
    super(props)

    this.state = {
      src: props.src
    }
  }

  componentWillReceiveProps (nextProps) {
    if (nextProps.src === this.state.src) return

    const image = new Image()
    image.onload = () => {
      this.setState({ src: nextProps.src })
    }
    image.src = nextProps.src
  }

  render () {
    return (
      <div className='crossfade-image'>
        <img src={this.state.src} />
      </div>
    )
  }
}

/* global Image */

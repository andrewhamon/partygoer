import React, { Component } from 'react'
import debounce from 'lodash/debounce'
import classNames from 'classnames'

import SearchResults from './SearchResults'

import './TrackSearch.scss'

export default class TrackSearch extends Component {
  constructor () {
    super()
    this.state = { searching: false, query: '', debouncedQuery: '' }

    this.debouncedSetQuery = debounce((query) => this.setState({ debouncedQuery: query }), 300)
  }

  onFocus () {
    this.setState({ searching: true })
  }

  onChange (event) {
    this.setState({ query: event.target.value })
    this.debouncedSetQuery(event.target.value)
  }

  cancel (event) {
    event && event.preventDefault()
    this.setState({ searching: false, query: '', debouncedQuery: '' })
  }

  render () {
    document.body.classList.toggle('disable-scroll', this.state.searching)

    return (
      <div className={classNames('track-search', { searching: this.state.searching })}>
        <header>
          <input
            type='search'
            placeholder='Suggest a track...'
            autoComplete='off'
            onFocus={() => this.onFocus()}
            onChange={(event) => this.onChange(event)}
            value={this.state.query}
          />

          <a href='#' onClick={(event) => this.cancel(event)}>
            Cancel
          </a>
        </header>

        <SearchResults query={this.state.debouncedQuery} onDone={() => this.cancel()} />
      </div>
    )
  }
}

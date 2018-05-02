import React from 'react'
import TVView from './TVView'
import WithCurrentUser from './WithCurrentUser'
import VoteView from './VoteView'

import apolloClient from '../apolloClient'
import { ApolloProvider } from 'react-apollo'

export default () => {
  let Root

  if (window.location.pathname.includes('tv')) {
    Root = <TVView />
  } else {
    Root = <WithCurrentUser><VoteView /></WithCurrentUser>
  }

  return (
    <ApolloProvider client={apolloClient}>
      {Root}
    </ApolloProvider>
  )
}

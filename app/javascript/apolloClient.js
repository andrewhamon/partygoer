import { ApolloLink } from 'apollo-link'
import { ApolloClient } from 'apollo-client'
import { HttpLink } from 'apollo-link-http'
import { setContext } from 'apollo-link-context'
import { InMemoryCache } from 'apollo-cache-inmemory'
import ActionCable from 'actioncable'

import ActionCableLink from './networking/ActionCableLink'

function cable () {
  return ActionCable.createConsumer(
    `/cable?token=${window.localStorage.getItem('token')}`
  )
}

const httpLink = new HttpLink({ uri: process.env.HTTP_GRAPHQL_ENDPOINT })

const authLink = setContext((_, { headers }) => {
  const token = window.localStorage.getItem('token')

  return {
    headers: {
      ...headers,
      authorization: token ? `Token ${token}` : ''
    }
  }
})

const hasSubscriptionOperation = ({ query: { definitions } }) => {
  return definitions.some(
    ({ kind, operation }) => kind === 'OperationDefinition' && operation === 'subscription'
  )
}

const link = ApolloLink.split(
  hasSubscriptionOperation,
  new ActionCableLink({ cable }),
  authLink.concat(httpLink)
)

export default new ApolloClient({
  link: link,
  cache: new InMemoryCache()
})

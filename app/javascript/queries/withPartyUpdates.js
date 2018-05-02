import { graphql } from 'react-apollo'
import gql from 'graphql-tag'

export const FetchParty = gql`
  query FetchParty {
    party {
      activeSubmissions {
        id
        score
        playing
        myVote {
          direction
        }
        track {
          name
          artists
          image
        }
      }
    }
  }
`

const SubscribeToParty = gql`
  subscription SubscribeToParty {
    partyChanged {
      active_submissions {
        id
        score
        playing
        myVote {
          direction
        }
        track {
          name
          artists
          image
        }
      }
    }
  }
`

export default graphql(
  FetchParty,
  {
    props: (props) => ({
      ...props,
      subscribeToPartyChanged () {
        return props.data.subscribeToMore({
          document: SubscribeToParty,
          updateQuery (prev, next) {
            return { party: next.subscriptionData.data.partyChanged }
          }
        })
      }
    })
  }
)

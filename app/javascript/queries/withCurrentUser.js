import { graphql } from 'react-apollo'
import gql from 'graphql-tag'

const CreateUser = gql`
  mutation CreateUser {
    createUser(input: { phoneNumber: $phoneNumber }) { token }
  }
`

export default graphql(CreateUser)

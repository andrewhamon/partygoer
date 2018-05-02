import { graphql } from 'react-apollo'
import gql from 'graphql-tag'

const CreateUser = gql`
  mutation CreateUser {
    createUser(input: { phoneNumber: "+18133168895" }) { token }
  }
`

export default graphql(CreateUser)

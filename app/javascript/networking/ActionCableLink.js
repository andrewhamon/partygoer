var ApolloLink = require('apollo-link').ApolloLink
var Observable = require('apollo-link').Observable
var printer = require('graphql/language/printer')

export default function ActionCableLink (options) {
  const cableFactoryOrCable = options.cable
  var channelName = options.channelName || 'GraphqlChannel'
  var actionName = options.actionName || 'execute'

  return new ApolloLink((operation) => {
    return new Observable((observer) => {
      var channelId = Math.round(Date.now() + Math.random() * 100000).toString(16)

      const cable = cableFactoryOrCable.subscriptions ? cableFactoryOrCable : cableFactoryOrCable()

      var subscription = cable.subscriptions.create({
        channel: channelName,
        channelId: channelId
      }, {
        connected () {
          this.perform(
            actionName,
            {
              query: operation.query ? printer.print(operation.query) : null,
              variables: operation.variables,
              operationId: operation.operationId,
              operationName: operation.operationName
            }
          )
        },
        received (payload) {
          if (payload.result.data) {
            observer.next(payload.result)
          }

          if (!payload.more) {
            this.unsubscribe()
            observer.complete()
          }
        }
      })

      return subscription
    })
  })
}

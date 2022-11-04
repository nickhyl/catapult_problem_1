# catapult_problem_1

## Problem Statement

* In microservice architecture different services often communicate with each other indirectly via publishing and subscribing to messages on a particular topic
* Implement and design an in memory service which will allow different applications to subscribe to and publish such messages
  * Service should provide api to subscribe to messages on a topic
  * Service should provide api to publish message to a topic
  * A message should be sent to all subscribers of that topic

## Running code

We have three different implementations of the problem as explained in the webinar, labelled `broker_server_part_1.rb`, `broker_server_part_2.rb`, `broker_server_part_3.rb`. To test each of these start the appropriate server implementation, then run any number of subscribers like so
```
> ruby src/subscriber.rb my-topic
```
Then you can test that messages are received by the subscribers by running the publisher script like so
```
> ruby src/publisher.rb my-topic hello, world!
```

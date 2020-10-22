# behavior_subject

## BLoC Rules
- Output and Input are streams
- Don't have business logic, just pass stuff's which has to be rendered.

## BehaviorSubject
Once started to listen on stream it'll atleast retrieve previously streamed content if there isn't any newly added content.

## StreamController
StreamController wait for things actively coming from stream. So there'll be most probability to see empty stuffs if there aren't content pushed/updated to stream.

abstract class StreamState {}

class StreamInitial extends StreamState {}
class StreamLoading extends StreamState {}
class StreamActive extends StreamState {}
class StreamStopped extends StreamState {}
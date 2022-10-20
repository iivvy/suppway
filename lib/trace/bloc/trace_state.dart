part of 'trace_bloc.dart';

abstract class TraceState extends Equatable {
  const TraceState();

  @override
  List<Object> get props => [];
}

class TraceInitial extends TraceState {}

class TraceLoadingState extends TraceState {}

class TraceItemLoaded extends TraceState {
  const TraceItemLoaded({
    required this.traceHistoryItem,
  });
  final TraceHistory traceHistoryItem;
}

class TraceItemLoadedError extends TraceState {
  final String error;
  const TraceItemLoadedError({required this.error});
}

class TraceHistoryLoaded extends TraceState {
  const TraceHistoryLoaded({
    required this.tracehistory,
  });
  final List<TraceHistory> tracehistory;
}

class TraceHistoryLoadedError extends TraceState {
  final String error;
  const TraceHistoryLoadedError({required this.error});
}

part of 'trace_bloc.dart';

abstract class TraceEvent extends Equatable {
  const TraceEvent();

  @override
  List<Object> get props => [];
}

class GetTraceProductByQrCode extends TraceEvent {
  const GetTraceProductByQrCode({
    this.location,
    this.qrCode,
  });
  final String? qrCode;
  final String? location;
  @override
  List<Object> get props => [];
}

class GetTraceProductByBarCode extends TraceEvent {
  const GetTraceProductByBarCode({
    this.barreCode,
    this.lot,
    this.location,
  });

  final String? barreCode;
  final String? lot;
  final String? location;
  @override
  List<Object> get props => [];
}

class GetTraceHistory extends TraceEvent {}

class UpdateTraceHistory extends TraceEvent {
  const UpdateTraceHistory({required this.newMaxSavedHistory});
  final int newMaxSavedHistory;
}

class DeleteTraceHistory extends TraceEvent {
  const DeleteTraceHistory({
    required this.index,
  });

  final TraceHistory index;
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:suppwayy_mobile/trace/models/trace_history_model.dart';
import 'package:suppwayy_mobile/trace/trace_repository.dart';

part 'trace_event.dart';
part 'trace_state.dart';

class TraceBloc extends Bloc<TraceEvent, TraceState> {
  final TraceService traceService;
  TraceBloc({required this.traceService}) : super(TraceInitial()) {
    on<GetTraceProductByBarCode>((event, emit) async {
      emit(TraceLoadingState());
      try {
        final Map<String, dynamic> response = await traceService.traceProduct(
            barreCode: event.barreCode,
            lot: event.lot,
            location: event.location,
            qrCode: "");
        if (response['success'] == true) {
          emit(TraceItemLoaded(
            traceHistoryItem: response['trace'],
          ));
        } else {
          emit(TraceItemLoadedError(error: response['message']));
        }
      } catch (e) {
        emit(TraceItemLoadedError(error: e.toString()));
        // print(e.toString());
      }
    });

    on<GetTraceProductByQrCode>((event, emit) async {
      emit(TraceLoadingState());

      try {
        final Map<String, dynamic> response = await traceService.traceProduct(
          qrCode: event.qrCode,
          location: event.location,
          barreCode: "",
        );

        if (response['success'] == true) {
          emit(TraceItemLoaded(
            traceHistoryItem: response['trace'],
          ));
        } else {
          emit(TraceItemLoadedError(error: response['message']));
        }
      } catch (e) {
        emit(TraceItemLoadedError(error: e.toString()));
      }
    });

    on<GetTraceHistory>((event, emit) async {
      emit(TraceLoadingState());
      try {
        final List<TraceHistory> tracehistory =
            await traceService.getTraceHistory();
        emit(TraceHistoryLoaded(tracehistory: tracehistory));
      } catch (e) {
        emit(TraceHistoryLoadedError(error: e.toString()));
        // print(e);
      }
    });
    on<UpdateTraceHistory>((event, emit) async {
      emit(TraceLoadingState());
      try {
        final List<TraceHistory> tracehistory =
            await traceService.updateTraceHistory(event.newMaxSavedHistory);
        emit(TraceHistoryLoaded(tracehistory: tracehistory));
      } catch (e) {
        emit(TraceHistoryLoadedError(error: e.toString()));
        // print(e);
      }
    });

    on<DeleteTraceHistory>((event, emit) async {
      emit(TraceLoadingState());
      try {
        final List<TraceHistory> tracehistory =
            await traceService.deleteTracefHistory(index: event.index);
        emit(TraceHistoryLoaded(tracehistory: tracehistory));
      } catch (e) {
        emit(TraceHistoryLoadedError(error: e.toString()));
        // print(e);
      }
    });
  }
}

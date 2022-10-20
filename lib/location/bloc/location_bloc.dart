import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';
import 'package:suppwayy_mobile/location/models/location_list_model.dart';
import 'package:suppwayy_mobile/location/locations_repository.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationsListAPI locationsService;
  LocationBloc({required this.locationsService})
      : super(LocationInitialState()) {
    on<GetLocationsEvent>((event, emit) async {
      emit(LocationsLoading());
      try {
        final LocationListModel locationsList =
            await locationsService.fetchLocations();

        emit(LocationsLoaded(locationsListModel: locationsList));
      } catch (e) {
        // print(e);
      }
    });
    on<GetLocationByPosition>((event, emit) async {
      emit(LocationsLoading());
      try {
        final LocationListModel locationsList =
            await locationsService.fetchLocationsByPosition(
                event.position.latitude, event.position.longitude);
        emit(LocationsLoaded(locationsListModel: locationsList));
      } catch (e) {
        // print(e);
      }
    });
    on<AddLocation>((event, emit) async {
      emit(LocationsLoading());
      try {
        var response = await locationsService.addLocation(event.location);
        if (response) {
          emit(LocationCreated());
        } else {
          emit(const LocationCreationFailed(error: ""));
        }
      } catch (e) {
        // print(e);
        emit(LocationCreationFailed(error: e.toString()));
      }
    });

    on<DeleteLocation>((event, emit) async {
      emit(LocationsLoading());
      try {
        var response = await locationsService.deleteLocation(event.locationId);
        if (response) {
          emit(DeleteLocationSuccess());
        }
      } catch (e) {
        emit(DeleteLocationError(error: e.toString()));
      }
    });

    on<PatchLocation>((event, emit) async {
      emit(LocationsLoading());
      try {
        var response = await locationsService.updateLocation(
            event.locationId, event.updatedLocationData);
        if (response) {
          emit(LocationUpdated());
        }
      } catch (e) {
        emit(LocationUpdateError(error: e.toString()));
      }
    });
  }
}

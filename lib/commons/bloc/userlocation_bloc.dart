import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

part 'userlocation_event.dart';
part 'userlocation_state.dart';

class UserlocationBloc extends Bloc<UserlocationEvent, UserlocationState> {
  UserlocationBloc() : super(UserlocationInitial()) {
    on<UserlocationEvent>((event, emit) async {
      emit(UserlocationInitial());
      Location location = Location();
      bool _serviceEnabled;
      PermissionStatus _permissionGranted;
      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          emit(UserLocationPermissionRefuse());
        }
        _permissionGranted = await location.hasPermission();
        if (_permissionGranted == PermissionStatus.denied) {
          emit(UserLocationPermissionRefuse());
          _permissionGranted = await location.requestPermission();
          if (_permissionGranted != PermissionStatus.granted) {
            emit(UserLocationPermissionRefuse());
          }
        }
      }
      LocationData _currentPosition = await location.getLocation();
      emit(
        UserLocationLoaded(
          position:
              LatLng(_currentPosition.latitude!, _currentPosition.longitude!),
        ),
      );
    });
  }
}

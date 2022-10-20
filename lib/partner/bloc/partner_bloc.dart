import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:suppwayy_mobile/partner/models/partner_list_model.dart';

import '../partner_repository.dart';

part 'partner_event.dart';
part 'partner_state.dart';

class PartnerBloc extends Bloc<PartnerEvent, PartnerState> {
  final PartnersService partnersService;
  PartnerBloc({required this.partnersService}) : super(PartnersInitialState()) {
    on<GetPartnersEvent>((event, emit) async {
      emit(PartnersLoading());
      try {
        var response = await partnersService.fetchPartners();
        if (response is PartnerListModel) {
          emit(PartnersLoaded(partners: response.partners));
        } else {
          emit(const PartnersLoadingError(error: ""));
        }
      } catch (e) {
        emit(PartnersLoadingError(error: e.toString()));
      }
    });
    on<AddPartnerEvent>((event, emit) async {
      emit(PartnersLoading());
      try {
        var response = await partnersService.addPartner(event.partnerData);
        if (response) {
          emit(PartnerCreated());
        }
      } catch (e) {
        // print(e);
        emit(PartnerCreationFailed(error: e.toString()));
      }
    });

    on<PatchPartner>((event, emit) async {
      emit(PartnersLoading());
      try {
        var response = await partnersService.patchPartner(
            event.partnerId, event.updatedPartnerData);
        if (response) {
          emit(PatchPartnerSuccess());
        }
      } catch (e) {
        emit(PatchPartnerError(error: e.toString()));
      }
    });

    on<DeletePartner>((event, emit) async {
      emit(PartnersLoading());
      try {
        var response = await partnersService.deletePartner(event.partnerId);
        if (response) {
          emit(DeletePartnerSuccess());
        }
      } catch (e) {
        emit(DeletePartnerError(error: e.toString()));
      }
    });

    on<PostPartnerAvatarEvent>((event, emit) async {
      emit(PartnersLoading());
      try {
        final response = await partnersService.postPartnerAvatar(
            event.avatar, event.partnerId);
        if (response) {
          emit(PatchPartnerSuccess());
        }
      } catch (e) {
        emit(PatchPartnerError(error: e.toString()));
      }
    });
  }
}

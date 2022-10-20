import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:suppwayy_mobile/profile/bloc/bloc/profile_bloc.dart';
import 'package:suppwayy_mobile/utils/choose_photo.dart';

import '../../suppwayy_config.dart';

class ProfilePhotoWidget extends StatelessWidget {
  const ProfilePhotoWidget({Key? key, required this.avatar}) : super(key: key);

  final String avatar;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        var response = await showChoiceDialog(context);
        if (response is XFile?) {
          BlocProvider.of<ProfileBloc>(context).add(
            PostPartnerAvatarEvent(avatar: response),
          );
        }
      },
      child: avatar.isNotEmpty
          ? CircleAvatar(
              radius: 50.0,
              backgroundImage: NetworkImage("${SuppWayy.baseUrl}/$avatar",
                  headers: BlocProvider.of<ProfileBloc>(context)
                      .profileService
                      .getHeadersWithAuthorization),
            )
          : const CircleAvatar(
              radius: 50.0,
              backgroundImage: AssetImage("assets/images/avatar.png"),
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:suppwayy_mobile/partner/bloc/partner_bloc.dart';
import 'package:suppwayy_mobile/partner/models/partner_list_model.dart';
import 'package:suppwayy_mobile/utils/choose_photo.dart';

import '../../suppwayy_config.dart';

class UserAvatarWidget extends StatelessWidget {
  const UserAvatarWidget(
      {Key? key, required this.avatar, required this.partner})
      : super(key: key);

  final String avatar;
  final Partner partner;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        var response = await showChoiceDialog(context);
        if (response is XFile?) {
          BlocProvider.of<PartnerBloc>(context).add(
            PostPartnerAvatarEvent(avatar: response, partnerId: partner.id),
          );
        }
      },
      child: avatar.isNotEmpty
          ? CircleAvatar(
              radius: 50.0,
              backgroundImage: NetworkImage(
                  "${SuppWayy.baseUrl}/${partner.photo}",
                  headers: BlocProvider.of<PartnerBloc>(context)
                      .partnersService
                      .getHeadersWithAuthorization),
            )
          : const CircleAvatar(
              radius: 50.0,
              backgroundImage: AssetImage("assets/images/avatar.png"),
            ),
    );
  }
}

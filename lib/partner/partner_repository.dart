import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

import 'package:image_picker/image_picker.dart';
import 'package:suppwayy_mobile/main_repository.dart';
import 'package:suppwayy_mobile/partner/models/partner_list_model.dart';
import 'package:suppwayy_mobile/suppwayy_config.dart';

class PartnersService extends MainRepository {
  Future<PartnerListModel> fetchPartners() async {
    Uri uri = Uri.parse(SuppWayy.getPartners);
    var response = await http.get(uri, headers: getHeadersWithAuthorization);

    if (response.statusCode == HttpStatus.ok) {
      final String rawPartnersList = response.body.toString();

      return PartnerListModel.fromJson(rawPartnersList);
    } else {
      throw Exception('Failed to load procucts ');
    }
  }

  Future<bool> addPartner(Partner partner) async {
    Uri uri = Uri.parse(SuppWayy.getPartners);
    String data = """{
            "name": "${partner.name}",
            "email": "${partner.email}",
            "phone": "${partner.phone}",
            "address": "${partner.address}",
            "website": "${partner.website}"
        }""";
    var headers = getHeadersWithAuthorization;
    headers["content-type"] = "application/json";

    var response = await http.post(uri, headers: headers, body: data);
    if (response.statusCode == HttpStatus.ok) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> patchPartner(int partnerId, Map updatedPartnerData) async {
    Uri uri = Uri.parse(SuppWayy.getPartners + '$partnerId');
    var headers = getHeadersWithAuthorization;
    headers["content-type"] = "application/json";
    var response = await http.patch(uri,
        headers: headers, body: jsonEncode(updatedPartnerData));
    if (response.statusCode == HttpStatus.ok) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deletePartner(int partnerId) async {
    Uri uri = Uri.parse(SuppWayy.getPartners + '$partnerId');
    var headers = getHeadersWithAuthorization;
    headers["content-type"] = "application/json";
    var response = await http.delete(uri, headers: headers);
    if (response.statusCode == HttpStatus.noContent) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> postPartnerAvatar(XFile? avatar, int partnerId) async {
    var stream = http.ByteStream(Stream.castFrom(avatar!.openRead()));
    var length = await avatar.length();

    var uri = Uri.parse(SuppWayy.getContactsPhoto(partnerId));
    var request = http.MultipartRequest("POST", uri);
    request.headers.addAll(getHeadersWithAuthorization);
    var multipartFile = http.MultipartFile('image', stream, length,
        filename: basename(avatar.path));
    request.files.add(multipartFile);
    var response = await request.send();

    if (response.statusCode == HttpStatus.created) {
      imageCache!.clear();
      imageCache!.clearLiveImages();
      return true;
    } else {
      throw Exception();
    }
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

import 'package:image_picker/image_picker.dart';
import 'package:suppwayy_mobile/partner/models/partner_list_model.dart';

import '../main_repository.dart';
import '../suppwayy_config.dart';
import 'package:http/http.dart' as http;

class ProfileService extends MainRepository {
  MainRepository mainRepository = MainRepository();

  /// Get User Information of Profile
  Future<Partner> getUserProfile() async {
    final uri = Uri.parse(SuppWayy.profile);

    var response = await http.get(uri, headers: getHeadersWithAuthorization);
    if (response.statusCode == HttpStatus.ok) {
      var jsonResponse = jsonDecode(response.body);
      return Partner.fromMap(jsonResponse);
    } else {
      throw Exception('Failed to load profile ');
    }
  }

  /// Get User Information of Profile
  Future<bool> patchUserProdile(Map updateUserData) async {
    final uri = Uri.parse(SuppWayy.profile);
    var headers = getHeadersWithAuthorization;
    headers["content-type"] = "application/json";

    var response = await http.patch(uri,
        headers: headers, body: jsonEncode(updateUserData));
    if (response.statusCode == HttpStatus.ok) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> postProfilePhoto(XFile? avatar) async {
    var stream = http.ByteStream(Stream.castFrom(avatar!.openRead()));
    var length = await avatar.length();

    var uri = Uri.parse(SuppWayy.profilePhoto);

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

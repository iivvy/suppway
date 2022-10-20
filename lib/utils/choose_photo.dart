import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:image_picker/image_picker.dart';

Future<XFile?> _openGallery(BuildContext context) async {
  final _picker = ImagePicker();
  final XFile? pickedImage =
      await _picker.pickImage(source: ImageSource.gallery);
  if (pickedImage != null) {
    return pickedImage;
  }
}

Future<XFile?> _openCamera(BuildContext context) async {
  final _picker = ImagePicker();
  final XFile? pickedImage =
      await _picker.pickImage(source: ImageSource.camera);
  if (pickedImage != null) {
    return pickedImage;
  }
}

showChoiceDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            translate("upload.choose_option"),
            style: TextStyle(color: Colors.blue),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                const Divider(
                  height: 1,
                  color: Colors.blue,
                ),
                ListTile(
                  onTap: () async {
                    var response = await _openGallery(context);

                    if (response is XFile?) {
                      Navigator.pop(context, response);
                    }
                  },
                  title: Text(translate("upload.gallery")),
                  leading: const Icon(
                    Icons.account_box,
                    color: Colors.blue,
                  ),
                ),
                const Divider(
                  height: 1,
                  color: Colors.blue,
                ),
                ListTile(
                  onTap: () async {
                    var response = await _openCamera(context);

                    if (response is XFile?) {
                      Navigator.pop(context, response);
                    }
                  },
                  title: Text(translate("upload.camera")),
                  leading: const Icon(
                    Icons.camera,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ImagepickerServices {
  File? image;
  Future<File?> pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return null;
      final imageTemp = File(image.path);
      return imageTemp;
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }
}

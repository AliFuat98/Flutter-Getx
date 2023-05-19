import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

ImageProvider getImage(bool isnew, String src) {
  try {
    final file = File(src);
    if (isnew) {
      var check = file.existsSync();
      if (!check) {
        return const AssetImage("assets/images/game/mark.png");
      }
    }
    return isnew ? FileImage(file) as ImageProvider : AssetImage(src);
  } catch (e) {
    return const AssetImage("assets/images/game/mark.png");
  }
}

void deleteFile(String path) {
  try {
    final file = File(path);
    if (file.existsSync()) {
      file.deleteSync();
    }
  } catch (e) {
    return;
  }
}

Future<String?> savePermenantTheImageAndGetThePath(String? path) async {
  try {
    if (path == null) {
      return null;
    }
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(path);
    final image = File('${directory.path}/$name');

    var newfile = await File(path).copy(image.path);

    return newfile.path;
  } catch (e) {
    return null;
  }
}

Future<String?> pickImage(ImageSource soruce) async {
  try {
    final image = await ImagePicker().pickImage(
      source: soruce,
    );
    if (image == null) return null;

    return image.path;
  } on PlatformException catch (e) {
    return null;
  }
}

Future<String?> savePermenantTheAudioAndGetThePath(
    String? inputFilepath) async {
  try {
    if (inputFilepath == null) {
      return null;
    }
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(inputFilepath);
    final outputFilePath = File('${directory.path}/$name.wav');

    return outputFilePath.path;
  } catch (e) {
    return null;
  }
}
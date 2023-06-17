import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

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

Source? getAudioSource(bool isnew, String src) {
  try {
    final file = File(src);
    if (isnew) {
      var check = file.existsSync();
      if (!check) {
        return null;
      }
    }
    return isnew ? DeviceFileSource(src) : AssetSource(src);
  } catch (e) {
    return null;
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

Future<String?> saveFilePermenantAndGetThePath(String? inputFilepath,
    {String? recordName = "Test"}) async {
  try {
    if (inputFilepath == null) {
      return null;
    }
    final directory = await getApplicationDocumentsDirectory();

    final ext = extension(inputFilepath);
    var uuid = const Uuid();
    final name = '$recordName-${uuid.v4()}$ext';
    String outputFilePath = '${directory.path}/$name';

    final inputFile = File(inputFilepath);
    await inputFile.copy(outputFilePath);

    return outputFilePath;
  } catch (e) {
    return null;
  }
}

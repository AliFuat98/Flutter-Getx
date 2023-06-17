import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:first_app/app/data/models/category.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class ListenwordController extends GetxController {
  late Category selectedCategory;
  final currentWordIndex = 0.obs;
  final pronunciationScore = "".obs;
  final recorder = FlutterSoundRecorder();
  late final String iosFile;
  late final String androidFile;
  late String recordedFileName;
  late final directory;

  @override
  void onInit() async {
    super.onInit();
    selectedCategory = Get.arguments as Category;
    initRecorder();
    directory = await getApplicationDocumentsDirectory();
    iosFile = '${directory.path}/recording.wav';
    androidFile = '${directory.path}/recording.m4a';
  }

  void initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      print("Permission is not granted");
    } else {
      await recorder.openRecorder();
    }
  }

  double getProgress() {
    return (currentWordIndex.value + 1) / selectedCategory.words.length;
  }

  void decreaseCurrentWordIndex() {
    if (currentWordIndex.value <= 0) {
      return;
    }
    currentWordIndex.value--;
  }

  Future<void> startRecording() async {
    if (Platform.isIOS) {
      await recorder.startRecorder(toFile: iosFile, codec: Codec.pcm16WAV);
      recordedFileName = "recording.wav";
    } else if (Platform.isAndroid) {
      await recorder.startRecorder(toFile: androidFile, codec: Codec.aacMP4);
      recordedFileName = "recording.m4a";
    }
  }

  Future<String> stopRecording() async {
    final path = await recorder.stopRecorder();
    return path!;
  }

  void handleButtonPress() async {
    if (recorder.isRecording) {
      String path = await stopRecording();
      handleScoreCalculationRequest(path);
    } else {
      startRecording();
    }
  }

  void handleScoreCalculationRequest(String recorded_audio_path) async {
    var word = selectedCategory.words[currentWordIndex.value];
    //var url = Uri.parse('http://127.0.0.1:5000');
    //var url = Uri.parse('http://10.0.2.2:5000');
    var request = http.MultipartRequest(
        "POST",
        Uri.parse(
            "http://${Platform.isAndroid ? "10.0.2.2" : "127.0.0.1"}:5000/"));
    File recordedAudioFile = File(recorded_audio_path);
    Uint8List audioBytes = recordedAudioFile.readAsBytesSync();
    var testAudio = http.MultipartFile.fromBytes("audio", audioBytes,
        filename: recordedFileName);
    String referenceAudioPath = word.audioSrc;
    String referenceFileName = referenceAudioPath.split('/').last;
    ByteData referenceData;
    if (word.isNew) {
      var file = File(word.audioSrc);
      ByteBuffer buffer = Uint8List.fromList(await file.readAsBytes()).buffer;
      referenceData = ByteData.view(buffer);
    } else {
      referenceData = await rootBundle.load("assets/${word.audioSrc}");
    }

    List<int> referenceBytes = referenceData.buffer.asUint8List();
    var referenceAudio = http.MultipartFile.fromBytes(
        "reference", referenceBytes,
        filename: referenceFileName);
    request.files.add(testAudio);
    request.files.add(referenceAudio);
    request.fields["word"] = word.name;

    var flag = word.isNew ? "1" : "0";
    request.fields["flag"] = flag;

    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var result = utf8.decode(responseData);
    pronunciationScore.value = result;
    pronunciationScore.refresh();
  }

  double getPersant() {
    var list = pronunciationScore.value.split("+");
    if (list.length <= 1) {
      return 0.0;
    }
    return double.parse(list.elementAt(1));
  }

  void increaseCurrentWordIndex() {
    if (currentWordIndex.value >= selectedCategory.words.length - 1) {
      return;
    }
    currentWordIndex.value++;
  }
}

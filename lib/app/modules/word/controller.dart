import 'package:first_app/app/widgets/file_operations.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wav/wav.dart';

class WordController extends GetxController {
  final Rx<FlutterSoundRecorder> recorder = Rx(FlutterSoundRecorder());
  final wordAudioFilePath = Rx<String?>(null);
  final wordImageFilePath = Rx<String?>(null);

  @override
  void onInit() async {
    super.onInit();
    initRecorder();
  }

  @override
  void onClose() {
    super.onClose();
    recorder.value.closeRecorder();
  }

  Future initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw 'microfon is not granted';
    }

    final opened = await recorder.value.openRecorder();
    if (opened == null) {
      return;
    }
    recorder.value = opened;

    recorder.value.setSubscriptionDuration(const Duration(microseconds: 500));
  }

  Future stop() async {
    final cachPath = await recorder.value.stopRecorder();
    //final perminantPath = await savePermenantTheAudioAndGetThePath(cachPath);
    print('audio path is cach ----------------- $cachPath');
    //print('audio path is perminant----------------- $perminantPath');

    //wordAudioFilePath.value = perminantPath;
    wordAudioFilePath.value = cachPath;

    recorder.refresh();
  }

  Future record() async {
    await recorder.value.startRecorder(toFile: "xx.aac", codec: Codec.aacADTS);
    recorder.refresh();
  }
}

import 'package:first_app/app/data/models/category.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

class ListenwordController extends GetxController {
  late Category selectedCategory;
  final currentWordIndex = 0.obs;
  final pronunciationScore = 0.0.obs;
  final recorder = FlutterSoundRecorder();
  late final String file ;
  late final directory ;

  @override
  void onInit() async {
    super.onInit();
    selectedCategory = Get.arguments as Category;
    initRecorder();
    directory = await getApplicationDocumentsDirectory();
    file = '${directory.path}/recording.wav';
  }

  void initRecorder() async{
    final status = await Permission.microphone.request();
    if(status != PermissionStatus.granted){
      print("Permission is not granted");
    }
    else{
      await recorder.openRecorder();
    }
  }
  void decreaseCurrentWordIndex() {
    if (currentWordIndex.value <= 0) {
      return;
    }
    currentWordIndex.value--;
  }

  Future<void> startRecording() async {
    await recorder.startRecorder(toFile: file);

  }
  Future<void> stopRecording() async {
    final path = await recorder.stopRecorder();
    print(path);
  }
  void handleButtonPress(){
    if(recorder.isRecording){
      stopRecording();
    }
    else{
      startRecording();
    }
  }

  void handleRequest()
  {

  }


  void increaseCurrentWordIndex() {
    if (currentWordIndex.value >= selectedCategory.words.length - 1) {
      return;
    }
    currentWordIndex.value++;
  }
}

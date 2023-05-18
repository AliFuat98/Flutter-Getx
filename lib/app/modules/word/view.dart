import 'package:audioplayers/audioplayers.dart';
import 'package:first_app/app/core/utils/extensions.dart';
import 'package:first_app/app/data/models/category.dart';
import 'package:first_app/app/modules/category/controller.dart';
import 'package:first_app/app/modules/word/controller.dart';
import 'package:first_app/app/modules/word/widgets/add_word.dart';
import 'package:first_app/app/widgets/file_operations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class WordPage extends GetView<WordController> {
  WordPage({super.key});

  static const pageName = "/word";

  final categoryController = Get.find<CategoryController>();

  AudioPlayer audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    var category = categoryController.selectedCategory.value!;
    var color = Colors.black;

    return Scaffold(
      body: Column(
        children: [
          backButton(),
          categoryImageAndName(color, category),
          //wordNameTextField(),
          getWordsList(category),
        ],
      ),
      floatingActionButton: addWordButton(),
    );
  }

  Widget addWordButton() {
    final category = categoryController.selectedCategory.value;
    return FloatingActionButton(
      onPressed: () {
        if (category == null) return;
        Get.toNamed(AddWord.pageName);
      },
      backgroundColor: Colors.blue,
      child: const Icon(Icons.add),
    );
  }

  Widget backButton() {
    return Padding(
      padding: EdgeInsets.all(3.0.wp),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Get.back();
              categoryController.changeSelectedCategory(null);
              categoryController.editController.clear();
            },
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
        ],
      ),
    );
  }

  Widget categoryImageAndName(Color color, Category category) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0.wp),
      child: Row(
        children: [
          Image(
            image: getImage(category.isNew, category.pictureSrc),
            width: 10.0.wp,
            height: 10.0.wp,
          ),
          SizedBox(width: 3.0.wp),
          Text(
            category.name,
            style: TextStyle(
              fontSize: 12.0.sp,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }

  Widget wordNameTextField() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0.wp, horizontal: 5.0.wp),
      child: TextFormField(
        controller: categoryController.editController,
        autofocus: true,
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[400]!),
          ),
          prefixIcon: Icon(
            Icons.check_box_outline_blank,
            color: Colors.grey[400],
          ),
          suffixIcon: IconButton(
            onPressed: () {
              if (categoryController.fromKey.currentState!.validate()) {
                var success = categoryController
                    .addWord(categoryController.editController.text);
                if (success) {
                  EasyLoading.showSuccess("words is added");
                } else {
                  EasyLoading.showError("word couldn't be added");
                }
                categoryController.editController.clear();
              }
            },
            icon: const Icon(Icons.done),
          ),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return "Please enter your word";
          }
          return null;
        },
      ),
    );
  }

  Widget getWordsList(Category category) {
    return Flexible(
      child: Padding(
        padding: EdgeInsets.all(5.0.wp),
        child: ListView.builder(
          itemCount: category.words.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: Key(category.words[index].wordID.toString()),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                // delete the word
              },
              background: Container(
                alignment: AlignmentDirectional.centerEnd,
                color: Colors.red,
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 0.0),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(category.words[index].pictureSrc),
                ),
                title: Text(category.words[index].name),
                trailing: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    elevation: 0,
                  ),
                  onPressed: () {
                    audioPlayer
                        .play(AssetSource(category.words[index].audioSrc));
                  },
                  child: const Icon(
                    Icons.play_arrow_outlined,
                    size: 20,
                    color: const Color.fromARGB(255, 10, 74, 185),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

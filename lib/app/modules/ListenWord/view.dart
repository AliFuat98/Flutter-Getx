import 'package:first_app/app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class ListenWordPage extends GetView<ListenwordController> {
  ListenWordPage({super.key});

  static const pageName = "/listenWord";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        title: const Text('Listen Words'),
      ),
      body: Column(
        children: [
          SizedBox(height: 5.0.hp),
          Stack(
            children: [
              Container(
                height: 50.0.wp,
                width: 50.0.wp,
                decoration: BoxDecoration(
                    border: Border.all(width: 5, color: Colors.purple),
                    color: Colors.lightGreenAccent),
                child: Image.asset('assets/images/apple.png'),
              )
            ],
          ),
          SizedBox(height: 5.0.hp),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Apple",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30.0.sp,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                      shadows: const [
                        Shadow(
                            color: Colors.purple,
                            offset: Offset(1, 2),
                            blurRadius: 4)
                      ]))
            ],
          ),
          SizedBox(height: 5.0.hp),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple, // Background color
                ),
                child: Text(
                  'Hear',
                  style: TextStyle(
                    fontSize: 30.0.sp,
                  ),
                ),
              ),
              FloatingActionButton.large(
                onPressed: () {},
                backgroundColor: Colors.green,
                child: const Icon(Icons.play_arrow),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple, // Background color
                ),
                child: Text(
                  'Spell',
                  style: TextStyle(
                    fontSize: 30.0.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5.0.hp),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton.large(
                onPressed: () {},
                backgroundColor: Colors.red,
                child: const Icon(Icons.mic),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

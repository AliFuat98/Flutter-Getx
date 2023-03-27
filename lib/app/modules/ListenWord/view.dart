import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class ListenWordPage extends GetView<ListenwordController> {
  ListenWordPage({super.key});

  static const pageName = "/listenWord";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.amber,
        appBar: AppBar(
          title: const Text('Listen Words'),
        ),
        body: Column(
          children: [
            SizedBox(height: 15),
            Stack(
              children: [
                Container(
                  height: 230,
                  width: 300,
                  decoration: BoxDecoration(
                      border: Border.all(width: 5, color: Colors.purple),
                      color: Colors.lightGreenAccent),
                  child: Image.asset('assets/images/apple.png'),
                )
              ],
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("Apple",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 70,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal,
                        shadows: [
                          Shadow(
                              color: Colors.purple,
                              offset: Offset(1, 2),
                              blurRadius: 4)
                        ]))
              ],
            ),
            const SizedBox(height: 75),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple, // Background color
                  ),
                  child: const Text(
                    'Hear',
                    style: TextStyle(fontSize: 50),
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
                  child: const Text(
                    'Spell',
                    style: TextStyle(fontSize: 50),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 75),
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
      ),
    );
  }
}

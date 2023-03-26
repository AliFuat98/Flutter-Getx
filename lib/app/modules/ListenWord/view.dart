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
        appBar: AppBar(
          title: const Text('Listen Words'),
        ),
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 230,
                  width: 300,
                  decoration: BoxDecoration(
                    border: Border.all(width: 5, color: Colors.purple),
                  ),
                  child: Image.asset('assets/images/map.jpg'),
                )
              ],
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Map',
                  style: TextStyle(height: 1, fontSize: 50),
                )
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
                    style: TextStyle(fontSize: 40),
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
                    style: TextStyle(fontSize: 40),
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

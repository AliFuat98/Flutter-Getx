import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Content {
  final String title;
  final int price;
  final String image;
  final String category;

  Content({
    required this.title,
    required this.price,
    required this.image,
    required this.category,
  });
}

class StoreController extends GetxController {
  var earnedPoints = 500.obs;
  var availableContents = <Content>[
    Content(
      title: 'Ürün 1',
      price: 50,
      image: 'assets/images/apple.png',
      category: 'Resim',
    ),
    Content(
      title: 'Ürün 2',
      price: 75,
      image: 'assets/images/apple.png',
      category: 'Müzik',
    ),
    Content(
      title: 'Ürün 3',
      price: 100,
      image: 'assets/images/apple.png',
      category: 'Animasyon',
    ),
    Content(
      title: 'Ürün 4',
      price: 120,
      image: 'assets/images/apple.png',
      category: 'Video',
    ),
    Content(
      title: 'Ürün 5',
      price: 80,
      image: 'assets/images/apple.png',
      category: 'Resim',
    ),
    Content(
      title: 'Ürün 6',
      price: 90,
      image: 'assets/images/apple.png',
      category: 'Müzik',
    ),
    Content(
      title: 'Ürün 7',
      price: 110,
      image: 'assets/images/apple.png',
      category: 'Animasyon',
    ),
    Content(
      title: 'Ürün 8',
      price: 70,
      image: 'assets/images/apple.png',
      category: 'Video',
    ),
    Content(
      title: 'Ürün 9',
      price: 60,
      image: 'assets/images/apple.png',
      category: 'Resim',
    ),
    Content(
      title: 'Ürün 10',
      price: 95,
      image: 'assets/images/apple.png',
      category: 'Müzik',
    ),
// Additional contents
    Content(
      title: 'Ürün 11',
      price: 50,
      image: 'assets/images/apple.png',
      category: 'Sticker',
    ),
    Content(
      title: 'Ürün 12',
      price: 75,
      image: 'assets/images/apple.png',
      category: 'Video',
    ),
    Content(
      title: 'Ürün 13',
      price: 100,
      image: 'assets/images/apple.png',
      category: 'Avatar',
    ),
    Content(
      title: 'Ürün 14',
      price: 120,
      image: 'assets/images/apple.png',
      category: 'Müzik',
    ),
    Content(
      title: 'Ürün 15',
      price: 80,
      image: 'assets/images/apple.png',
      category: 'Rozet',
    ),
    Content(
      title: 'Ürün 16',
      price: 90,
      image: 'assets/images/apple.png',
      category: 'Animasyon',
    ),
    Content(
      title: 'Ürün 17',
      price: 110,
      image: 'assets/images/apple.png',
      category: 'Sticker',
    ),
    Content(
      title: 'Ürün 18',
      price: 70,
      image: 'assets/images/apple.png',
      category: 'Video',
    ),
    Content(
      title: 'Ürün 19',
      price: 60,
      image: 'assets/images/apple.png',
      category: 'Avatar',
    ),
    Content(
      title: 'Ürün 20',
      price: 95,
      image: 'assets/images/apple.png',
      category: 'Müzik',
    ),
    Content(
      title: 'Ürün 21',
      price: 50,
      image: 'assets/images/apple.png',
      category: 'Sticker',
    ),
    Content(
      title: 'Ürün 22',
      price: 75,
      image: 'assets/images/apple.png',
      category: 'Rozet',
    ),
    Content(
      title: 'Ürün 23',
      price: 100,
      image: 'assets/images/apple.png',
      category: 'Video',
    ),
    Content(
      title: 'Ürün 24',
      price: 120,
      image: 'assets/images/apple.png',
      category: 'Müzik',
    ),
    Content(
      title: 'Ürün 25',
      price: 80,
      image: 'assets/images/apple.png',
      category: 'Animasyon',
    ),
    Content(
      title: 'Ürün 26',
      price: 90,
      image: 'assets/images/apple.png',
      category: 'Avatar',
    ),
    Content(
      title: 'Ürün 27',
      price: 110,
      image: 'assets/images/apple.png',
      category: 'Sticker',
    ),
    Content(
      title: 'Ürün 28',
      price: 70,
      image: 'assets/images/apple.png',
      category: 'Müzik',
    ),
    Content(
      title: 'Ürün 29',
      price: 60,
      image: 'assets/images/apple.png',
      category: 'Rozet',
    ),
    Content(
      title: 'Ürün 30',
      price: 95,
      image: 'assets/images/apple.png',
      category: 'Animasyon',
    ),
  ].obs;
  var purchasedContents = <Content>[].obs;
  var categories = <String>[
    'Tüm Kategoriler',
    'Resim',
    'Müzik',
    'Animasyon',
    'Video',
    'Sticker',
    'Avatar',
    'Rozet',
  ];
  var selectedCategory = 'Tüm Kategoriler'.obs;
  var filteredContents = <Content>[].obs;

  @override
  void onInit() {
    super.onInit();
    filterByCategory(selectedCategory.value);
  }

  void buyContent(Content content) {
    if (earnedPoints.value >= content.price &&
        !purchasedContents.contains(content)) {
      earnedPoints.value -= content.price;
      purchasedContents.add(content);
      availableContents.remove(content);
    } else {
      Get.dialog(
        AlertDialog(
          title: Text('Yetersiz Puan'),
          content: Text(
            'Bu içeriği almak için yeterli puanınız yok veya daha önce satın alınmış.',
          ),
          actions: [
            TextButton(
              child: Text('Tamam'),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        ),
      );
    }
  }

  void filterByCategory(String? category) {
    if (category == null || category == 'Tüm Kategoriler') {
      filteredContents.assignAll(availableContents);
    } else {
      filteredContents.assignAll(
        availableContents.where((content) => content.category == category),
      );
    }
    selectedCategory.value = category ?? 'Tüm Kategoriler';
  }

  bool isContentPurchased(Content content) {
    return purchasedContents.contains(content);
  }

  canAffordContent(Content content) {
    return earnedPoints.value >= content.price;
  }
}

// Usage example
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Store App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StorePage(),
    );
  }
}

class StorePage extends StatelessWidget {
  final StoreController storeController = Get.put(StoreController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Store'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            child: DropdownButton(
              value: storeController.selectedCategory.value,
              items: storeController.categories.map((String category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? selectedCategory) {
                storeController.filterByCategory(selectedCategory);
              },
            ),
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: storeController.filteredContents.length,
                itemBuilder: (context, index) {
                  Content content = storeController.filteredContents[index];
                  return ListTile(
                    leading: Image.asset(content.image),
                    title: Text(content.title),
                    subtitle: Text('Price: ${content.price}'),
                    trailing: ElevatedButton(
                      child: Text('Buy'),
                      onPressed: () {
                        storeController.buyContent(content);
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

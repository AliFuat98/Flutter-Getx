import 'package:first_app/app/core/utils/DataHelper.dart';
import 'package:first_app/app/data/models/content.dart';
import 'package:first_app/app/data/models/user.dart';
import 'package:first_app/app/data/services/content/content_repository.dart';
import 'package:first_app/app/data/services/user/user_reposiory.dart';
import 'package:get/get.dart';

class StoreController extends GetxController {
  ContentRepository contentRepository;
  UserRepository userRepository;

  StoreController({
    required this.contentRepository,
    required this.userRepository,
  });

  var earnedCoins = 0.obs;
  var availableContents = <Content>[].obs;
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
  var selectedCategory = 0.obs;
  var filteredContents = <Content>[].obs;
  final selectedContent = Rx<Content?>(null);

  @override
  void onInit() async {
    super.onInit();
    // get coin data
    User user = await userRepository.readUser();
    earnedCoins.value = user.coin;

    // fill contents
    List<Content> data = await contentRepository.readContents();
    availableContents.assignAll(
        data.where((content) => content.isPurchased == false).toList());
    purchasedContents.assignAll(
        data.where((content) => content.isPurchased == true).toList());
    filterByCategory(0);
  }

  void buyContent(Content content) async {
    if (earnedCoins.value >= content.price &&
        !purchasedContents.contains(content)) {
      earnedCoins.value -= content.price;
      purchasedContents.add(content);
      availableContents.remove(content);

      filterByCategory(selectedCategory.value);

      // update user conins
      User user = await userRepository.readUser();
      user.coin -= content.price;
      await DataHelper.instance.update("User", user);

      // update content
      content.isPurchased = true;
      await DataHelper.instance.update("Content", content);
    }
  }

  void filterByCategory(int categoryIndex) {
    if (categoryIndex == 0) {
      filteredContents.assignAll(availableContents);
    } else {
      filteredContents.assignAll(
        availableContents.where((content) => content.category == categoryIndex),
      );
    }
    selectedCategory.value = categoryIndex;
  }

  bool isContentPurchased(Content content) {
    return purchasedContents.contains(content);
  }

  canAffordContent(Content content) {
    return earnedCoins.value >= content.price;
  }
}

// Usage example
// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'Store App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: StorePage(),
//     );
//   }
// }

// class StorePage extends StatelessWidget {
//   final StoreController storeController = Get.put(StoreController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Store'),
//       ),
//       body: Column(
//         children: [
//           Container(
//             padding: EdgeInsets.all(16.0),
//             child: DropdownButton(
//               value: storeController.selectedCategory.value,
//               items: storeController.categories.map((String category) {
//                 return DropdownMenuItem(
//                   value: category,
//                   child: Text(category),
//                 );
//               }).toList(),
//               onChanged: (String? selectedCategory) {
//                 storeController.filterByCategory(selectedCategory);
//               },
//             ),
//           ),
//           Expanded(
//             child: Obx(
//               () => ListView.builder(
//                 itemCount: storeController.filteredContents.length,
//                 itemBuilder: (context, index) {
//                   Content content = storeController.filteredContents[index];
//                   return ListTile(
//                     leading: Image.asset(content.image),
//                     title: Text(content.title),
//                     subtitle: Text('Price: ${content.price}'),
//                     trailing: ElevatedButton(
//                       child: Text('Buy'),
//                       onPressed: () {
//                         storeController.buyContent(content);
//                       },
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

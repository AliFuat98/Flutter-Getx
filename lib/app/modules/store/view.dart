import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class StorePage extends GetWidget<StoreController> {
  StorePage({Key? key}) : super(key: key);

  static const pageName = "/store";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageName),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Obx(
              () => Row(
                children: [
                  Icon(
                    Icons.attach_money,
                    color: Colors.amber,
                  ),
                  SizedBox(width: 5.0),
                  Text(
                    '${controller.earnedPoints.value}',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: 'Ürünler'),
                Tab(text: 'Satın Alınan İçerikler'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              buildProductTab(),
              buildPurchasedItemsTab(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProductTab() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Kategori: ',
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 10.0),
          Align(
            alignment: Alignment.center,
            child: Wrap(
              spacing: 8.0,
              alignment: WrapAlignment.center,
              children: controller.categories.map((category) {
                final categoryColor = Colors.primaries[
                    controller.categories.indexOf(category) %
                        Colors.primaries.length];

                return GestureDetector(
                  onTap: () => controller.filterByCategory(category),
                  child: Chip(
                    label: Text(category),
                    backgroundColor: categoryColor,
                    labelStyle: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 20.0),
          Align(
            alignment: Alignment.center,
            child: Text(
              'Ürünler',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          SizedBox(height: 10.0),
          Expanded(
            child: Obx(
              () {
                final sortedContents = controller.filteredContents.toList()
                  ..sort((a, b) => a.price.compareTo(b.price));

                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.9,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemCount: sortedContents.length,
                  itemBuilder: (context, index) {
                    final content = sortedContents[index];
                    final categoryColor = Colors.primaries[
                        controller.categories.indexOf(content.category) %
                            Colors.primaries.length];

                    final isContentPurchased =
                        controller.isContentPurchased(content);
                    final opacity = isContentPurchased ? 0.0 : 1.0;
                    final height = isContentPurchased ? 0.0 : null;

                    final canAffordContent =
                        controller.canAffordContent(content);
                    final buttonColor =
                        canAffordContent ? Colors.green : Colors.red;
                    final buttonText = canAffordContent ? 'Satın Al' : '';

                    return AnimatedOpacity(
                      opacity: opacity,
                      duration: Duration(milliseconds: 300),
                      child: GestureDetector(
                        onTap: () {
                          if (!isContentPurchased) {
                            controller.buyContent(content);
                            // Redirect to purchased items tab
                            DefaultTabController.of(context)!.animateTo(1);
                          }
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          height: height,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: categoryColor,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.asset(
                                    content.image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      content.title,
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Colors.white, // Ürün adının rengi
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 5.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.monetization_on,
                                          size: 16.0,
                                          color: Colors.amber,
                                        ),
                                        SizedBox(width: 5.0),
                                        Text(
                                          'Puan: ${content.price}',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.amber, // Puanın rengi
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5.0),
                                    ElevatedButton(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          if (!canAffordContent)
                                            Icon(
                                              Icons.lock,
                                              color: Colors.white,
                                              size: 20.0,
                                            ),
                                          SizedBox(width: 5.0),
                                          Text(buttonText),
                                        ],
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        primary: canAffordContent
                                            ? Colors.green
                                            : Colors.red,
                                        textStyle: TextStyle(fontSize: 14.0),
                                      ),
                                      onPressed: canAffordContent
                                          ? () {
                                              controller.buyContent(content);
                                              // Redirect to purchased items tab
                                              DefaultTabController.of(context)!
                                                  .animateTo(1);
                                            }
                                          : null,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPurchasedItemsTab() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              'Satın Alınan İçerikler',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          SizedBox(height: 10.0),
          Expanded(
            child: Obx(
              () => GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.9,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: controller.purchasedContents.length,
                itemBuilder: (context, index) {
                  final content = controller.purchasedContents[index];
                  final categoryColor = Colors.primaries[
                      controller.categories.indexOf(content.category) %
                          Colors.primaries.length];

                  return Card(
                    color: categoryColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              content.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                content.title,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white, // Ürün adının rengi
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 5.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.monetization_on,
                                    size: 16.0,
                                    color: Colors.amber,
                                  ),
                                  SizedBox(width: 5.0),
                                  Text(
                                    'Puan: ${content.price}',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.amber, // Puanın rengi
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5.0),
                              Text(
                                'Kategori: ${content.category}',
                                style: TextStyle(fontSize: 14.0),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
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

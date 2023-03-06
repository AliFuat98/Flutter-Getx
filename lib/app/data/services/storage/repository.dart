import 'package:first_app/app/data/providers/category/provider.dart';

import '../../models/category.dart';

class CategoryRepository {
  CategoryProvider categoryProvider;

  CategoryRepository({
    required this.categoryProvider,
  });

  List<Category> readCategories() => categoryProvider.readCategories();
  void writeCategories(List<Category> categories) =>
      categoryProvider.writeCategories(categories);
}

import 'package:flutter/cupertino.dart';
import 'package:shopping/models/category-list-item.model.dart';
import 'package:shopping/models/product-list-item.model.dart';
import 'package:shopping/repositories/category.repository.dart';
import 'package:shopping/repositories/product.repository.dart';
import 'package:flutter/widgets.dart';

class HomeBloc extends ChangeNotifier {
  final categoryRepository = new CategoryRepository();
  final productRepository = new ProductRepository();

  List<ProductListItemModel> products;
  List<CategoryListItemModel> categories;

  String selectedCagetory = 'todos';

  HomeBloc() {
    this.getCategories();
    this.getProducts();
  }

  getCategories() {
    categoryRepository.getAll().then((data) {
      this.categories = data;
      notifyListeners();
    });
  }

  getProducts() {
    productRepository.getAll().then((data) {
      this.products = data;
      notifyListeners();
    });
  }

  getProductByCategory() {
    productRepository.getByCategory(selectedCagetory).then((data) {
      this.products = data;
      notifyListeners();
    });
  }

  changeCategory(tag) {
    selectedCagetory = tag;
    products = null;
    getProductByCategory();
  }
}

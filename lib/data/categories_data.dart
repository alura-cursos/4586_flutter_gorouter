import 'package:flutter_gorouter/models/category.dart';

abstract class CategoriesData {
  static List<CategoryModel> listCategories = [
    CategoryModel(name: "Petiscos"),
    CategoryModel(name: "Principais"),
    CategoryModel(name: "Massas"),
    CategoryModel(name: "Sobremesas"),
    CategoryModel(name: "Bebidas"),
  ];
}

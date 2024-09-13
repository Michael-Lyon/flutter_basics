import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_practice/models/products.dart';

// DEMO PRODUCTS
final _products = [
  Product(name: 'iPhone', price: 999),
  Product(name: 'cookie', price: 2),
  Product(name: 'ps5', price: 500),
];

// These once are mutable
final productSortTypeProvider = StateProvider<ProductSortType>((ref) {
  return ProductSortType.name;
});

// The state provider can be use in the product provider to sort products out

// state providers can't be changed/modified. They're there to serve as constants
final productProvider = Provider<List<Product>>((ref) {
  final sortType = ref.watch(productSortTypeProvider);
  switch (sortType) {
    case ProductSortType.name:
      _products.sort((a, b) => a.name.compareTo(b.name));
      break;
    case ProductSortType.price:
      _products.sort((a, b) => a.price.compareTo(b.price));
      break;
  }
  return _products;
});

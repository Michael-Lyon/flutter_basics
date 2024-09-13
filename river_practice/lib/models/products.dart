// Product model

class Product {
  Product({required this.name, required this.price});

  final String name;
  final double price;
}

//FILTER ENUM
enum ProductSortType {
  name,
  price,
}


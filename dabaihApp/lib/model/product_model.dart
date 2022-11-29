class Product {
  final int id;
  final String productName;
  final String productImage;
  final String productWeight;
  final int productPrice;
  final int categoryId;
  final String showToUser;

  Product({
    required this.id,
    required this.productName,
    required this.productImage,
    required this.productWeight,
    required this.productPrice,
    required this.categoryId,
    required this.showToUser,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "productName": productName,
      "productImage": productImage,
      "productWeight": productWeight,
      "productPrice": productPrice,
      "categoryId": categoryId,
      "showToUser": showToUser,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      productName: json['productName'],
      productImage: json['productImage'],
      productWeight: json['productWeight'],
      productPrice: json['productPrice'],
      categoryId: json['categoryId'],
      showToUser: json['showToUser'],
    );
  }
}

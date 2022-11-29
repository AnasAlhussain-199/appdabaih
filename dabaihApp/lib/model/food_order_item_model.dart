import 'product_model.dart';

class FoodOrderItem {
  final String id;
  final Product product;
  final String productDetails;
  final String cookType;
  final String riceType;
  final String foodType;
  final int plateNumber;
  final String productDate;
  final String productTime;
  final String productNote;

  FoodOrderItem({
    required this.id,
    required this.product,
    required this.productDetails,
    required this.cookType,
    required this.riceType,
    required this.foodType,
    required this.plateNumber,
    required this.productDate,
    required this.productTime,
    required this.productNote,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "product": product.toMap(),
      "productDetails": productDetails,
      "cookType": cookType,
      "riceType": riceType,
      "foodType": foodType,
      "plateNumber": plateNumber,
      "productDate": productDate,
      "productTime": productTime,
      "productNote": productNote,
    };
  }

  factory FoodOrderItem.fromJson(Map<String, dynamic> json) {
    return FoodOrderItem(
      id: json['id'],
      product: Product.fromJson(json['product']),
      productDetails: json['productDetails'],
      cookType: json['cookType'],
      riceType: json['riceType'],
      foodType: json['foodType'],
      plateNumber: json['plateNumber'],
      productDate: json['productDate'],
      productTime: json['productTime'],
      productNote: json['productNote'],
    );
  }
}

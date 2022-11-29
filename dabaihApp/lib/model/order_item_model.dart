import 'product_model.dart';

class OrderItem {
  final String id;
  final Product product;
  final String productCut;
  final String productPrepare;
  final String productHead;
  final String productBody;
  final String productShredder;
  final int productQty;
  final String productNote;

  OrderItem({
    required this.id,
    required this.product,
    required this.productCut,
    required this.productPrepare,
    required this.productHead,
    required this.productBody,
    required this.productShredder,
    required this.productQty,
    required this.productNote,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "product": product.toMap(),
      "productCut": productCut,
      "productPrepare": productPrepare,
      "productHead": productHead,
      "productBody": productBody,
      "productShredder": productShredder,
      "productQty": productQty,
      "productNote": productNote,
    };
  }

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      product: Product.fromJson(json['product']),
      productCut: json['productCut'],
      productPrepare: json['productPrepare'],
      productHead: json['productHead'],
      productBody: json['productBody'],
      productShredder: json['productShredder'],
      productQty: json['productQty'],
      productNote: json['productNote'],
    );
  }
}

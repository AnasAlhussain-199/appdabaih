import 'dart:convert';

import 'package:dabaih/main.dart';
import 'package:dabaih/model/food_order_item_model.dart';
import 'package:dabaih/model/order_item_model.dart';
import 'package:dabaih/model/product_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Utils {
  static const String url = "http://dhabayihmakah.com/dabaih";

  getCategory() async {
    var res = await http.get(Uri.parse('$url/product_category/read'));
    Map<String, dynamic> bodyItem = jsonDecode(res.body);
    List body = bodyItem['items'];
    List<Map<String, dynamic>> _tmpList = <Map<String, dynamic>>[];
    body.forEach((element) {
      _tmpList.add(element);
    });
    categoryNotifier.value = _tmpList;
  }

  getProductItems() async {
    var res = await http.get(Uri.parse('$url/product_items/read'));
    Map<String, dynamic> bodyItem = jsonDecode(res.body);
    List body = bodyItem['items'];
    List<Map<String, dynamic>> _tmpList = <Map<String, dynamic>>[];
    body.forEach((element) {
      _tmpList.add(element);
    });
    productItemsNotifier.value = _tmpList;

//    print(productItemsNotifier.value.toString());
  }

  getFoodProductItems() async {
    var res = await http.get(Uri.parse('$url/food_product_items/read'));
    Map<String, dynamic> bodyItem = jsonDecode(res.body);
    List body = bodyItem['items'];
    List<Map<String, dynamic>> _tmpList = <Map<String, dynamic>>[];
    body.forEach((element) {
      _tmpList.add(element);
    });
    foodProductItemsNotifier.value = _tmpList;

    // print(foodProductItemsNotifier.value.toString());
  }

  getClass() async {
    var res = await http.get(Uri.parse('$url/category_class/read'));
    Map<String, dynamic> bodyItem = jsonDecode(res.body);
    List body = bodyItem['items'];
    List<Map<String, dynamic>> _tmpList = <Map<String, dynamic>>[];
    body.forEach((element) {
      _tmpList.add(element);
    });
    classNotifier.value = _tmpList;
  }

  getProducts() async {
    var res = await http.get(Uri.parse('$url/products/read'));
    Map<String, dynamic> bodyItem = jsonDecode(res.body);
    List body = bodyItem['items'];
    List<Product> _tmpList = <Product>[];
    body.forEach((element) {
      _tmpList.add(Product.fromJson(element));
    });
    productsNotifier.value = _tmpList;
  }

  getSliders() async {
    var res = await http.get(Uri.parse('$url/slider/read'));
    Map<String, dynamic> bodyItem = jsonDecode(res.body);
    List body = bodyItem['items'];
    return body;
  }

  Future createOrder(Map data) async {
    print(data.toString());
    var res = await http.post(
      Uri.parse('$url/orders/create'),
      body: jsonEncode(data),
    );

    print(
        "#################\n#################\n\n${res.body}\n\n#################\n#################\n");

    var body = jsonDecode(res.body);
    var id = body["id"];
    return id;
  }

  Future createOrderItems(Map data) async {
    var res = await http.post(
      Uri.parse('$url/order_item/create'),
      body: jsonEncode(data),
    );
    print(
        "#################\n#################\n\n${res.body}\n\n#################\n#################\n");
  }

  Future createFoodOrderItems(Map data) async {
    var res = await http.post(
      Uri.parse('$url/food_order_item/create'),
      body: jsonEncode(data),
    );
    print(
        "#################\n#################\n\n${res.body}\n\n#################\n#################\n");
  }

  addOrder({
    required String userName,
    required String userPhone,
    required String userPhone2,
    required String userAddress,
    required String userLocation,
    required String paymentMethod,
    required bool cocking,
    List<OrderItem>? orders,
    List<FoodOrderItem>? foodOrders,
  }) async {
    var totalPrice = 0;
    cocking
        ? foodOrders!.forEach((element) {
            totalPrice = totalPrice + element.product.productPrice;
          })
        : orders!.forEach((element) {
            totalPrice =
                totalPrice + element.product.productPrice * element.productQty;
          });
    //AIzaSyDg-MO3CwqhsxGl460z1zCZuTZgOfxi7aM
    var id = await createOrder({
      "userName": userName,
      "userPhone": userPhone,
      "userPhone2": userPhone2,
      "userAddress": userAddress,
      "userLocation": userLocation,
      "paymentMethod": paymentMethod,
      "orderType": cocking ? "طبخ" : "ذبائح",
      "totalPrice": totalPrice,
    });
    FirebaseMessaging.instance.subscribeToTopic("$id");
    cocking
        ? foodOrders!.forEach((element) async {
            await createFoodOrderItems({
              "productId": element.product.id,
              "productName": element.product.productName,
              "productWeight": element.product.productWeight,
              "productPrice": element.product.productPrice,
              "productQtyPrice": element.product.productPrice,
              "orderId": id,
              "productDetails": element.productDetails,
              "cookType": element.cookType,
              "riceType": element.riceType,
              "foodType": element.foodType,
              "plateNumber": element.plateNumber,
              "productDate": element.productDate,
              "productTime": element.productTime,
              "productNote": element.productNote,
            });
          })
        : orders!.forEach((element) async {
            await createOrderItems({
              "productId": element.product.id,
              "productName": element.product.productName,
              "productWeight": element.product.productWeight,
              "productPrice": element.product.productPrice,
              "productQtyPrice":
                  element.product.productPrice * element.productQty,
              "orderId": id,
              "productCut": element.productCut,
              "productPrepare": element.productPrepare,
              "productHead": element.productHead,
              "productBody": element.productBody,
              "productShredder": element.productShredder,
              "productQty": element.productQty,
              "productNote": element.productNote,
            });
          });

    cocking
        ? foodItemsNotifier.value = <FoodOrderItem>[]
        : itemsNotifier.value = <OrderItem>[];
    await sendSms(id.toString()); //.then((value) => print(value));
    Get.defaultDialog(
        barrierDismissible: false,
        onWillPop: () async => false,
        title: "تم الارسال",
        middleText: "تم استلام طلبك وسوف يتم التواصل معك في اقرب وقت ممكن",
        actions: [
          ElevatedButton(
              onPressed: () {
                Get.offAll(() => MainPage(
                      index: 0,
                    ));
              },
              child: Text("حسنا"))
        ]);
  }

  Future sendSms(String orderId) async {
    String msg = "لديك طلب جديد في تطبيق ذبائح مكة، رقم الطلب ""($orderId)";
    //String msg = "you have new order, order id:" "($orderId)";
    var res = await http.post(
      /*+966506777622*/
      Uri.parse(
          "http://www.4jawaly.net/api/sendsms.php?username=dabayih&password=159753&message=${msg.replaceAll(" ", "%20").toString()}&numbers=966506777622&sender=DABAYIH-AD&unicode=e&return=json"),
    );
    print(
        "-----------------------\n\n${res.body}\n\n-------------------------");
    var body = jsonDecode(res.body);
    print(body);
    return body;
  }
}

import 'dart:ui';

import 'package:dabaih/main.dart';
import 'package:dabaih/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'model/food_order_item_model.dart';

class FoodDetailsPage extends StatefulWidget {
  final Product product;

  const FoodDetailsPage({Key? key, required this.product}) : super(key: key);

  @override
  _FoodDetailsPageState createState() => _FoodDetailsPageState();
}

class _FoodDetailsPageState extends State<FoodDetailsPage> {
  TextEditingController plateNumberCont = new TextEditingController();
  TextEditingController dateCont = new TextEditingController();
  TextEditingController timeCont = new TextEditingController();

  List<Map<String, dynamic>> foodProductItemsList =
      foodProductItemsNotifier.value;
  late Map<String, dynamic>? foodProductItems;

  List<String> productDetailsItems = ["لا توجد عناصر"];
  List<String> cookTypeItems = ["لا توجد عناصر"];
  List<String> riceTypeItems = ["لا توجد عناصر"];
  List<String> foodTypeItems = ["لا توجد عناصر"];

  setupProductItems() {
    foodProductItems = foodProductItemsList.firstWhereOrNull(
        (element) => element["productId"] == widget.product.id);

    if (foodProductItems == null) {
      setState(() {
        productDetailsItems = ["لا توجد عناصر"];
        cookTypeItems = ["لا توجد عناصر"];
        riceTypeItems = ["لا توجد عناصر"];
        foodTypeItems = ["لا توجد عناصر"];
      });
    } else {
      if (foodProductItems!["productDetailsItems"] == "" ||
          foodProductItems!["productDetailsItems"]
                  .toString()
                  .replaceAll("*", "") ==
              "" ||
          foodProductItems!["productDetailsItems"] == null) {
        setState(() {
          productDetailsItems = ["لا توجد عناصر"];
        });
      } else {
        setState(() {
          productDetailsItems =
              foodProductItems!["productDetailsItems"].toString().split("*");
        });
      }
      if (foodProductItems!["productCookTypeItems"] == "" ||
          foodProductItems!["productCookTypeItems"]
                  .toString()
                  .replaceAll("*", "") ==
              "" ||
          foodProductItems!["productCookTypeItems"] == null) {
        setState(() {
          cookTypeItems = ["لا توجد عناصر"];
        });
      } else {
        setState(() {
          cookTypeItems =
              foodProductItems!["productCookTypeItems"].toString().split("*");
        });
      }
      if (foodProductItems!["productRiceTypeItems"] == "" ||
          foodProductItems!["productRiceTypeItems"]
                  .toString()
                  .replaceAll("*", "") ==
              "" ||
          foodProductItems!["productRiceTypeItems"] == null) {
        setState(() {
          riceTypeItems = ["لا توجد عناصر"];
        });
      } else {
        setState(() {
          riceTypeItems =
              foodProductItems!["productRiceTypeItems"].toString().split("*");
        });
      }
      if (foodProductItems!["productFoodTypeItems"] == "" ||
          foodProductItems!["productFoodTypeItems"]
                  .toString()
                  .replaceAll("*", "") ==
              "" ||
          foodProductItems!["productFoodTypeItems"] == null) {
        setState(() {
          foodTypeItems = ["لا توجد عناصر"];
        });
      } else {
        setState(() {
          foodTypeItems =
              foodProductItems!["productFoodTypeItems"].toString().split("*");
        });
      }
    }
  }

  late String selectedDetailsItems = productDetailsItems.first;
  late String selectedCookTypeItems = cookTypeItems.first;
  late String selectedRiceTypeItems = riceTypeItems.first;
  late String selectedFoodTypeItems = foodTypeItems.first;
  int plateNumberValue = 1;
  String dateValue = "";
  String timeValue = "";
  String noteValue = "";

  @override
  void initState() {
    setupProductItems();
    plateNumberCont.text = plateNumberValue.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Center(
              child: Text(
                "${widget.product.productName}",
                style: Get.textTheme.headline5!.copyWith(
                    color: Get.theme.primaryColor, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          detailsItem(
              title: "تفصيل الذبيحة",
              itemWidget: DropdownButtonFormField(
                isExpanded: true,
                isDense: false,
                decoration: InputDecoration(contentPadding: EdgeInsets.zero),
                value: selectedDetailsItems,
                icon: Icon(Icons.keyboard_arrow_down),
                items: productDetailsItems.map((String items) {
                  return DropdownMenuItem(value: items, child: Text(items));
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedDetailsItems = newValue!;
                  });
                },
              )),
          detailsItem(
              title: "نوع الطبخ",
              itemWidget: DropdownButtonFormField(
                isExpanded: true,
                isDense: false,
                decoration: InputDecoration(contentPadding: EdgeInsets.zero),
                value: selectedCookTypeItems,
                icon: Icon(Icons.keyboard_arrow_down),
                items: cookTypeItems.map((String items) {
                  return DropdownMenuItem(value: items, child: Text(items));
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCookTypeItems = newValue!;
                  });
                },
              )),
          detailsItem(
              title: "نوع الأرز",
              itemWidget: DropdownButtonFormField(
                isExpanded: true,
                isDense: false,
                decoration: InputDecoration(contentPadding: EdgeInsets.zero),
                value: selectedRiceTypeItems,
                icon: Icon(Icons.keyboard_arrow_down),
                items: riceTypeItems.map((String items) {
                  return DropdownMenuItem(value: items, child: Text(items));
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedRiceTypeItems = newValue!;
                  });
                },
              )),
          detailsItem(
            title: "عدد الصحون",
            itemWidget: TextField(
              keyboardType: TextInputType.number,
              controller: plateNumberCont,
              onChanged: (v) {
                setState(() {
                  plateNumberValue = int.parse(v);
                });
              },
            ),
          ),
          detailsItem(
              title: "نوع الوجبة",
              itemWidget: DropdownButtonFormField(
                isExpanded: true,
                isDense: false,
                decoration: InputDecoration(contentPadding: EdgeInsets.zero),
                value: selectedFoodTypeItems,
                icon: Icon(Icons.keyboard_arrow_down),
                items: foodTypeItems.map((String items) {
                  return DropdownMenuItem(value: items, child: Text(items));
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedFoodTypeItems = newValue!;
                  });
                },
              )),
          detailsItem(
              title: "تاريخ المناسبة",
              itemWidget: TextField(
                controller: dateCont,
                onChanged: (v) {
                  setState(() {
                    dateValue = v;
                  });
                },
              )),
          detailsItem(
              title: "وقت الاستلام",
              itemWidget: TextField(
                controller: timeCont,
                onChanged: (v) {
                  setState(() {
                    timeValue = v;
                  });
                },
              )),
          detailsItem(
            title: "ملاحظات",
            itemWidget: TextField(
              minLines: 2,
              maxLines: 3,
              keyboardType: TextInputType.multiline,
              onChanged: (String? newValue) {
                setState(() {
                  noteValue = newValue!;
                });
              },
            ),
          ),
          Card(
            color: Get.theme.primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "السعر الاجمالي: "
                  "${widget.product.productPrice}"
                  " ر.س",
                  style: Get.textTheme.headline6!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    List<FoodOrderItem> _tmpList = foodItemsNotifier.value;
                    _tmpList.add(FoodOrderItem(
                        id: DateTime.now().toString(),
                        product: widget.product,
                        foodType: selectedFoodTypeItems,
                        productDetails: selectedDetailsItems,
                        cookType: selectedCookTypeItems,
                        riceType: selectedRiceTypeItems,
                        plateNumber: plateNumberValue,
                        productDate: dateValue,
                        productTime: timeValue,
                        productNote: noteValue));
                    foodItemsNotifier.value = _tmpList;
                    Get.offAll(() => MainPage(
                          index: 1,
                          cartIndex: 1,
                        ));
                  },
                  child: Card(
                    color: Color(0xffd9524f),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Center(
                        child: Text(
                          "اضافة للسلة",
                          style: Get.textTheme.headline6!.copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget detailsItem({
    required String title,
    required Widget itemWidget,
  }) {
    return StatefulBuilder(builder: (context, StateSetter setState) {
      return Row(
        children: [
          Expanded(
              flex: 2,
              child: Text(
                title,
                style: Get.textTheme.subtitle1!
                    .copyWith(fontWeight: FontWeight.bold),
              )),
          Expanded(
            flex: 8,
            child: Card(
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(width: 1, color: Get.theme.primaryColor)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: itemWidget,
              ),
            ),
          ),
        ],
      );
    });
  }
}

import 'package:dabaih/main.dart';
import 'package:dabaih/model/order_item_model.dart';
import 'package:dabaih/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class DetailsPage extends StatefulWidget {
  final Product product;

  const DetailsPage({Key? key, required this.product}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  List<Map<String, dynamic>> productItemsList = productItemsNotifier.value;
  late Map<String, dynamic>? productItems;

  List<String> productCutItems = ["لا توجد عناصر"];
  List<String> productPrepareItems = ["لا توجد عناصر"];
  List<String> productHeadItems = ["لا توجد عناصر"];
  List<String> productBodyItems = ["لا توجد عناصر"];
  List<String> productShredderItems = ["لا توجد عناصر"];
  setupProductItems() {
    productItems = productItemsList.firstWhereOrNull(
        (element) => element["productId"] == widget.product.id);

    if (productItems == null) {
      setState(() {
        productCutItems = ["لا توجد عناصر"];
        productPrepareItems = ["لا توجد عناصر"];
        productHeadItems = ["لا توجد عناصر"];
        productBodyItems = ["لا توجد عناصر"];
        productShredderItems = ["لا توجد عناصر"];
      });
    } else {
      if (productItems!["productCutItems"] == "" ||
          productItems!["productCutItems"].toString().replaceAll("*", "") ==
              "" ||
          productItems!["productCutItems"] == null) {
        setState(() {
          productCutItems = ["لا توجد عناصر"];
        });
      } else {
        setState(() {
          productCutItems =
              productItems!["productCutItems"].toString().split("*");
        });
      }
      if (productItems!["productPrepareItems"] == "" ||
          productItems!["productPrepareItems"].toString().replaceAll("*", "") ==
              "" ||
          productItems!["productPrepareItems"] == null) {
        setState(() {
          productPrepareItems = ["لا توجد عناصر"];
        });
      } else {
        setState(() {
          productPrepareItems =
              productItems!["productPrepareItems"].toString().split("*");
        });
      }
      if (productItems!["productHeadItems"] == "" ||
          productItems!["productHeadItems"].toString().replaceAll("*", "") ==
              "" ||
          productItems!["productHeadItems"] == null) {
        setState(() {
          productHeadItems = ["لا توجد عناصر"];
        });
      } else {
        setState(() {
          productHeadItems =
              productItems!["productHeadItems"].toString().split("*");
        });
      }
      if (productItems!["productBodyItems"] == "" ||
          productItems!["productBodyItems"].toString().replaceAll("*", "") ==
              "" ||
          productItems!["productBodyItems"] == null) {
        setState(() {
          productBodyItems = ["لا توجد عناصر"];
        });
      } else {
        setState(() {
          productBodyItems =
              productItems!["productBodyItems"].toString().split("*");
        });
      }
      if (productItems!["productShredderItems"] == "" ||
          productItems!["productShredderItems"]
                  .toString()
                  .replaceAll("*", "") ==
              "" ||
          productItems!["productShredderItems"] == null) {
        setState(() {
          productShredderItems = ["لا توجد عناصر"];
        });
      } else {
        setState(() {
          productShredderItems =
              productItems!["productShredderItems"].toString().split("*");
        });
      }
    }
  }

  late List<String> productWeightItems = [
    "${widget.product.productWeight}",
  ];

  late String selectedWeightItems = productWeightItems.first;
  late String selectedCutItems = productCutItems.first;
  late String selectedPrepareItems = productPrepareItems.first;
  late String selectedHeadItems = productHeadItems.first;
  late String selectedBodyItems = productBodyItems.first;
  late String selectedShredderItems = productShredderItems.first;
  String noteValue = "";
  int qty = 01;

  @override
  void initState() {
    setupProductItems();
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
              title: "الحجم",
              itemWidget: DropdownButtonFormField(
                isExpanded: true,
                isDense: false,
                decoration: InputDecoration(contentPadding: EdgeInsets.zero),
                value: selectedWeightItems,
                icon: Icon(Icons.keyboard_arrow_down),
                items: productWeightItems.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedWeightItems = newValue!;
                  });
                },
              )),
          detailsItem(
              title: "التقطيع",
              itemWidget: DropdownButtonFormField(
                isExpanded: true,
                isDense: false,
                decoration: InputDecoration(contentPadding: EdgeInsets.zero),
                value: selectedCutItems,
                icon: Icon(Icons.keyboard_arrow_down),
                items: productCutItems.map((String items) {
                  return DropdownMenuItem(value: items, child: Text(items));
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCutItems = newValue!;
                  });
                },
              )),
          detailsItem(
              title: "التجهيز",
              itemWidget: DropdownButtonFormField(
                isExpanded: true,
                isDense: false,
                decoration: InputDecoration(contentPadding: EdgeInsets.zero),
                value: selectedPrepareItems,
                icon: Icon(Icons.keyboard_arrow_down),
                items: productPrepareItems.map((String items) {
                  return DropdownMenuItem(value: items, child: Text(items));
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedPrepareItems = newValue!;
                  });
                },
              )),
          detailsItem(
              title: "الرأس والمقدام",
              itemWidget: DropdownButtonFormField(
                isExpanded: true,
                isDense: false,
                decoration: InputDecoration(contentPadding: EdgeInsets.zero),
                value: selectedHeadItems,
                icon: Icon(Icons.keyboard_arrow_down),
                items: productHeadItems.map((String items) {
                  return DropdownMenuItem(value: items, child: Text(items));
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedHeadItems = newValue!;
                  });
                },
              )),
          detailsItem(
              title: "الكرش والمصران",
              itemWidget: DropdownButtonFormField(
                isExpanded: true,
                isDense: false,
                decoration: InputDecoration(contentPadding: EdgeInsets.zero),
                value: selectedBodyItems,
                icon: Icon(Icons.keyboard_arrow_down),
                items: productBodyItems.map((String items) {
                  return DropdownMenuItem(value: items, child: Text(items));
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedBodyItems = newValue!;
                  });
                },
              )),
          detailsItem(
              title: "مفروم",
              itemWidget: DropdownButtonFormField(
                isExpanded: true,
                isDense: false,
                decoration: InputDecoration(contentPadding: EdgeInsets.zero),
                value: selectedShredderItems,
                icon: Icon(Icons.keyboard_arrow_down),
                items: productShredderItems.map((String items) {
                  return DropdownMenuItem(value: items, child: Text(items));
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedShredderItems = newValue!;
                  });
                },
              )),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 2,
                    child: Text(
                      "ملاحظات",
                      style: Get.textTheme.subtitle1!
                          .copyWith(fontWeight: FontWeight.bold),
                    )),
                Expanded(
                  flex: 8,
                  child: Card(
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(
                            width: 1, color: Get.theme.primaryColor)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextField(
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
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 1,
                    child: Text(
                      "عدد الذبائح",
                      style: Get.textTheme.subtitle1!
                          .copyWith(fontWeight: FontWeight.bold),
                    )),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            qty++;
                          });
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          color: Colors.green,
                          child: Icon(
                            Ionicons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: Get.theme.primaryColor)),
                          child: Center(
                              child: Text(
                            qty.toString(),
                            style: Get.textTheme.subtitle1!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Get.theme.primaryColor),
                          )),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (qty > 1)
                            setState(() {
                              qty--;
                            });
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          color: Colors.red,
                          child: Icon(
                            Ionicons.remove,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Card(
            color: Get.theme.primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "السعر الاجمالي: "
                  "${qty * widget.product.productPrice}"
                  " ريال سعودي",
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
                    List<OrderItem> _tmpList = itemsNotifier.value;
                    _tmpList.add(OrderItem(
                      id: DateTime.now().toString(),
                      product: widget.product,
                      productCut: selectedCutItems,
                      productPrepare: selectedPrepareItems,
                      productHead: selectedHeadItems,
                      productBody: selectedBodyItems,
                      productShredder: selectedShredderItems,
                      productQty: qty,
                      productNote: noteValue,
                    ));
                    itemsNotifier.value = _tmpList;
                    Get.offAll(() => MainPage(
                          index: 1,
                          cartIndex: 0,
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
    return StatefulBuilder(builder: (context, StateSetter stState) {
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

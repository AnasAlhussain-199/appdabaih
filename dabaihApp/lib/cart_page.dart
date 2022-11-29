import 'package:dabaih/main.dart';
import 'package:dabaih/model/order_item_model.dart';
import 'package:dabaih/payment_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import 'model/food_order_item_model.dart';

class CartPage extends StatefulWidget {
  final int? pageIndex;
  const CartPage({Key? key, this.pageIndex}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late int index = widget.pageIndex!;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      index = 0;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    color: index == 0 ? Get.theme.primaryColor : null,
                    height: 50,
                    child: Center(
                      child: Text(
                        "الذبائح",
                        style: Get.textTheme.headline6!.copyWith(
                          color: index == 0 ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      index = 1;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    color: index == 1 ? Get.theme.primaryColor : null,
                    height: 50,
                    child: Center(
                      child: Text(
                        "الطبخ",
                        style: Get.textTheme.headline6!.copyWith(
                          color: index == 1 ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(child: index == 0 ? orders() : foodOrders())
      ],
    );
  }

  int total = 0;
  Widget orders() {
    return ValueListenableBuilder(
        valueListenable: itemsNotifier,
        builder: (context, items, _) {
          List it = items as List;
          total = 0;
          items.forEach((element) {
            total = total +
                (element.product.productPrice * element.productQty as int);
          });
          return ListView(
            padding: EdgeInsets.all(10),
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: it.length,
                  itemBuilder: (context, index) {
                    List<OrderItem> _tmpList = itemsNotifier.value;
                    OrderItem orderItem = it[index];
                    return Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 2,
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: Image.network(
                                    "${orderItem.product.productImage}",
                                    fit: BoxFit.cover,
                                  ),
                                )),
                            SizedBox(
                              width: 8,
                            ),
                            Expanded(
                                flex: 6,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                              "${orderItem.product.productName}",
                                              style: Get.textTheme.headline6!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              _tmpList.removeWhere((element) =>
                                                  element.id == it[index].id);
                                              itemsNotifier.value = _tmpList;
                                              setState(() {});
                                            },
                                            icon: Icon(
                                              Ionicons.close_circle,
                                              color: Colors.red,
                                            ))
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "${orderItem.productQty * orderItem.product.productPrice} SAR",
                                            style: Get.textTheme.bodyText1!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          "${orderItem.product.productName}",
                                                          style: Get.textTheme
                                                              .headline6!
                                                              .copyWith(
                                                                  color: Get
                                                                      .theme
                                                                      .primaryColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                      IconButton(
                                                          onPressed: () {
                                                            Get.back();
                                                          },
                                                          icon: Icon(
                                                            Ionicons
                                                                .close_circle,
                                                            color: Colors.red,
                                                          ))
                                                    ],
                                                  ),
                                                  content: Container(
                                                    width: Get.width,
                                                    child: ListView(
                                                      shrinkWrap: true,
                                                      children: [
                                                        detailsItem(
                                                            title: "الحجم: ",
                                                            subtitle:
                                                                "${orderItem.product.productWeight}"),
                                                        detailsItem(
                                                            title: "التقطيع: ",
                                                            subtitle:
                                                                "${orderItem.productCut}"),
                                                        detailsItem(
                                                            title: "التجهيز: ",
                                                            subtitle:
                                                                "${orderItem.productPrepare}"),
                                                        detailsItem(
                                                            title:
                                                                "الرأس والمقادم: ",
                                                            subtitle:
                                                                "${orderItem.productHead}"),
                                                        detailsItem(
                                                            title:
                                                                "الكرش والمصران: ",
                                                            subtitle:
                                                                "${orderItem.productBody}"),
                                                        detailsItem(
                                                            title: "مفروم: ",
                                                            subtitle:
                                                                "${orderItem.productShredder}"),
                                                        detailsItem(
                                                            title:
                                                                "الملاحظات: ",
                                                            subtitle: orderItem
                                                                        .productNote ==
                                                                    ""
                                                                ? "لا ملاحظات"
                                                                : "${orderItem.productNote}"),
                                                        ElevatedButton(
                                                          onPressed: () {},
                                                          child: Text(
                                                              "السعر الاجمالي: ${orderItem.productQty * orderItem.product.productPrice} ريال سعودي"),
                                                          style: Get
                                                              .theme
                                                              .elevatedButtonTheme
                                                              .style!
                                                              .copyWith(
                                                            shape: MaterialStateProperty
                                                                .all(
                                                                    RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4.0),
                                                            )),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: Text(
                                            "تفاصيل الطلب",
                                            style: Get.textTheme.bodyText1!
                                                .copyWith(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      ),
                    );
                  }),
              SizedBox(
                height: 10,
              ),
              it.length == 0
                  ? Container()
                  : ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "السعر الاجمالي: $total ريال سعودي",
                        style: Get.textTheme.button!.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      style: Get.theme.elevatedButtonTheme.style!.copyWith(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        )),
                      ),
                    ),
              SizedBox(
                height: 10,
              ),
              it.length == 0
                  ? Container()
                  : Container(
                      child: Center(
                        child: Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Get.offAll(() => MainPage(
                                      index: 0,
                                    ));
                              },
                              child: Text(
                                "إضافة طلب آخر",
                                style: Get.textTheme.button!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              style:
                                  Get.theme.elevatedButtonTheme.style!.copyWith(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                )),
                              ),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Get.to(() => PaymentPage(
                                      orderItem: it as List<OrderItem>,
                                      cocking: false,
                                    ));
                              },
                              child: Text(
                                "اتمام الطلب",
                                style: Get.textTheme.button!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              style: Get.theme.elevatedButtonTheme.style!
                                  .copyWith(
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                      )),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Color(0xff057580))),
                            ),
                          ],
                        ),
                      ),
                    )
            ],
          );
        });
  }

  int cockTotal = 0;
  Widget foodOrders() {
    return ValueListenableBuilder(
        valueListenable: foodItemsNotifier,
        builder: (context, items, _) {
          List it = items as List;
          cockTotal = 0;
          items.forEach((element) {
            cockTotal = cockTotal + (element.product.productPrice as int);
          });
          return ListView(
            padding: EdgeInsets.all(10),
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: it.length,
                  itemBuilder: (context, index) {
                    List<FoodOrderItem> _tmpList = foodItemsNotifier.value;
                    FoodOrderItem foodOrderItem = it[index];
                    return Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 2,
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: Image.network(
                                    "${foodOrderItem.product.productImage}",
                                    fit: BoxFit.cover,
                                  ),
                                )),
                            SizedBox(
                              width: 8,
                            ),
                            Expanded(
                                flex: 6,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                              "${foodOrderItem.product.productName}",
                                              style: Get.textTheme.headline6!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              _tmpList.removeWhere((element) =>
                                                  element.id == it[index].id);
                                              itemsNotifier.value = _tmpList;
                                              setState(() {});
                                            },
                                            icon: Icon(
                                              Ionicons.close_circle,
                                              color: Colors.red,
                                            ))
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "${foodOrderItem.product.productPrice} "
                                            "ر.س",
                                            style: Get.textTheme.bodyText1!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          "${foodOrderItem.product.productName}",
                                                          style: Get.textTheme
                                                              .headline6!
                                                              .copyWith(
                                                                  color: Get
                                                                      .theme
                                                                      .primaryColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                      IconButton(
                                                          onPressed: () {
                                                            Get.back();
                                                          },
                                                          icon: Icon(
                                                            Ionicons
                                                                .close_circle,
                                                            color: Colors.red,
                                                          ))
                                                    ],
                                                  ),
                                                  content: Container(
                                                    width: Get.width,
                                                    child: ListView(
                                                      shrinkWrap: true,
                                                      children: [
                                                        detailsItem(
                                                            title:
                                                                "تفصيل الذبيحة: ",
                                                            subtitle:
                                                                "${foodOrderItem.productDetails}"),
                                                        detailsItem(
                                                            title:
                                                                "نوع الطبخ: ",
                                                            subtitle:
                                                                "${foodOrderItem.cookType}"),
                                                        detailsItem(
                                                            title:
                                                                "نوع الأرز: ",
                                                            subtitle:
                                                                "${foodOrderItem.riceType}"),
                                                        detailsItem(
                                                            title:
                                                                "عدد الصحون: ",
                                                            subtitle:
                                                                "${foodOrderItem.plateNumber}"),
                                                        detailsItem(
                                                            title:
                                                                "نوع الوجبة: ",
                                                            subtitle:
                                                                "${foodOrderItem.foodType}"),
                                                        detailsItem(
                                                            title:
                                                                "تاريخ المناسبة: ",
                                                            subtitle:
                                                                "${foodOrderItem.productDate}"),
                                                        detailsItem(
                                                            title:
                                                                "وقت الاستلام: ",
                                                            subtitle:
                                                                "${foodOrderItem.productTime}"),
                                                        detailsItem(
                                                            title:
                                                                "الملاحظات: ",
                                                            subtitle: foodOrderItem
                                                                        .productNote ==
                                                                    ""
                                                                ? "لا ملاحظات"
                                                                : "${foodOrderItem.productNote}"),
                                                        ElevatedButton(
                                                          onPressed: () {},
                                                          child: Text(
                                                              "السعر الاجمالي: ${foodOrderItem.product.productPrice} "
                                                              "ر.س"),
                                                          style: Get
                                                              .theme
                                                              .elevatedButtonTheme
                                                              .style!
                                                              .copyWith(
                                                            shape: MaterialStateProperty
                                                                .all(
                                                                    RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4.0),
                                                            )),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: Text(
                                            "تفاصيل الطلب",
                                            style: Get.textTheme.bodyText1!
                                                .copyWith(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      ),
                    );
                  }),
              SizedBox(
                height: 10,
              ),
              it.length == 0
                  ? Container()
                  : ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "السعر الاجمالي: $cockTotal ريال سعودي",
                        style: Get.textTheme.button!.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      style: Get.theme.elevatedButtonTheme.style!.copyWith(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        )),
                      ),
                    ),
              SizedBox(
                height: 10,
              ),
              it.length == 0
                  ? Container()
                  : Container(
                      child: Center(
                        child: Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Get.offAll(() => MainPage(
                                      index: 0,
                                    ));
                              },
                              child: Text(
                                "إضافة طلب آخر",
                                style: Get.textTheme.button!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              style:
                                  Get.theme.elevatedButtonTheme.style!.copyWith(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                )),
                              ),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Get.to(() => PaymentPage(
                                      foodOrderItem: it as List<FoodOrderItem>,
                                      cocking: true,
                                    ));
                              },
                              child: Text(
                                "اتمام الطلب",
                                style: Get.textTheme.button!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              style: Get.theme.elevatedButtonTheme.style!
                                  .copyWith(
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                      )),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Color(0xff057580))),
                            ),
                          ],
                        ),
                      ),
                    )
            ],
          );
        });
  }

  Widget detailsItem({required String title, required String subtitle}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text.rich(TextSpan(
          text: title,
          style: Get.textTheme.bodyText1!.copyWith(
              color: Get.theme.primaryColor, fontWeight: FontWeight.bold),
          children: <InlineSpan>[
            TextSpan(
              text: subtitle,
              style: Get.textTheme.bodyText1!
                  .copyWith(fontWeight: FontWeight.bold),
            )
          ])),
    );
  }
}

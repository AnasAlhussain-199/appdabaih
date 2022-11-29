import 'package:dabaih/details_page.dart';
import 'package:dabaih/main.dart';
import 'package:dabaih/model/product_model.dart';
import 'package:dabaih/utils/app_themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import 'food_details_page.dart';

class SubCategoryList extends StatefulWidget {
  final int categoryId;
  final bool cock;
  const SubCategoryList(
      {Key? key, required this.categoryId, required this.cock})
      : super(key: key);

  @override
  _SubCategoryListState createState() => _SubCategoryListState();
}

class _SubCategoryListState extends State<SubCategoryList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("المنتجات"),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => Get.back(),
            child: CircleAvatar(
              child: Icon(Ionicons.return_up_forward),
            ),
          ),
        ),
      ),
      body: ValueListenableBuilder(
          valueListenable: productsNotifier,
          builder: (context, items, _) {
            List it = items as List;
            List productList = it
                .where((element) =>
                    element.categoryId == widget.categoryId &&
                    element.showToUser == "نعم")
                .toList();
            return ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: productList.length,
              itemBuilder: (context, index) {
                Product product = productList[index];
                return GestureDetector(
                    onTap: () {
                      widget.cock
                          ? Get.to(() => FoodDetailsPage(
                                product: product,
                              ))
                          : Get.to(() => DetailsPage(
                                product: product,
                              ));
                    },
                    child: Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //  mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 4,
                            child: AspectRatio(
                              aspectRatio: 4 / 5,
                              child: Image.network(
                                product.productImage,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 6,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      "${product.productName}",
                                      style: Get.textTheme.headline6!.copyWith(
                                          color: AppThemes.darkColor,
                                          fontWeight: FontWeight.bold),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      "${product.productWeight}",
                                      style: Get.textTheme.bodyText1!.copyWith(
                                          color: AppThemes.darkColor,
                                          fontWeight: FontWeight.bold),
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text.rich(TextSpan(
                                          text: '',
                                          style: Get.textTheme.bodyText1!
                                              .copyWith(
                                                  color: Get.theme.primaryColor,
                                                  fontWeight: FontWeight.bold),
                                          children: <InlineSpan>[
                                            TextSpan(
                                              text: "${product.productPrice} "
                                                  "ر.س",
                                              style: Get.textTheme.subtitle1!
                                                  .copyWith(
                                                      color: AppThemes
                                                          .primaryColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                            )
                                          ])),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          widget.cock
                                              ? Get.to(() => FoodDetailsPage(
                                                    product: product,
                                                  ))
                                              : Get.to(() => DetailsPage(
                                                    product: product,
                                                  ));
                                        },
                                        icon: Icon(Ionicons.cart),
                                        label: Text("اختيار"),
                                      ),
                                    )
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ));
              },
            );
          }),
    );
  }
}

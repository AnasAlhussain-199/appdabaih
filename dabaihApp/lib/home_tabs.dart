import 'package:auto_size_text/auto_size_text.dart';
import 'package:dabaih/main.dart';
import 'package:dabaih/sub_category_list.dart';
import 'package:dabaih/utils/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class HomeTab extends StatefulWidget {
  final String className;
  const HomeTab({Key? key, required this.className}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("التصنيفات"),
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
          valueListenable: categoryNotifier,
          builder: (context, items, _) {
            List it = items as List;
            List categoryList = it
                .where((element) =>
                    element['tabName'].toString() == widget.className)
                .toList();
            return GridView.builder(
              padding: EdgeInsets.all(10),
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: categoryList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 4 / 5),
              itemBuilder: (context, index) {
                Map<String, dynamic> category = categoryList[index];
                return GestureDetector(
                  onTap: () => Get.to(() => SubCategoryList(
                        categoryId: category['id'],
                        cock: category['tabName'].toString().contains("طبخ")
                            ? true
                            : false,
                      )),
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      children: [
                        AspectRatio(
                          aspectRatio: 1,
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(16.0)),
                            child: Image.network(
                              "${category['categoryImage']}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                            child: Center(
                                child: AutoSizeText(
                          "${category['categoryName']}",
                          style: Get.textTheme.headline6!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppThemes.darkColor),
                          maxLines: 1,
                        )))
                      ],
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}

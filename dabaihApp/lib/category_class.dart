import 'package:auto_size_text/auto_size_text.dart';
import 'package:dabaih/home_tabs.dart';
import 'package:dabaih/main.dart';
import 'package:dabaih/utils/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryClass extends StatefulWidget {
  const CategoryClass({Key? key}) : super(key: key);

  @override
  _CategoryClassState createState() => _CategoryClassState();
}

class _CategoryClassState extends State<CategoryClass> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: classNotifier,
        builder: (context, items, _) {
          List it = items as List;
          List categoryClassList = it
              .where((element) => element['showToUser'].toString() == "نعم")
              .toList();
          return GridView.builder(
            padding: EdgeInsets.all(10),
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: categoryClassList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 4 / 5),
            itemBuilder: (context, index) {
              Map<String, dynamic> categoryClass = categoryClassList[index];
              return GestureDetector(
                onTap: () => Get.to(() => HomeTab(
                      className: categoryClass['className'],
                    )),
                child: Card(
                  color: Colors.white,
                  shape:
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                          child: Image.network(
                            "${categoryClass['classImage']}",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                          child: Center(
                              child: AutoSizeText(
                        "${categoryClass['className']}",
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
        });
  }
}

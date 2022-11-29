import 'package:carousel_slider/carousel_slider.dart';
import 'package:dabaih/category_class.dart';
import 'package:dabaih/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CarouselController _controller = CarouselController();

  List<Widget> imgList = [];
  getSlider() async {
    await Utils().getSliders().then((value) {
      value.forEach((element) {
        imgList.add(Container(
          width: Get.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.network(
            "${element['image']}",
            fit: BoxFit.contain,
            width: Get.width,
          ),
        ));
        setState(() {});
      });
    });
  }

  @override
  void initState() {
    getSlider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        imgList.length == 0
            ? Container()
            : CarouselSlider(
                items: imgList,
                carouselController: _controller,
                options: CarouselOptions(
                  height: Get.width * .55,
                  autoPlay: true,
                  viewportFraction: 1,
                ),
              ),
        SizedBox(
          height: 16,
        ),
        CategoryClass()
      ],
    );
  }
}

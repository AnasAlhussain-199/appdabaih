import 'package:dabaih/utils/app_themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => Get.back(),
              child: CircleAvatar(
                child: Icon(Ionicons.return_up_back),
              ),
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(32),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(16))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Image.asset(
                        "assets/images/dabaih.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(
                    "استعداد تام لجميع المناسبات وتوزيع الهدي والصدقات داخل مكة",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "هدفنا رضاكم وشعارنا الذمة والامانة",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        color: Colors.yellow, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (!await launch(
                        "https://api.whatsapp.com/send?phone=+966506777622",
                        universalLinksOnly: true,
                      )) throw 'Could not launch';
                    },
                    child: Chip(
                      label: Text(
                        "+966506777622",
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: AppThemes.greenColor,
                            fontWeight: FontWeight.bold),
                        textDirection: TextDirection.ltr,
                      ),
                      backgroundColor: Colors.white,
                      avatar: CircleAvatar(
                        child: Icon(
                          Ionicons.logo_whatsapp,
                          color: Colors.white,
                          size: 20,
                        ),
                        backgroundColor: AppThemes.greenColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "تطبيق ذبائح مكة",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    "يوفر لعملائه اجود انواع الذبائح لجميع المناسبات وتوزيع الهدي والصدقات وبأسعار مناسبة"
                    "\n"
                    "على أيادي سعودية نسعى لتوفير خدمات عالية الجودة في اختيار الذبيحة والطبخ حسب رغبتكم والتوصيل في الوقت المناسب بكل خفة وأمانة وتوفير سبل الراحة بمجرد الطلب عن طريق التطبيق او الاتصال مباشرة",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

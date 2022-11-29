import 'package:dabaih/about_page.dart';
import 'package:dabaih/cart_page.dart';
import 'package:dabaih/contact_page.dart';
import 'package:dabaih/home_page.dart';
import 'package:dabaih/model/order_item_model.dart';
import 'package:dabaih/model/product_model.dart';
import 'package:dabaih/utils/app_themes.dart';
import 'package:dabaih/utils/app_utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:url_launcher/url_launcher.dart';

import 'model/food_order_item_model.dart';

ValueNotifier itemsNotifier = ValueNotifier(<OrderItem>[]);
ValueNotifier foodItemsNotifier = ValueNotifier(<FoodOrderItem>[]);
ValueNotifier productsNotifier = ValueNotifier(<Product>[]);
ValueNotifier categoryNotifier = ValueNotifier(<Map<String, dynamic>>[]);
ValueNotifier classNotifier = ValueNotifier(<Map<String, dynamic>>[]);
ValueNotifier productItemsNotifier = ValueNotifier(<Map<String, dynamic>>[]);
ValueNotifier foodProductItemsNotifier =
    ValueNotifier(<Map<String, dynamic>>[]);

Future<void> _messageHandler(RemoteMessage message) async {}

/*const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.max,
);*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    showSimpleNotification(
      Text("${message.notification!.title}"),
      subtitle: Text("${message.notification!.body}"),
      leading: Image.asset("assets/images/dabaih.png"),
      background: AppThemes.primaryColor,
      duration: Duration(seconds: 10),
      autoDismiss: true,
      position: NotificationPosition.top,
    );
  });
  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, sound: true, badge: true);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: GetMaterialApp(
        title: 'ذبائح مكة',
        locale: Locale("ar"),
        theme: AppThemes.lightTheme(),
        home: SplashPage(),
      ),
    );
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 5), () => Get.offAll(() => MainPage()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        "assets/images/dabaih.jpg",
        width: Get.width,
        height: Get.height,
        fit: BoxFit.cover,
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  final int? index;
  final int? cartIndex;
  const MainPage({Key? key, this.index, this.cartIndex}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late int _currentIndex;

  List<Widget> _pages() {
    return [
      HomePage(),
      CartPage(
        pageIndex: widget.cartIndex ?? 0,
      ),
      ContactPage()
    ];
  }

  @override
  void initState() {
    _currentIndex = widget.index ?? 0;
    Utils().getClass();
    Utils().getCategory();
    Utils().getProducts();
    Utils().getProductItems();
    Utils().getFoodProductItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text("ذبائح مكة"),
          centerTitle: true,
        ),
        body: _pages()[_currentIndex],
        bottomNavigationBar: BottomAppBar(
          child: Container(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: BottomNavigationBar(
                  currentIndex: _currentIndex,
                  onTap: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  selectedFontSize: 16,
                  unselectedFontSize: 16,
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(Ionicons.home_outline),
                        label: 'الرئيسية',
                        activeIcon: Icon(Ionicons.home)),
                    BottomNavigationBarItem(
                        icon: Icon(Ionicons.cart_outline),
                        label: 'السلة',
                        activeIcon: Icon(Ionicons.cart)),
                    BottomNavigationBarItem(
                        icon: Icon(Ionicons.call_outline),
                        label: 'تواصل معنا',
                        activeIcon: Icon(Ionicons.call))
                  ]),
            ),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                color: Get.theme.primaryColor,
                child: DrawerHeader(
                  margin: EdgeInsets.symmetric(horizontal: 32),
                  decoration: BoxDecoration(
                    color: Get.theme.primaryColor,
                  ),
                  child: Image.asset(
                    "assets/images/dabaih.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  "الرئيسية",
                  style: TextStyle(fontSize: 20),
                ),
                leading: CircleAvatar(
                  child: Icon(
                    Ionicons.home,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  setState(() {
                    _currentIndex = 0;
                  });
                  Get.back();
                },
              ),
              ListTile(
                title: Text(
                  "السلة",
                  style: TextStyle(fontSize: 20),
                ),
                leading: CircleAvatar(
                  child: Icon(
                    Ionicons.bag,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                  Get.back();
                },
              ),
              ListTile(
                title: Text(
                  "تقييمنا",
                  style: TextStyle(fontSize: 20),
                ),
                leading: CircleAvatar(
                  child: Icon(
                    Ionicons.star,
                    color: Colors.white,
                  ),
                ),
                onTap: () async {
                  if (!await launch(
                    "https://www.instagram.com/dhbyhmk/",
                    universalLinksOnly: true,
                  )) throw 'Could not launch';
                },
              ),
              ListTile(
                title: Text(
                  "نبذة عنا",
                  style: TextStyle(fontSize: 20),
                ),
                leading: CircleAvatar(
                  child: Icon(
                    Ionicons.information_circle,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  Get.back();
                  Get.to(() => AboutPage());
                },
              ),
              ListTile(
                title: Text(
                  "تواصل معنا",
                  style: TextStyle(fontSize: 20),
                ),
                leading: CircleAvatar(
                  child: Icon(
                    Ionicons.call,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  setState(() {
                    _currentIndex = 2;
                  });
                  Get.back();
                },
              ),
            ],
          ),
        ));
  }
}

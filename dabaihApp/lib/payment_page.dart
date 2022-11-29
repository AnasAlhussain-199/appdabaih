import 'dart:async';

import 'package:dabaih/model/order_item_model.dart';
import 'package:dabaih/utils/app_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'model/food_order_item_model.dart';

class PaymentPage extends StatefulWidget {
  final List<OrderItem>? orderItem;
  final List<FoodOrderItem>? foodOrderItem;
  final bool cocking;

  const PaymentPage(
      {Key? key, this.orderItem, this.foodOrderItem, required this.cocking})
      : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  Completer<GoogleMapController> _controller = Completer();

  CameraPosition _kInitPosition = CameraPosition(
    target: LatLng(21.513007759231726, 39.87688283517192),
    zoom: 10,
  );

  LatLng? currentLatLng;
  LatLng? selectedLatLng;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{
    MarkerId("selectedLocation"): Marker(
      markerId: MarkerId("selectedLocation"),
      position: LatLng(21.513007759231726, 39.87688283517192),
    )
  };

  void _add(LatLng latLng) {
    final MarkerId markerId = MarkerId("selectedLocation");

    // creating a new MARKER
    final Marker marker = Marker(
      markerId: markerId,
      position: latLng,
    );

    setState(() {
      markers[markerId] = marker;
    });
  }

  TextEditingController nameCont = new TextEditingController();
  TextEditingController phoneCont = new TextEditingController();
  TextEditingController phone2Cont = new TextEditingController();
  TextEditingController addressCont = new TextEditingController();

  String nameValue = "";
  String phoneValue = "";
  String phone2Value = "";
  String addressValue = "";
  String locationValue =
      "http://www.google.com/maps/place/21.513007759231726,39.87688283517192";
  int paymentMethod = 0;

  _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      // return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("يرجى تفعيل الموقع لتحديد موقعك بدقة"),
        ));
        //return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("يرجى تفعيل الموقع لتحديد موقعك بدقة"),
      ));

      //return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      await Geolocator.getCurrentPosition().then((value) {
        setState(() {
          currentLatLng = LatLng(value.latitude, value.longitude);
          _kInitPosition = CameraPosition(
            target: LatLng(value.latitude, value.longitude),
            zoom: 10,
          );
        });

        _add(LatLng(value.latitude, value.longitude));
        setState(() {
          locationValue =
              "http://www.google.com/maps/place/${value.latitude},${value.longitude}";
        });

        _controller.future.then((value) => value.moveCamera(
                //CameraUpdate.newLatLng(markers.entries.last.value.position)));
                CameraUpdate.newCameraPosition(CameraPosition(
              target: markers.entries.last.value.position,
              zoom: 15,
            ))));
      });
    }
  }

  @override
  void initState() {
    _determinePosition();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Text(
                      "الاسم",
                      style: TextStyle(fontWeight: FontWeight.bold),
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
                        controller: nameCont,
                        onChanged: (String? newValue) {
                          setState(() {
                            nameValue = newValue!;
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
              children: [
                Expanded(
                    flex: 2,
                    child: Text(
                      "الجوال",
                      style: TextStyle(fontWeight: FontWeight.bold),
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
                        controller: phoneCont,
                        onChanged: (String? newValue) {
                          setState(() {
                            phoneValue = newValue!;
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
              children: [
                Expanded(
                    flex: 2,
                    child: Text(
                      "جوال اضافي",
                      style: TextStyle(fontWeight: FontWeight.bold),
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
                        controller: phone2Cont,
                        decoration: InputDecoration(hintText: 'اختياري'),
                        onChanged: (String? newValue) {
                          setState(() {
                            phone2Value = newValue!;
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
                    flex: 2,
                    child: Text(
                      "العنوان",
                      style: TextStyle(fontWeight: FontWeight.bold),
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
                        controller: addressCont,
                        onChanged: (String? newValue) {
                          setState(() {
                            addressValue = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            "قم بتحديد موقعك عبر الخريطة",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(
            height: 200,
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 2, color: Get.theme.primaryColor)),
            child: GoogleMap(
              mapType: MapType.hybrid,
              initialCameraPosition: _kInitPosition,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              gestureRecognizers: Set()
                ..add(Factory<EagerGestureRecognizer>(
                    () => EagerGestureRecognizer())),
              onMapCreated: (GoogleMapController controller) async {
                _controller.complete(controller);
              },
              markers: Set<Marker>.of(markers.values),
              onTap: (LatLng latLng) {
                _add(latLng);
                setState(() {
                  locationValue =
                      "http://www.google.com/maps/place/${latLng.latitude},${latLng.longitude}";
                });
              },
            ),
          ),
          Center(
            child: Text(
              "طريقة الدفع",
              style: Get.textTheme.subtitle1!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: RadioListTile(
                  title: Text(
                    "نقدا عند التسليم",
                    style: Get.textTheme.subtitle2!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Get.theme.primaryColor),
                  ),
                  groupValue: paymentMethod,
                  value: 0,
                  onChanged: (val) {
                    setState(() {
                      paymentMethod = 0;
                    });
                  },
                ),
              ),
              Expanded(
                child: RadioListTile(
                  title: Text(
                    "تحويل بنكي",
                    style: Get.textTheme.subtitle2!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Get.theme.primaryColor),
                  ),
                  groupValue: paymentMethod,
                  value: 1,
                  onChanged: (val) {
                    setState(() {
                      paymentMethod = 1;
                    });
                  },
                ),
              ),
            ],
          ),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                widget.cocking
                    ? await Utils().addOrder(
                        userName: nameValue,
                        userPhone: phoneValue,
                        userPhone2: phone2Value,
                        userAddress: addressValue,
                        userLocation: locationValue,
                        paymentMethod: paymentMethod == 0
                            ? "نقدا عند التسليم"
                            : "تحويل بنكي",
                        cocking: widget.cocking,
                        foodOrders: widget.foodOrderItem)
                    : await Utils().addOrder(
                        userName: nameValue,
                        userPhone: phoneValue,
                        userPhone2: phone2Value,
                        userAddress: addressValue,
                        userLocation: locationValue,
                        paymentMethod: paymentMethod == 0
                            ? "نقدا عند التسليم"
                            : "تحويل بنكي",
                        cocking: widget.cocking,
                        orders: widget.orderItem);
              },
              child: Text(
                "اتمام الطلب",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              style: Get.theme.elevatedButtonTheme.style!.copyWith(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
                  backgroundColor:
                      MaterialStateProperty.all(Color(0xff057580))),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        gridItem(
            title: "الهاتف",
            icon: Ionicons.call,
            backgroundColor: Colors.blue,
            onTap: () async {
              if (!await launch(
                "tel:+966506777622",
              )) throw 'Could not launch';
            }),
        gridItem(
            title: "واتساب",
            icon: Ionicons.logo_whatsapp,
            backgroundColor: Colors.green,
            onTap: () async {
              if (!await launch(
                "https://api.whatsapp.com/send?phone=+966506777622",
                universalLinksOnly: true,
              )) throw 'Could not launch';
            }),
        gridItem(
            title: "انستغرام",
            icon: Ionicons.logo_instagram,
            backgroundColor: Colors.pink,
            onTap: () async {
              if (!await launch(
                "https://www.instagram.com/dhbyhmk/",
                universalLinksOnly: true,
              )) throw 'Could not launch';
            }),
        gridItem(
            title: "سناب شات",
            icon: Ionicons.logo_snapchat,
            backgroundColor: Colors.yellow.shade700,
            onTap: () async {
              if (!await launch(
                "https://www.snapchat.com/add/dhabayihmaka",
                universalLinksOnly: true,
              )) throw 'Could not launch';
            }),
      ],
    );
  }

  Widget gridItem(
      {required Function() onTap,
      required IconData icon,
      required String title,
      required Color backgroundColor}) {
    return ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          child: Icon(
            icon,
            color: Colors.white,
          ),
          backgroundColor: backgroundColor,
        ),
        title: Text(title,
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(fontWeight: FontWeight.bold)));
  }
}

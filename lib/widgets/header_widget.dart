import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/controller/global_controller.dart';

class Header extends StatefulWidget {
  const Header({Key? key}) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  String city = "";
  String country = "";
  String date = DateFormat("yMMMMd").format(DateTime.now());

  @override
  void initState() {
    getCity(globalController.getLat().value, globalController.getLng().value);
    super.initState();
  }

  getCity(lat, lon) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);
    Placemark place = placemarks[0];
    setState(() {
      city = place.locality!;
      country = place.country!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Text(
            city,
            style: const TextStyle(
              fontSize: 35.0,
              height: 1.0,
            ),
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 4,
          ),
          child: Text(
            country,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey[700],
              height: 1.0,
            ),
          ),
        ),
        Container(
          alignment: Alignment.topRight,
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 6,
          ),
          child: Text(
            date,
            style: TextStyle(
              fontSize: 14.0,
              height: 1.2,
              color: Colors.blueGrey[600],
            ),
          ),
        ),
      ],
    );
  }
}

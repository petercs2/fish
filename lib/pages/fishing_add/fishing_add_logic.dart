import 'package:fishing/db_fishing/db_fishing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

import '../../db_fishing/fishing_entity.dart';

class FishingAddLogic extends GetxController {

  DBFishing dbFishing = Get.find();

  LatLng? currentLocation;
  DateTime? fishingTime;
  String fishingTimeStr = '';
  String fishSpecies = '';
  var count = 0.obs;
  String mark = '';

  void selectTime(BuildContext context) {
    DatePicker.showDatePicker(context,dateFormat: 'MM/dd/yyyy',onConfirm: (dateTime, List index) {
      fishingTime = dateTime;
      fishingTimeStr = DateFormat('MM/dd/yyyy').format(dateTime);
      update();
    });
  }

  void addFishing() async {
    if (currentLocation == null) {
      Fluttertoast.showToast(msg: 'Please select location');
      return;
    }
    if (fishingTime == null) {
      Fluttertoast.showToast(msg: 'Please select fishing time');
      return;
    }
    if (fishSpecies.isEmpty) {
      Fluttertoast.showToast(msg: 'Please select fish species');
      return;
    }
    if (mark.isEmpty) {
      Fluttertoast.showToast(msg: 'Please input catch description');
      return;
    }
    FishingEntity entity = FishingEntity(
      id: 0,
      createdTime: DateTime.now(),
      lat: currentLocation!.latitude,
      lng: currentLocation!.longitude,
      fishingTime: fishingTime!,
      fishSpecies: fishSpecies,
      count: count.value,
      mark: mark,
    );
    await dbFishing.insertFishing(entity);
    Get.back();
  }

}

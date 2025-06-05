import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class FishingTabLogic extends GetxController {

  PageController pageController = PageController();
  var currentIndex = 0.obs;

  void checkNetwork() async {
    final hadNetwork = await InternetConnectionChecker.instance.hasConnection;
    if (!hadNetwork) {
      Get.toNamed('/sad');
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    checkNetwork();
    super.onInit();
  }

}

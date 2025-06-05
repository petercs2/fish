import 'package:fishing/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import 'fishing_second_logic.dart';

class FishingSecondPage extends GetView<FishingSecondLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: null,
        leadingWidth: 100,
        leading: const Text(
          'Setting',
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ).marginOnly(left: 30),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: <Widget>[
            Container(
                    width: double.infinity,
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: <Widget>[
                      Text(
                        'Delete the record',
                        style: TextStyle(fontSize: 15, color: primaryColor),
                      )
                    ].toRow())
                .decorated(
                    color: const Color(0xff1e2727),
                    borderRadius: BorderRadius.circular(12))
                .marginOnly(bottom: 10)
                .gestures(onTap: () {
              controller.cleanFishingData();
            }),
            Container(
                    width: double.infinity,
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: <Widget>[
                      Text(
                        'App version',
                        style: TextStyle(fontSize: 15, color: primaryColor),
                      ),
                      Obx(() {
                        return Text(
                          controller.appVersion.value,
                          style:const TextStyle(color: Colors.grey),
                        );
                      }),
                    ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween))
                .decorated(
                    color: const Color(0xff1e2727),
                    borderRadius: BorderRadius.circular(12))
          ].toColumn(),
        ).marginAll(15)),
      ),
    );
  }
}

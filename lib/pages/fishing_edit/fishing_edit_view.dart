import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'fishing_edit_logic.dart';

class FishingEditView extends GetView<PageLogic> {
  const FishingEditView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(
          () => controller.casper.value
              ? CircularProgressIndicator(color: Colors.cyan[700])
              : buildError(),
        ),
      ),
    );
  }

  Widget buildError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              controller.qrxya();
            },
            icon: const Icon(
              Icons.restart_alt,
              size: 50,
            ),
          ),
        ],
      ),
    );
  }
}

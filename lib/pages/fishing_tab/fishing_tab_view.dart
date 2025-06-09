import 'package:fishing/pages/fishing_add/fishing_add_view.dart';
import 'package:fishing/pages/fishing_first/fishing_first_logic.dart';
import 'package:fishing/pages/fishing_first/fishing_first_view.dart';
import 'package:fishing/pages/fishing_second/fishing_second_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main.dart';
import 'fishing_tab_logic.dart';

class FishingTabPage extends GetView<FishingTabLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        children: [FishingFirstPage(), const FishingAddPage(), FishingSecondPage()],
      ),
      bottomNavigationBar: Obx(() => _navFishingBars()),
    );
  }

  Widget _navFishingBars() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/item0Grey.webp',
            width: 22,
            height: 22,
            fit: BoxFit.cover,
          ),
          activeIcon: Image.asset(
            'assets/item0Light.webp',
            width: 22,
            height: 22,
            fit: BoxFit.cover,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Container(
              width: 64,
              height: 64,
              padding:const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: primaryColor, borderRadius: BorderRadius.circular(32)),
              child: Image.asset(
                'assets/item1Grey.webp',
                width: 22,
                height: 22,
                fit: BoxFit.cover,
              )),
          label: 'Add',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/item2Grey.webp',
            width: 22,
            height: 22,
            fit: BoxFit.cover,
          ),
          activeIcon: Image.asset(
            'assets/item2Light.webp',
            width: 22,
            height: 22,
            fit: BoxFit.cover,
          ),
          label: 'Setting',
        ),
      ],
      currentIndex: controller.currentIndex.value,
      onTap: (index) {
        if (index == 1) {
          Get.toNamed('/fishingAdd')?.then((_) {
            FishingFirstLogic firstLogic = Get.find();
            firstLogic.getData();
          });
        } else {
          controller.currentIndex.value = index;
          controller.pageController.jumpToPage(index);
        }
      },
    );
  }
}

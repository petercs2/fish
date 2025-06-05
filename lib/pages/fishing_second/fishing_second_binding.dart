import 'package:get/get.dart';

import 'fishing_second_logic.dart';

class FishingSecondBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FishingSecondLogic());
  }
}

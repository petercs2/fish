import 'package:get/get.dart';

import 'fishing_add_logic.dart';

class FishingAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FishingAddLogic());
  }
}

import 'package:get/get.dart';

import 'fishing_first_logic.dart';

class FishingFirstBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FishingFirstLogic());
  }
}

import 'package:fishing/pages/fishing_first/fishing_first_logic.dart';
import 'package:fishing/pages/fishing_second/fishing_second_logic.dart';
import 'package:get/get.dart';

import 'fishing_tab_logic.dart';

class FishingTabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FishingTabLogic());
    Get.lazyPut(() => FishingFirstLogic());
    Get.lazyPut(() => FishingSecondLogic());
  }
}

import 'package:get/get.dart';

import 'fishing_edit_logic.dart';

class AppMjhsndBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      PageLogic(),
      permanent: true,
    );
  }
}

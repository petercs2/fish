import 'package:fishing/db_fishing/db_fishing.dart';
import 'package:get/get.dart';

import '../../db_fishing/fishing_entity.dart';

class FishingFirstLogic extends GetxController {

  DBFishing dbFishing = Get.find();

  var list = <FishingEntity>[].obs;

  void getData() async {
    list.value = await dbFishing.getFishingAllData();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getData();
    super.onInit();
  }


}

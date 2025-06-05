
import 'package:fishing/db_fishing/db_fishing.dart';
import 'package:fishing/pages/fishing_add/fishing_add_binding.dart';
import 'package:fishing/pages/fishing_add/fishing_add_view.dart';
import 'package:fishing/pages/fishing_first/fishing_first_binding.dart';
import 'package:fishing/pages/fishing_first/fishing_first_view.dart';
import 'package:fishing/pages/fishing_second/fishing_second_binding.dart';
import 'package:fishing/pages/fishing_second/fishing_second_view.dart';
import 'package:fishing/pages/fishing_tab/fishing_tab_binding.dart';
import 'package:fishing/pages/fishing_tab/fishing_tab_view.dart';
import 'package:fishing/pages/no_network/no_network_binding.dart';
import 'package:fishing/pages/no_network/no_network_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Color primaryColor = const Color(0xff16cbde);
Color bgColor = const Color(0xff0d1111);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => DBFishing().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: Fishs,
      initialRoute: '/fishingTab',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: bgColor,
        colorScheme: ColorScheme.light(
          primary: primaryColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          unselectedLabelStyle:const TextStyle(color: Color(0xff355458)),
          selectedItemColor: primaryColor,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          elevation: 0,
          backgroundColor: const Color(0xff1e2727),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        cardTheme: const CardTheme(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        dialogTheme: const DialogTheme(
          actionsPadding: EdgeInsets.only(right: 10, bottom: 5),
        ),
        dividerTheme: DividerThemeData(
          thickness: 1,
          color: Colors.grey[200],
        ),
      ),
    );
  }
}

List<GetPage<dynamic>> Fishs = [
  GetPage(name: '/sad', page: () => NoNetworkPage(), binding: NoNetworkBinding()),
  GetPage(name: '/fishingTab', page: () => FishingTabPage(), binding: FishingTabBinding()),
  GetPage(name: '/fishingFirst', page: () => FishingFirstPage(), binding: FishingFirstBinding()),
  GetPage(name: '/fishingSecond', page: () => FishingSecondPage(), binding: FishingSecondBinding()),
  GetPage(name: '/fishingAdd', page: () => const FishingAddPage(), binding: FishingAddBinding()),
];

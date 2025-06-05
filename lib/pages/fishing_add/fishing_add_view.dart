import 'dart:async';

import 'package:fishing/main.dart';
import 'package:fishing/pages/fishing_add/fishing_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:styled_widget/styled_widget.dart';
import 'fishing_add_logic.dart';

class FishingAddPage extends StatefulWidget {
  const FishingAddPage({Key? key}) : super(key: key);

  @override
  State<FishingAddPage> createState() => _FishingAddPageState();
}

class _FishingAddPageState extends State<FishingAddPage> {
  FishingAddLogic controller = Get.find();
  StreamSubscription<Position>? positionStream;
  late MapController mapController;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    _requestLocationPermission();
  }

  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Location permissions required'),
        content:
            const Text('Please grant location permission to measure speed'),
        actions: [
          TextButton(
            onPressed: () => openAppSettings(),
            child: const Text('Setting'),
          ),
        ],
      ),
    );
  }

  Future<void> _requestLocationPermission() async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      positionStream = Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.best,
          distanceFilter: 5,
        ),
      ).listen((Position position) {
        final newPoint = LatLng(position.latitude, position.longitude);
        controller.currentLocation = newPoint;
        mapController.move(newPoint, mapController.camera.zoom);
        controller.update();
      });
    } else {
      _showPermissionDialog();
    }
  }

  Widget _buildMap() {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: const LatLng(0, 0),
        initialZoom: 15,
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.all,
        ),
        onTap: (tapPosition, latLng) {
          controller.currentLocation = latLng;
          mapController.move(
            latLng,
            mapController.camera.zoom,
          );
          controller.update();
        },
      ),
      children: [
        TileLayer(
          urlTemplate:
              'https://{s}.tile-cyclosm.openstreetmap.fr/cyclosm/{z}/{x}/{y}.png',
          subdomains: const ['a', 'b', 'c'],
          userAgentPackageName: 'com.example.run_tracker',
          retinaMode: true,
        ),
        MarkerLayer(
          markers: controller.currentLocation != null
              ? [
                  Marker(
                    point: controller.currentLocation!,
                    width: 40,
                    height: 40,
                    child: const Icon(Icons.location_pin,
                        color: Colors.red, size: 40),
                  )
                ]
              : [],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add record",
          style: TextStyle(color: Colors.white),
        ),
        foregroundColor: Colors.white,
        actions: [
          Text(
            'Commit',
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
          ).marginOnly(right: 20).gestures(onTap: (){
            controller.addFishing();
          })
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
          child: GetBuilder<FishingAddLogic>(builder: (_) {
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: <Widget>[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  child: <Widget>[
                    Text(
                      'Select map punctuation',
                      style: TextStyle(color: primaryColor),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        width: double.infinity,
                        height: 163,
                        child: _buildMap(),
                      ).decorated(color: const Color(0xff435052)),
                    )
                  ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
                ).decorated(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xff1e2727)),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: <Widget>[
                    Text(
                      'Select date',
                      style: TextStyle(color: primaryColor),
                    ),
                    Expanded(
                        child: IgnorePointer(
                      child: FishingTextField(
                          value: controller.fishingTimeStr,
                          textAlign: TextAlign.end,
                          textStyle: TextStyle(color: primaryColor),
                          hintText: 'Select date',
                          onChange: (_) {}),
                    )),
                    const Icon(
                      Icons.keyboard_arrow_right,
                      size: 25,
                      color: Colors.white,
                    )
                  ].toRow(),
                )
                    .decorated(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color(0xff1e2727))
                    .gestures(onTap: () {
                  controller.selectTime(context);
                }),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: <Widget>[
                    Text(
                      'FishSpecies',
                      style: TextStyle(color: primaryColor),
                    ),
                    Expanded(
                        child: FishingTextField(
                            value: controller.fishSpecies,
                            textAlign: TextAlign.end,
                            textStyle: TextStyle(color: primaryColor),
                            onChange: (v) {
                              controller.fishSpecies = v;
                            })),
                  ].toRow(),
                ).decorated(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xff1e2727)),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: <Widget>[
                    Text(
                      'Count',
                      style: TextStyle(color: primaryColor),
                    ),
                    <Widget>[
                      Image.asset('assets/sub.webp', fit: BoxFit.cover)
                          .gestures(onTap: () {
                        if (controller.count.value <= 0) {
                          return;
                        }
                        controller.count.value--;
                      }),
                      const SizedBox(
                        width: 15,
                      ),
                      Obx(() {
                        return Text(
                          controller.count.toString(),
                          style: TextStyle(
                              color: primaryColor, fontWeight: FontWeight.bold),
                        );
                      }),
                      const SizedBox(width: 15),
                      Image.asset('assets/add.webp', fit: BoxFit.cover)
                          .gestures(onTap: () {
                        controller.count.value++;
                      }),
                    ].toRow(mainAxisAlignment: MainAxisAlignment.end)
                  ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
                ).decorated(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xff1e2727)),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  child: <Widget>[
                    Text(
                      'Count',
                      style: TextStyle(color: primaryColor),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FishingTextField(
                        value: controller.mark,
                        padding: EdgeInsets.zero,
                        textStyle: TextStyle(color: primaryColor),
                        maxLength: 200,
                        maxLines: 6,
                        onChange: (v) {
                          controller.mark = v;
                        })
                  ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
                ).decorated(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xff1e2727)),
              ].toColumn(),
            );
          }).marginAll(15),
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (positionStream != null) {
      positionStream?.cancel();
    }
    super.dispose();
  }
}

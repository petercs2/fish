import 'package:fishing/db_fishing/fishing_entity.dart';
import 'package:fishing/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:styled_widget/styled_widget.dart';

import 'fishing_first_logic.dart';

class FishingFirstPage extends GetView<FishingFirstLogic> {
  Widget _buildMap(FishingEntity entity) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(entity.lat, entity.lng),
        initialZoom: 15,
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.all,
        ),
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
          markers: [
            Marker(
              point: LatLng(entity.lat, entity.lng),
              width: 40,
              height: 40,
              child:
                  const Icon(Icons.location_pin, color: Colors.red, size: 40),
            )
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Fishing records',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(child: Obx(() {
          return controller.list.value.isEmpty
              ? Center(
                  child: Text(
                    'No fishing records',
                    style: TextStyle(color: primaryColor),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: controller.list.value.length,
                  itemBuilder: (_, index) {
                    final entity = controller.list.value[index];
                    return <Widget>[
                      <Widget>[
                        Image.asset('assets/icon0.webp', fit: BoxFit.cover),
                        const SizedBox(width: 10),
                        Text(
                          entity.fishingTimeStr,
                          style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )
                      ].toRow(),
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        child: <Widget>[
                          SizedBox(
                            width: double.infinity,
                            height: 163,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15)),
                              child: _buildMap(entity),
                            ),
                          ),
                          <Widget>[
                            Text(
                              '${entity.fishSpecies} x${entity.count}',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              entity.mark,
                              style: TextStyle(
                                  color: primaryColor.withOpacity(0.6),
                                  fontSize: 12),
                            ),
                          ]
                              .toColumn(
                                  crossAxisAlignment: CrossAxisAlignment.start)
                              .marginAll(12)
                        ].toColumn(
                            crossAxisAlignment: CrossAxisAlignment.start),
                      ).decorated(
                          color: const Color(0xff1e2727),
                          borderRadius: BorderRadius.circular(15))
                    ].toColumn().marginOnly(bottom: 10);
                  });
        })),
      ),
    );
  }
}

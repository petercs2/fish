import 'package:intl/intl.dart';

class FishingEntity {
  int id;
  DateTime createdTime;
  double lat;
  double lng;
  DateTime fishingTime;
  String fishSpecies;
  int count;
  String mark;

  FishingEntity({
    required this.id,
    required this.createdTime,
    required this.lat,
    required this.lng,
    required this.fishingTime,
    required this.fishSpecies,
    required this.count,
    required this.mark,
  });

  factory FishingEntity.fromJson(Map<String, dynamic> json) {
    return FishingEntity(
      id: json['id'],
      createdTime: DateTime.parse(json['createdTime']),
      lat: json['lat'],
      lng: json['lng'],
      fishingTime: DateTime.parse(json['fishingTime']),
      fishSpecies: json['fishSpecies'],
      count: json['count'],
      mark: json['mark'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdTime': createdTime.toIso8601String(),
      'lat': lat,
      'lng': lng,
      'fishingTime': fishingTime.toIso8601String(),
      'fishSpecies': fishSpecies,
      'count': count,
      'mark': mark,
    };
  }

  String get fishingTimeStr => DateFormat('MM/dd/yyyy').format(fishingTime);
}

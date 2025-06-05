
import 'package:fishing/db_fishing/fishing_entity.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBFishing extends GetxService {
  late Database dbBase;

  Future<DBFishing> init() async {
    await createFishingDB();
    return this;
  }

  createFishingDB() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, 'fishing.db');

    dbBase = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await createFishingTable(db);
        });
  }

  createFishingTable(Database db) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS fishing (id INTEGER PRIMARY KEY, createdTime TEXT, lat REAL, lng REAL, fishingTime TEXT, fishSpecies TEXT, count INTEGER, mark TEXT)');
  }

  insertFishing(FishingEntity entity) async {
    final id = await dbBase.insert('fishing', {
      'createdTime': entity.createdTime.toIso8601String(),
      'lat': entity.lat,
      'lng': entity.lng,
      'fishingTime': entity.fishingTime.toIso8601String(),
      'fishSpecies': entity.fishSpecies,
      'count': entity.count,
      'mark': entity.mark,
    });
    return id;
  }

  cleanFishingData() async {
    await dbBase.delete('fishing');
  }

  Future<List<FishingEntity>> getFishingAllData() async {
    var result = await dbBase.query('fishing', orderBy: 'fishingTime DESC');
    return result.map((e) => FishingEntity.fromJson(e)).toList();
  }
}

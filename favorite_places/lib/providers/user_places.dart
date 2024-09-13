import 'package:favorite_places/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() : super(const []);

  Future<Database> _getDB() async {
    final dbPath = await sql.getDatabasesPath();
    final db = await sql.openDatabase(
      path.join(dbPath, 'places.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, lng REAL, address TEXT)');
      },
      version: 1,
    );
    return db;
  }

  Future<void> loadPlaces() async {
    final db = await _getDB();
    final data = await db.query("user_places");
    final places = data
        .map((row) => Place(
              id: row['id'] as String,
              title: row['title'] as String,
              image: File(row['image'] as String),
              location: PlaceLocation(
                  latitude: row['lat'] as double,
                  longitude: row['lng'] as double,
                  address: row['address'] as String),
            ))
        .toList();

    state = places;
  }

  void addPlace(String title, File image, PlaceLocation location) async {
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(image.path);
    final copyImage = await image.copy("${appDir.path}/$fileName");

    final newPlace = Place(title: title, image: copyImage, location: location);
    state = [newPlace, ...state];

    final db = await _getDB();
    // onCreate is run the first time the db is created
    db.insert("user_places", {
      "id": newPlace.id,
      "title": newPlace.title,
      "image": newPlace.image.path,
      "lat": newPlace.location.latitude,
      "lng": newPlace.location.longitude,
      "address": newPlace.location.address
    });
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Place>>(
        (ref) => UserPlacesNotifier());

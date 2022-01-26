import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:submission_bfaf_v2/data/db/restaurant_dao.dart';
import 'package:submission_bfaf_v2/model/entity/restaurant_entity.dart';

part 'restaurant_database.g.dart';

@Database(version: 1, entities: [RestaurantEntity])
abstract class RestaurantDatabase extends FloorDatabase {
  RestaurantDao get restaurantDao;
}
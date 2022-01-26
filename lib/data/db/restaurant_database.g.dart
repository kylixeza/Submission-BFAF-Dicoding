// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorRestaurantDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$RestaurantDatabaseBuilder databaseBuilder(String name) =>
      _$RestaurantDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$RestaurantDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$RestaurantDatabaseBuilder(null);
}

class _$RestaurantDatabaseBuilder {
  _$RestaurantDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$RestaurantDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$RestaurantDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<RestaurantDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$RestaurantDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$RestaurantDatabase extends RestaurantDatabase {
  _$RestaurantDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  RestaurantDao? _restaurantDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `restaurant_table` (`id` TEXT NOT NULL, `name` TEXT NOT NULL, `description` TEXT NOT NULL, `city` TEXT, `address` TEXT, `picture_id` TEXT NOT NULL, `rating` REAL NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  RestaurantDao get restaurantDao {
    return _restaurantDaoInstance ??= _$RestaurantDao(database, changeListener);
  }
}

class _$RestaurantDao extends RestaurantDao {
  _$RestaurantDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _restaurantEntityInsertionAdapter = InsertionAdapter(
            database,
            'restaurant_table',
            (RestaurantEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'description': item.description,
                  'city': item.city,
                  'address': item.address,
                  'picture_id': item.pictureId,
                  'rating': item.rating
                }),
        _restaurantEntityDeletionAdapter = DeletionAdapter(
            database,
            'restaurant_table',
            ['id'],
            (RestaurantEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'description': item.description,
                  'city': item.city,
                  'address': item.address,
                  'picture_id': item.pictureId,
                  'rating': item.rating
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<RestaurantEntity> _restaurantEntityInsertionAdapter;

  final DeletionAdapter<RestaurantEntity> _restaurantEntityDeletionAdapter;

  @override
  Future<List<RestaurantEntity>> getAllFavoriteRestaurants() async {
    return _queryAdapter.queryList('SELECT * FROM restaurant_table',
        mapper: (Map<String, Object?> row) => RestaurantEntity(
            row['id'] as String,
            row['name'] as String,
            row['description'] as String,
            row['city'] as String?,
            row['address'] as String?,
            row['picture_id'] as String,
            row['rating'] as double));
  }

  @override
  Future<RestaurantEntity?> getDetailRestaurant(String id) async {
    return _queryAdapter.query('SELECT * FROM restaurant_table WHERE id = ?1',
        mapper: (Map<String, Object?> row) => RestaurantEntity(
            row['id'] as String,
            row['name'] as String,
            row['description'] as String,
            row['city'] as String?,
            row['address'] as String?,
            row['picture_id'] as String,
            row['rating'] as double),
        arguments: [id]);
  }

  @override
  Future<void> insertFavoriteRestaurant(RestaurantEntity restaurant) async {
    await _restaurantEntityInsertionAdapter.insert(
        restaurant, OnConflictStrategy.ignore);
  }

  @override
  Future<void> deleteFavoriteRestaurant(RestaurantEntity restaurant) async {
    await _restaurantEntityDeletionAdapter.delete(restaurant);
  }
}

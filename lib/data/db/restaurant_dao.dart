
import 'package:floor/floor.dart';
import 'package:submission_bfaf_v2/model/entity/restaurant_entity.dart';

@dao
abstract class RestaurantDao {

  @Query('SELECT * FROM restaurant_table')
  Future<List<RestaurantEntity>> getAllFavoriteRestaurants();

  @Query('SELECT * FROM restaurant_table WHERE id = :id')
  Future<RestaurantEntity?> getDetailRestaurant(String id);

  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<void> insertFavoriteRestaurant(RestaurantEntity restaurant);

  @delete
  Future<void> deleteFavoriteRestaurant(RestaurantEntity restaurant);
}
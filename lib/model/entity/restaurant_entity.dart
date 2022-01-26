import 'package:floor/floor.dart';

@Entity(tableName: 'restaurant_table')
class RestaurantEntity {

  @PrimaryKey()
  @ColumnInfo(name: 'id')
  final String id;
  @ColumnInfo(name: 'name')
  final String name;
  @ColumnInfo(name: 'description')
  final String description;
  @ColumnInfo(name: 'city')
  final String? city;
  @ColumnInfo(name: 'address')
  final String? address;
  @ColumnInfo(name: 'picture_id')
  final String pictureId;
  @ColumnInfo(name: 'rating')
  final double rating;


  RestaurantEntity(this.id, this.name, this.description, this.city, this.address, this.pictureId, this.rating);
}
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:submission_bfaf/model/response/result.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "https://restaurant-api.dicoding.dev/")
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  @GET("/list")
  Future<ListResult> getListRestaurants();

  @GET("/detail/{id}")
  Future<DetailResult> getDetailRestaurant(@Path("id") String id);

  @GET("/search")
  Future<ListResult> getListSearch(@Query("q") String q);
}
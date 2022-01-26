import 'package:flutter_test/flutter_test.dart';
import 'package:submission_bfaf_v2/model/response/result.dart';

import 'dummy_data.dart';

void main() {

  test('Parsing List Result JSON', () async {
    var result = ListResult.fromJson(dummyListResult);

    expect(result.error, dummyListResult["error"]);
    expect(result.message, dummyListResult["message"]);
    expect(result.count, dummyListResult["count"]);
    expect(result.founded, null);
    expect(result.restaurants?[0].id, "rqdv5juczeskfw1e867");
    expect(result.restaurants?[1].id, "s1knt6za9kkfw1e867");
    expect(result.restaurants?.length, 2);
  });
  
  test('Parsing Search Result JSON', () {
    var result = ListResult.fromJson(dummySearchResult);

    expect(result.error, dummySearchResult["error"]);
    expect(result.message, null);
    expect(result.count, null);
    expect(result.founded, dummySearchResult["founded"]);
    expect(result.restaurants?[0].id, "fnfn8mytkpmkfw1e867");
    expect(result.restaurants?.length, 1);
  });

  test('Parsing Detail Result JSON', () async {
    var result = DetailResult.fromJson(dummyDetailResult);
    
    expect(result.message, dummyDetailResult["message"]);
    expect(result.error, dummyDetailResult["error"]);
    expect(result.restaurant.id, "rqdv5juczeskfw1e867");
    expect(result.restaurant.name, "Melting Pot");
  });
}
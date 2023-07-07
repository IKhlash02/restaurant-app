import 'package:flutter_test/flutter_test.dart';
import 'package:project_1/data/api/api_service.dart';

void main() {
  test('Pengujian hasil parsing json pada list restaurant', () async {
    var listRestaurant = await ApiService().listRestaurant();

    expect(listRestaurant.length, 20);
    expect(listRestaurant[0].id, 'rqdv5juczeskfw1e867');
    expect(listRestaurant[0].name, 'Melting Pot');
    expect(listRestaurant[0].pictureId, '14');
    expect(listRestaurant[0].city, "Medan");
    expect(listRestaurant[0].rating, 4.2);
  });
}

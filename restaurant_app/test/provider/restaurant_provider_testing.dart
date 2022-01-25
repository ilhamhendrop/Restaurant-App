import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/model/respone_model.dart';
import 'package:restaurant_app/service/testing_service.dart';

import 'restaurant_provider_testing.mocks.dart';


@GenerateMocks([http.Client])
void main() {
  group('Restaurant Api Check', () {
    test('List Restaurant', () async {
      final client = MockClient();

      when(client.get(Uri.parse(TestingApiService.baseUrl + TestingApiService.list)))
            .thenAnswer((_) async => http.Response(
        '{"error":false,"message":"succes","count":20, "restaurants":[]}',
        200
      ));
      expect(await TestingApiService(client).getRestaurant(), isA<Welcome>());
    });
  });
}
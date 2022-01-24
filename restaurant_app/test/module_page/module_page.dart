import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/page/home_page.dart';
import 'package:restaurant_app/provider/list_provider.dart';
import 'package:restaurant_app/service/api_service.dart';

Widget createHomeScreen() => ChangeNotifierProvider<GetRestaurantProvider>(
  create: (context) => GetRestaurantProvider(getApiService: ApiService()),
  child: MaterialApp(
    home: HomePage(),
  ),
);

void main() {
  group('Module Restaurant', () {
    testWidgets('Testing Restaurant List', (WidgetTester tester) async {
      await tester.pumpWidget(createHomeScreen());
      expect(find.byType(Image),findsWidgets);
    });
  });
}
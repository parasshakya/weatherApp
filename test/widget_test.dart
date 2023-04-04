// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/home_page.dart';

import 'package:weather_app/main.dart';

void main() {
  testWidgets('test textformfield', (WidgetTester tester) async {
    //find all widgets needed
    final searchField = find.byType(TextFormField);


    //execute the actual test
    await tester.pumpWidget(const ProviderScope(child:  MaterialApp(home: HomePage(),)));
    await tester.enterText(searchField, 'Kathmandu');

    //check outputs
    expect(find.text("Kathmandu"), findsOneWidget);


  });
}

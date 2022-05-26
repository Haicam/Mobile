import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:prac_haicam/main.dart';

void main() {
  //To find Material Widget in app
  testWidgets('Material app testing pass', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify the widget.
    expect(find.byType(MaterialApp), findsOneWidget);
  });
  //To  not find Material Widget in app
  testWidgets('Material app testing pass fail', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify the widget.
    expect(find.byType(MaterialApp), findsNothing);
  });

  testWidgets('TextField testing', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    var textField = find.byType(TextField);
    expect(textField, findsOneWidget);
  });
}

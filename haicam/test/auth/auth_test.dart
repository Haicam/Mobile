import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prac_haicam/features/auth/view/login_view.dart';
import 'package:prac_haicam/main.dart';

void main() {
  testWidgets('Test widget tree', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(Form), findsOneWidget);
    expect(find.byType(TabBarView), findsOneWidget);
  });
  testWidgets('Test all Text widgets', (WidgetTester tester) async {
    //find all widgets needed
    final logoText = find.text("HAICAM");
    final detailText = find.text("Get great experience with tracky");
    final forgotText = find.text("Forgot Password?");
    final emailText = find.text("Username / Email");
    final passwordText = find.text("Password");

    // execute the actual test
    await tester.pumpWidget(const MaterialApp(home: LoginView()));
    await tester.pump();
    expect(logoText, findsOneWidget);
    expect(detailText, findsOneWidget);
    expect(forgotText, findsOneWidget);
    expect(emailText, findsOneWidget);
    expect(passwordText, findsOneWidget);
  });

  testWidgets('Test all TextField widgets', (WidgetTester tester) async {
    //find all widgets needed
    final emailField = find.byKey(const Key('email'));
    final passwordField = find.byKey(const Key('password'));
    // final nameField = find.byKey(const Key('full_name'));

    // execute the actual test
    await tester.pumpWidget(const MaterialApp(home: LoginView()));

    await tester.enterText(emailField, 'frank@email.com');
    await tester.enterText(passwordField, '123456');

    await tester.pump();

    expect(emailField, findsOneWidget);
    expect(find.text('frank@email.com'), findsOneWidget);

    expect(passwordField, findsOneWidget);
    expect(find.text('123456'), findsOneWidget);

    // expect(nameField, findsOneWidget);
  });

  testWidgets('Test all Buttons widgets', (WidgetTester tester) async {
    //find all widgets needed
    final buttonSignIn = find.text("Sign in");

    // execute the actual test
    await tester.pumpWidget(const MaterialApp(home: LoginView()));
    await tester.tap(buttonSignIn);
    await tester.pump();

    expect(buttonSignIn, findsOneWidget);
  });

  testWidgets('Test no widgets', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    expect(find.byType(Drawer), findsNothing);
  });
}

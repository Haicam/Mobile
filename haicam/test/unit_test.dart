import 'package:flutter_test/flutter_test.dart';

// To check pass test
main() {
  test("Pass test", () {
    // Arrange
    int expectedNumber = 1;

    //Act

    //Actual
    expect(expectedNumber, 1);
  });
// To check fail test
  test("Fail test", () {
    // Arrange
    int expectedNumber = 1;

    //Act

    //Actual
    expect(expectedNumber, 2);
  });
}

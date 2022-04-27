import 'package:haicam/features/home/view/home.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  //Test square function
  test('Testing Square Function', (() {
    expect(const Home().findSquare(2), 5);
  }));
}

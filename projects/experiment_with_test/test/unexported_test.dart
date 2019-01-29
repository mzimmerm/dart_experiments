import 'package:test/test.dart';
import '../lib/src/util/unexported_file.dart';

void main() {

  test('Poly floor and ceil', () {
    Poly p = new Poly(from: 123.04);
    int maxPower = p.maxPower();
    expect(p.floorAt(power: 0), 120);
    expect(p.floorAt(power: 1), 100);
    expect(p.floorAt(power: 2), 0);
    expect(p.floorAt(power: 3), throwsA(throwsException));

    expect(p.ceilAt(power: 0), 130);
    expect(p.ceilAt(power: 1), 200);
    expect(p.ceilAt(power: 2), 1000);
    expect(p.ceilAt(power: 3), throwsA(throwsException));

    // todo 0 test decimals and negatives

  });

}
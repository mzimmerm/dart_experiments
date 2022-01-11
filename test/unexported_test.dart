import 'package:test/test.dart';
// Classes in the package dart_experiments, even those not exported (that is, under src)
//   can be tested by importing them in tests as follows:
import '../example/lib/unexported.dart'; // good
// BAD: import '../lib/src/util/unexported.dart'; // bad - do not step in and out of lib in imports/exports

void main() {

  test('NumWrap operation', () {
    NumWrap p = NumWrap(from: 8.03);
    expect(p.increased(), 9.03);
  });

  test('NumWrap exception', () {
    NumWrap p = NumWrap(from: 9.03);
    // todo-00
    // NOTE: When testing for exception, first argument MUST BE A FUNCTION NAME, NOT A FUNCTION CALL
    expect(p.increased, throwsException);
  });
}

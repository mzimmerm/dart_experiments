import 'package:dart_experiments/src/constructor_1.dart';

// conclusion: CAN A CLASS WITH PUBLIC UNNAMED FACTORY BE EXTENDED IN DART? PROBABLY NOT!!!!
/* Error: The superclass has no UNNAMED constructor
class LoggerOneUnnamedFactoryExtension extends LoggerOneUnnamedFactory {

  // factory LoggerOneUnnamedFactoryExtension(String name) {
    // return super(name);                   //  super is invalid syntax for factory
    // return LoggerOneUnnamedFactory(name); // cannot return superclass from here, only subclass.
    //   SO IF super uses up the UNNAMED PUBLIC FOR FACTORY, and has no other PUBLIC constructor,
    //   there is no way to extend it!!!
    //   The super fromJson, does not help - still creates super instance.

  // }
}
*/

class PointOneUnnamedGenerativeExtension extends PointOneUnnamedGenerative {
  // The (single UNNAMED) constructor (GENERATIVE)
  // This is the PRIMARY GENERATIVE
  //   referring to PUBLIC UNNAMED as super(x)!!!
  PointOneUnnamedGenerativeExtension(double x) : super(x);
  // same as : PointOneUnnamedGenerative(double x) : this.x = x {}

  // Another (must be NAMED) GENERATIVE constructor, forwards to UNNAMED above
  PointOneUnnamedGenerativeExtension.fromJson(Map<String, String> json) :
        this(double.tryParse(json['x']!)!);
}

// Because PointNonExtensibleOneUnnamedGenerative has NO PUBLIC GENERATIVE CONSTRUCTOR,
//   no super(args) can be called, so there is no way to create instance!!

// conclusion: To prevent non-library extension in classes with GENERATIVE constructors,
//             make all GENERATIVE constructors PRIVATE

/*
class PointNonExtensibleOneUnnamedGenerativeExtension extends PointNonExtensibleOneUnnamedGenerative {
  // Error: PointNonExtensibleOneUnnamedGenerative (super of this) does NOT have UNNAMED constructor
  PointNonExtensibleOneUnnamedGenerativeExtension(double x) : super();
  PointNonExtensibleOneUnnamedGenerativeExtension(double x) : super(x);
}
*/


main() {

  // Logger

/* No instance of LoggerOneUnnamedFactoryExtension can be created
  var l1 = LoggerOneUnnamedFactoryExtension('one');
  var l2 = LoggerOneUnnamedFactoryExtension('one');
  assert(identical(l1, l2)); // Uses ==
  assert(l1 == l2); // Uses ==
  var l3 = LoggerOneUnnamedFactoryExtension('two');
  assert(!identical(l1, l3));
  assert(l1 != l3);

  l1.log('from l1');
  l2.log('from l2');
  l3.log('from l3');
*/

  print('');

  // Point
  var p1 = PointOneUnnamedGenerativeExtension(4.0);
  var p2 = PointOneUnnamedGenerativeExtension(5.0);

  print(p1);
  print(p2);

  print('');

  // Non extensible point - no way to create instance

/* todo
  var nep1 = PointNonExtensibleOneUnnamedGenerativeExtension(2.0);
  var nep2 = PointNonExtensibleOneUnnamedGenerativeExtension(3.0);

  print(nep1);
  print(nep2);
*/

}
// See https://stackoverflow.com/questions/53886304/understanding-factory-constructor-code-example-dart
// See https://dart.dev/guides/language/language-tour#factory-constructors

// Terminology: 
//   - Constructor is either FACTORY or NON-FACTORY. NON-FACTORY equivalent name is GENERATIVE.
//   - Both  FACTORY and NON-FACTORY can be both NAMED or UNNAMED.
//   - NAMED is a constructor which has a name after class name, e.g. Logger.fromJSON() { ... }
// Rules:
//   1. Class MAY in principle, have 4 types of constructors: 
//      FACTORY NAMED (0+), FACTORY UNNAMED (0, 1), GENERATIVE NAMED (0+), GENERATIVE UNNAMED (0, 1).
//      - Some combinations are prohibited, and some required, see rules below.
//   2. Class MUST have "exactly one" UNNAMED constructor
//     (this is logical, because constructors are just methods, and method names must be unique)
//       - This unnamed constructor can be either FACTORY or GENERATIVE (NON-FACTORY)
//       - If "exactly zero" NAMED constructors are defined,
//       one will be supplied by default [no arg generative unnamed: MyClass()]
//   3. Class MUST have "at least one" GENERATIVE (NON-FACTORY) constructor
//     - can be NAMED OR UNNAMED
//     - can be library PRIVATE (start with _) or PUBLIC. If PRIVATE, class cannot be extended,
//       because valid extensions must be able to generate a super instance.
//     - Because of Rule 2:
//       - If the UNNAMED FACTORY    is used, this GENERATIVE constructor
//         must be NAMED to satisfy Rules 2 and 3.
//       - If the UNNAMED GENERATIVE is used, it's existence satisfies Rule 3.
//   4. Class MAY have one or more NAMED constructors
//     - If class uses UNNAMED FACTORY constructor, there must be at least
//       one NAMED GENERATIVE (NON-FACTORY) constructor
//       (usually called like Logger._internal), because something has to create the instance.
//   5. If a class has 0 GENERATIVE constructors, and 0 NAMED FACTORY constructors [factory MyClass(args)],
//      a default GENERATIVE PUBLIC constructor MyClass() is generated.
//      Note: The condition 0 NAMED FACTORY is needed, as the generated MyClass name would
//             clash with the named factory.
//      Lemma: If a class has 1 or more private GENERATIVE constructors and 0 public GENERATIVE constructors,
//             it cannot be extended in another library,
//             [because the extension constructor MUST call a GENERATIVE super(args)].
//      Lemma: If a class has only FACTORY constructors, (one or more GENERATIVE must be still provided),
//             it cannot be extended iff all GENERATIVE are private.
//             (in a nutshell, class with FACTORY constructors cannot be extended unless GENERATIVE PUBLIC is provided)

class LoggerOneUnnamedFactory {
  // Instance members
  String? name;
  bool mute = false;

  // _cache is library-private static property (class property)
  static final Map<String, LoggerOneUnnamedFactory?> _cache = <String, LoggerOneUnnamedFactory?>{};

  // The (single UNNAMED) constructor (FACTORY)
  // This is the PRIMARY FACTORY
  factory LoggerOneUnnamedFactory(String name) {
    if (_cache.containsKey(name)) {
      return _cache[name]!;
    } else {
      // Calling NAMED GENERATIVE constructor
      final logger = LoggerOneUnnamedFactory.internal(name); // null -> Runtime Error
      _cache[name] = logger;
      return logger;
    }
    // Shorter alternative : return _cache.putIfAbsent(name, () => Logger._internal(name));
  }

  // Another (must be NAMED) FACTORY constructor, forwards to UNNAMED FACTORY above
  factory LoggerOneUnnamedFactory.fromJson(Map<String, String> json) {
    return LoggerOneUnnamedFactory(json['name'].toString());
  }

  // Library-private GENERATIVE NAMED constructor.
  // Needed - there must be a constructor that actually generates instance
  // If commented out, there is NO WAY to create non-null instance, and
  //   Runtime Error ensues when calling the factory constructor,
  //   but it is NOT a compile error (we made various nullable hacks to achieve that.
  LoggerOneUnnamedFactory.internal(this.name);

  // Error: UNNAMED is already defined: Logger() : name = 'initial';
  
  void log(String msg) {
    if (!mute) print(msg);
  }
  
  @override
  String toString() {
    return 'Logger name=$name, muted=$mute';
  }
}

class PointOneUnnamedGenerative {
  // Instance members
  final double x;

  // The (single UNNAMED) constructor (GENERATIVE)
  // This is the PRIMARY GENERATIVE
  PointOneUnnamedGenerative(this.x);
  // same as : PointOneUnnamedGenerative(double x) : this.x = x {}

  // Another (must be NAMED) GENERATIVE constructor, forwards to UNNAMED above
  PointOneUnnamedGenerative.fromJson(Map<String, String> json) :
    this(double.tryParse(json['x']!)!);

  // PointOneUnnamedGenerative() : x = 0.0; // Error: The unnamed constructor (PointOneUnnamedGenerative) is already defined:

  @override
  String toString() {
    return 'Point p: x=$x';
  }
}

// conclusion: To make a Dart class non-extensible, define all GENERATIVE constructors PRIVATE.
// note:       Such GENERATIVE may be NAMED or UNNAMED. The reason for non-extensibility is,
//             if we define (in code) a GENERATIVE constructor, Dart no longer
//             generates the default no-argument constructor
//             (which WOULD be PUBLIC as it's name would be same as class name , without _ ).
class PointNonExtensibleOneUnnamedGenerative {
  // Instance members
  final double? x;

  // The (NAMED) constructor (GENERATIVE)
  // This is the PRIMARY GENERATIVE
  // IMPORTANT NOTE: IF WE DEFINE *ANY* GENERATIVE constructor (NAMED or UNNAMED),
  //                 (as we do here with _internal(this.x))
  //                 then Dart does NOT generate the default no-arg
  //                 NAMED PointNonExtensibleOneUnnamedGenerative,
  //                 so if the GENERATIVE is PRIVATE
  //                 (as it is here _internal(this.x)),
  //                 then such class in NON EXTENSIBLE
  PointNonExtensibleOneUnnamedGenerative._internal(this.x);
  // same as : PointNonExtensibleOneUnnamedGenerative._(double x) : this.x = x {}

  // NO PUBLIC CONSTRUCTOR may exist if we want to make this non-extensible
  // PointNonExtensibleOneUnnamedGenerative.fromJson(Map<String, String> json) :
  //       this._(double.tryParse(json['x']!)!);

  @override
  String toString() {
    return 'Point nep: x=$x';
  }
}

main() {

  // Logger

  var l1 = LoggerOneUnnamedFactory('one');
  var l2 = LoggerOneUnnamedFactory('one');
  assert(identical(l1, l2)); // Uses ==
  assert(l1 == l2); // Uses ==
  var l3 = LoggerOneUnnamedFactory('two');
  assert(!identical(l1, l3));
  assert(l1 != l3);

  // var l4 = LoggerOneUnnamedFactory(); // Not generated, as GENERATIVE LoggerOneUnnamedFactory(NAME) exists
  
  l1.log('from l1');
  l2.log('from l2');
  l3.log('from l3');

  print('');

  // Point
  var p1 = PointOneUnnamedGenerative(0.0);
  var p2 = PointOneUnnamedGenerative(1.0);

  print(p1);
  print(p2);

  print('');

  // Non extensible point

  // We can create instance using '_' in the same library, but not outside of it.
  // So no extensions of PointNonExtensibleOneUnnamedGenerative can exist!
  var nep1 = PointNonExtensibleOneUnnamedGenerative._internal(2.0);
  var nep2 = PointNonExtensibleOneUnnamedGenerative._internal(3.0);
  // var nep3 = PointNonExtensibleOneUnnamedGenerative(); // This does not exist - is NOT generated!!

  print(nep1);
  print(nep2);

}
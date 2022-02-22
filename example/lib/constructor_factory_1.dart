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
//   2. Class MUST have "exactly one" UNNAMED constructor.
//     - This unnamed constructor can be either FACTORY or GENERATIVE (NON-FACTORY)
//     - If "exactly zero" name constructors are defined, one will be supplied by default [no arg generative unnamed: MyClass()]
//   3. Class MUST have "at least one" GENERATIVE (NON-FACTORY) constructor. 
//     - Because of Rule 2:
//       - If the UNNAMED FACTORY    is used, this GENERATIVE constructor must be NAMED
//       - If the UNNAMED GENERATIVE is used, it's existence satisfies Rule 3 
//   4. Class MAY have one or more NAMED constructors
//     - If class uses UNNAMED FACTORY constructor, there must be at least one NAMED GENERATIVE (NON-FACTORY) constructor 
//       (usually called like Logger._internal), because something has to create the instance.

class Logger {
  // Instance properties
  final String name;
  bool mute = false;

  // _cache is library-private static property (class property)
  static final Map<String, Logger> _cache = <String, Logger>{};

  // The (single UNNAMED) FACTORY constructor
  // This is the PRIMARY FACTORY
  factory Logger(String name) {
    if (_cache.containsKey(name)) {
      return _cache[name]!;
    } else {
      // Calling NAMED GENERATIVE constructor
      final logger = Logger._internal(name);
      _cache[name] = logger;
      return logger;
    }
    // Shorter alternative : return _cache.putIfAbsent(name, () => Logger._internal(name));
  }

  // Another (must be NAMED) FACTORY constructor
  factory Logger.fromJson(Map<String, Object> json) {
    return Logger(json['name'].toString());
  }

  // Library-private GENERATIVE NAMED constructor.
  // Needed - there must be a constructor that actually generates instance
  Logger._internal(this.name);

  // Error: UNNAMED is already defined: Logger() : name = 'initial';
  
  void log(String msg) {
    if (!mute) print(msg);
  }
  
  @override
  String toString() {
    return 'Logger name=$name, muted=$mute';
  }
}

main() {
  
  var l1 = Logger('one');
  var l2 = Logger('one');
  assert(identical(l1, l2));
  assert(l1 == l2);
  var l3 = Logger('two');
  assert(!identical(l1, l3));
  assert(l1 != l3);
  
  l1.log('from l1');
  l2.log('from l2');
  l3.log('from l3');

}
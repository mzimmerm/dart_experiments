Experimenting with Dart.

There is no Flutter build or anything like that.

Directory structure nutshell:

- Sample command-line application with an entrypoint in `bin/`
- Publicly visible (automatically exported) library code in `lib/` and subdirectories. 
- Publicly invisible                        library code in `lib/src` and subdirectories. Library can export some files (packages) by placing 'export src/more/more1.dart' on the `lib/` level, e.g. in `enchilada.dart`. Then everything in `more/more1.dart` becomes publicly available. 
- example unit test in `test/`.


 See https://dart.dev/tools/pub/package-layout for directory structure details.
 
 ```
enchilada/
  .dart_tool/ *
  .packages *
  pubspec.yaml
  pubspec.lock **
  LICENSE
  README.md
  CHANGELOG.md
  benchmark/
    make_lunch.dart
  bin/
    enchilada
  doc/
    api/ ***
    getting_started.md
  example/
    main.dart
  lib/
    enchilada.dart : this could make visible publicly private library in src, by e.g. 'export src/more/more1.dart'
    tortilla.dart
    guacamole.css
    deeper/
      deeper.dart
    src/
      beans.dart
      queso.dart
      more/
        more1.dart
        more2.dart      
  test/
    enchilada_test.dart
    tortilla_test.dart
  tool/
    generate_docs.dart
  web/
    index.html
    main.dart
    style.css
```

Notes:
  - Clients have no way to see or refer to `src/more/more2.dart`.
  - Code in this package (anything under top enchilada/) can still import even unexported files (that is, under src)
  -                                                     by adding `import 'package:enchilada/src/more/more2.dart`
  -    This is necessary for tests to be able to test unexported files under src.
  - Clients can refer to everything in `enchilada.dart` by adding `import 'package:enchilada/enchilada.dart`
  - Clients can refer to everything in `tortilla.dart`  by adding `import 'package:enchilada/tortilla.dart`
  - Clients can refer to everything in `deeper.dart`    by adding `import 'package:enchilada/deeper/deeper.dart`


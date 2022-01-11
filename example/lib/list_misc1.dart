main() {
  // List constructors: generate and filled. See https://api.dart.dev/stable/2.15.1/dart-core/List/List.filled.html
  // Declare and initialize a matrix x having
  // m rows and n columns, containing real numbers.
  int numRows = 2, numCols = 3;
  List<List<double>> rows = List<List<double>>.generate(numRows, (_) => List<double>.filled(numCols, 0.0));
  int rowIndex = 0, colIndex = 0;
  for (var row in rows) {
    for (var col in row) {
      print('Position row=$rowIndex, col=$colIndex, value=$col');
      colIndex++;
    }
    rowIndex++;
  }

  // List comprehension in Dart. Can be user do iterate 2 arrays in parallel.
  var arr1 = [1, 2, 3, 4];
  var arr2 = [2, 3, 4, 5];

  var times = [for (int i = 0; i < arr1.length; i += 1) arr1[i] * arr2[i]]; // Foo(a[i], b[i])];

  print('${times.toList()}');
}

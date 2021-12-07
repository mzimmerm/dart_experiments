
class NumWrap {
  /// Number represented by this [NumWrap].
  final num _num;

  NumWrap({
    required num from,
  }) : _num = from ;

  num increased() {
    if (_num + 1 >= 10.0) {
      throw AboveLimitException('Wrapped + 1 = $_num above limit of 10.0');
      // todo-00 can this be done? throw Exception('Wrapped + 1 = $_num above limit of 10.0');
    }
    return _num + 1;
  }
}

/// Also a decent example of how to extend abstract Exception which only has factory constructor.
/// So a generative constructor must be added.
/*
    todo-00 : 'extends Exception' will never work, because Exception has only factory constructor,
              and as that constructor cannot possibly know about an extension we are creating here, 
              it cannot return instance of this extension , even if we add a generative constructor here.
              As a result, we must 'implements Exception'
*/

class AboveLimitException implements Exception {
  String message;
  AboveLimitException(this.message);
}

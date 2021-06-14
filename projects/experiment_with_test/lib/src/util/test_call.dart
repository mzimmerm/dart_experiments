class Greet implements Function {
  String _greeting;
  Greet(this._greeting);
/*
  String call(String name) {
    return _greeting + ' ' + name;
  }
 */
// alternative syntax for function
// call(String name) => _greeting + ' '+ name; 
// => is equivalent to the return statement
}

String followUp(String name) => 'FollowUp with ' + name;


void main() {
  Greet hello = new Greet('Hello');

  // call needed: print(hello('Ali'));
  print(followUp.call == followUp); // True. 
  // So, it looks like .call is implicitly after any Function object!!
  print(followUp('John direct'));
  print(followUp.call('John called')); // is same as the above
  print(Function.apply(followUp, ['John applied'])); // dynamically call = apply - what is the advantage?
// you can call followUp('John') as well
  // call is implicitly called
}
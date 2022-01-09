/// Describes the role of function named [call] on Classes and Functions.

class Greet {
  final String _greeting;
  Greet(this._greeting);
  String call(String name) {
    return _greeting + ' ' + name;
  }
  String methodA(String arg) {
    return 'methodA with arg $arg';
  }
}

String followUp(String name) => 'FollowUp with ' + name;
// todo-00 move to top level
void main() {
  // Class: Presence of method named 'call' on class
  // converts the object to a function, in the sense that calling in code
  //    instanceOfGreet('someone')
  // is equivalent to 
  //    instanceOfGreet.call('someone')
  Greet greet = Greet('Hello');
  print(greet == greet.call); // Interestingly False.
  print(greet('Ali'));
  print(greet.call('Ali differently'));
  
  // Stuff below shows, on a member method that 'call' stuff works same as for the Function 'followUp'
  print(greet.methodA == greet.methodA.call); // True.
  print (greet.methodA.call('hey'));
  print (greet.methodA('hey'));
  
  print('---');
  
  // Function: Here we establish that every Function call using funcName(args)
  //   is actually a redirect to funcName.call(args)
  print(followUp.call == followUp); // True. 
  // So, it looks like .call is implicitly after any Function object!!
  print(followUp('John direct')); // Function is adding a .call anyway. This is how it is implemented.
  print(followUp.call('John called')); // is same as the above
  print(Function.apply(followUp, ['John applied'])); // dynamically call = apply - what is the advantage?
  // call is implicitly called
}

// Shows how we can still do dynamic invocation (aka Duck typing) in Dart 2.0

class Dog {
  eatMeat() {
    print("Eating meat, ooph ooph");
  }
}

class Cat {
  eatMeat() {
    print("Eating meat, mew mew");
  }
}

main() {
  
  var cat = Cat();
  var dog = Dog();
  
  // The List must explicitly be <dynamic>. Object, Null, void do not work 
  List<dynamic> animals = [cat, dog];
  
  // Compiles and outputs:
  //   Eating meat, mew mew
  //   Eating meat, ooph ooph
  for (var animal in animals) {
    animal.eatMeat();
  }
}

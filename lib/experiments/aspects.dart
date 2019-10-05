class PrinterAspect {

  invoke(List args, Function function){
    print("some stuff prior to invokation: " + function.toString());
    Function.apply(function, args);
    print("some stuff after invokation: " + function.toString());
  }

}

class SomeClass with PrinterAspect {

  int calculate(String s){
    return invoke([s], _calculate);
  }

  int _calculate(String s){
    return s.length;
  }

  String get(){
    return "something dynamic";
  }
}

class AnotherClass with PrinterAspect {

  int doAFlip(){
    return invoke([], _doAFlip);
  }

  static int _doAFlip(){
    SomeClass sc = new SomeClass();
    int value1 = sc.calculate(sc.get());
    SomeClass sc2 = new SomeClass();
    int value2 = sc2.calculate(sc.get());
    return value1 + value2;
  }
}
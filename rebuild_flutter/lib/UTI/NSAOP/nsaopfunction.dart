import 'package:aspectd/aspectd.dart';
import 'package:flutter/src/widgets/binding.dart';

@Aspect()
@pragma("vm:entry-point")
class NSAOPFunction{
  @Call("package:flutter/src/widgets/binding.dart","","+runApp")
  @pragma("vm:entry-point")
  static void runAppKWLM(PointCut pointcut){
    print('Aspectd:KWLM07');
    print('${pointcut.sourceInfos.toString()}');
    pointcut.proceed();
  }
}
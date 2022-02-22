import 'dart:math' as math;
import 'package:vector_math/vector_math.dart' as vector_math;
main() {

  double angle = math.pi / 4;
  
  var angleTransform = vector_math.Matrix2.rotation(angle);
  var negAngleTransform = vector_math.Matrix2.rotation(-angle);
  
  var angleTransformInverted = angleTransform.clone();
  angleTransformInverted.invert();
  
  assert (angleTransformInverted == negAngleTransform);
  
}
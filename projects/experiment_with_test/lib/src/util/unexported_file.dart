import 'dart:math' as math show min, max;


/// Not quite a polynomial. Just the minimum needed for Y label and axis
/// scaling.
///
/// todo 0 - This needs to be replaced with simple rounding at power (divide or multiply!!)
class Poly {
  /// Number represented by this [Poly].
  num _num;

  /// negative indicator
  bool _isNegative = false;

  /// Create
  Poly({num from}) {
    _num = from;
  }

  int _scale({int power}) {
    if (power >= 0) return 10 ^ (power + 1);
    else            return 10 ^ power;
  }

  int _scaleSelfDown({int power}) {
    return (_num / _scale(power: power)).toInt();
  }
  int floorAt({int power}) {
    return _scaleSelfDown( power: power) * _scale(power: power);
  }

  int ceilAt({int power}) {
    return (_scaleSelfDown( power: power) + 10) * _scale(power: power);
  }
}


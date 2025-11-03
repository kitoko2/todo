import 'package:flutter/material.dart';

ColorFilter getColorFiler(Color color) {
  return ColorFilter.mode(color, BlendMode.srcIn);
}

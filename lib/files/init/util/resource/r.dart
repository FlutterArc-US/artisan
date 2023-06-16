library r;

import 'package:flutter/material.dart';

part 'data/images.dart';
part 'data/jsons.dart';
part 'data/colors.dart';

class R {
  R._();

  static const images = _Images();
  static const jsons = _Jsons();
  static const colors = _AppColors();
}

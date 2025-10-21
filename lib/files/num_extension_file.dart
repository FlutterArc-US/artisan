const numExtensionContents = '''
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

double? _verticalPadding;

void setPadding({required BuildContext context}) {
  _verticalPadding = MediaQuery.of(context).padding.top +
      MediaQuery.of(context).padding.bottom;
}

extension HB on num {
  SizedBox get hb {
    return SizedBox(
      height: safeH,
    );
  }

  SizedBox get wb {
    return SizedBox(
      width: w,
    );
  }

  double get safeH {
    assert(_verticalPadding != null);
    return ((this) * ((1.sh - (_verticalPadding ?? 0.0)) / 1.sh)).h;
  }
}
''';

import 'package:flutter/widgets.dart';

extension ResponsiveSize on num {
  double w(BuildContext context) =>
      this * MediaQuery.of(context).size.width / 375;
  double h(BuildContext context) =>
      this * MediaQuery.of(context).size.height / 812;
}

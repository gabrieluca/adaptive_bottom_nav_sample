import 'package:flutter/widgets.dart';

/// Holds information about our app's flows.
class AppFlow {
  const AppFlow({
    @required this.title,
    @required this.mainColor,
    @required this.menuIcon,
    @required this.selectedMenuIcon,
    @required this.navigatorKey,
  })  : assert(title != null),
        assert(mainColor != null),
        assert(menuIcon != null),
        assert(selectedMenuIcon != null),
        assert(navigatorKey != null);

  final String title;
  final Color mainColor;
  final IconData menuIcon;
  final IconData selectedMenuIcon;
  final GlobalKey<NavigatorState> navigatorKey;
}

import 'package:flutter/widgets.dart';

/// Holds information about our app's flows.
class MainTabs {
  const MainTabs({
    @required this.title,
    @required this.tabIcon,
    @required this.selectedTabIcon,
    @required this.navigatorKey,
  })  : assert(title != null),
        assert(tabIcon != null),
        assert(selectedTabIcon != null),
        assert(navigatorKey != null);

  final String title;
  final IconData tabIcon;
  final IconData selectedTabIcon;
  final GlobalKey<NavigatorState> navigatorKey;
}

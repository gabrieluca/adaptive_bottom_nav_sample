import 'package:adaptive_bottom_nav_sample/app_flow.dart';
import 'package:adaptive_bottom_nav_sample/indexed_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Contains our different pages flows and bottom navigation menu for
/// alternating between them.
///
/// It's called Screen — not Page — to avoid confusion, this one displays
/// Pages inside it.
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentBarIndex = 0;
  final List<AppFlow> appFlows = [
    AppFlow(
      title: 'Home',
      menuIcon: Icons.ondemand_video,
      selectedMenuIcon: Icons.home,
      mainColor: Colors.red,
      navigatorKey: GlobalKey<NavigatorState>(),
    ),
    AppFlow(
      title: 'Arena',
      menuIcon: Icons.music_note,
      selectedMenuIcon: Icons.business,
      mainColor: Colors.green,
      navigatorKey: GlobalKey<NavigatorState>(),
    ),
    AppFlow(
      title: 'Profile',
      menuIcon: Icons.satellite,
      selectedMenuIcon: Icons.person,
      mainColor: Colors.yellow,
      navigatorKey: GlobalKey<NavigatorState>(),
    ),
    AppFlow(
      title: 'Store',
      menuIcon: Icons.fastfood,
      selectedMenuIcon: Icons.store,
      mainColor: Colors.blue,
      navigatorKey: GlobalKey<NavigatorState>(),
    ),
    AppFlow(
      title: 'Play',
      menuIcon: Icons.games,
      selectedMenuIcon: Icons.play_circle_filled,
      mainColor: Colors.purple,
      navigatorKey: GlobalKey<NavigatorState>(),
    )
  ];

  @override
  Widget build(BuildContext context) {
    final currentFlow = appFlows[_currentBarIndex];

    // We're preventing the root navigator from popping and closing the app
    // when the back button is pressed and the inner navigator can handle it.
    // That occurs when the inner has more than one page on its stack.
    // You can comment the onWillPop callback and watch "the bug".
    return WillPopScope(
      // Todo understand boolean
      onWillPop: () async =>
          !await currentFlow.navigatorKey.currentState.maybePop(),
      child: Scaffold(
        body: IndexedStack(
          index: _currentBarIndex,
          children: appFlows
              .map(
                _buildIndexedPageFlow,
              )
              .toList(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentBarIndex,
          items: appFlows
              .map(
                (menus) => BottomNavigationBarItem(
                    title: Text(menus.title),
                    icon: Icon(menus.menuIcon),
                    activeIcon: Icon(menus.selectedMenuIcon)),
              )
              .toList(),
          onTap: (newIndex) => setState(
            () {
              if (_currentBarIndex != newIndex) {
                _currentBarIndex = newIndex;
              } else {
                // If the user is re-selecting the tab, the common
                // behavior is to empty the stack.
                currentFlow.navigatorKey.currentState
                    .popUntil((route) => route.isFirst);
              }
            },
          ),
        ),
      ),
    );
  }

  // The best practice here would be to extract this to another Widget,
  // however, moving it to a separate class would only harm the
  // readability of our guide.
  Widget _buildIndexedPageFlow(AppFlow appFlow) => Navigator(
        // The key enables us to access the Navigator's state inside the
        // onWillPop callback and for emptying its stack when a tab is
        // re-selected. That is why a GlobalKey is needed instead of
        // a simpler ValueKey.
        key: appFlow.navigatorKey,
        // Since this isn't the purpose of this sample, we're not using named
        // routes. Because of that, the onGenerateRoute callback will be
        // called only for the initial route.
        onGenerateRoute: (settings) => MaterialPageRoute(
          settings: settings,
          builder: (context) => IndexedPage(
            index: 1,
            containingFlowTitle: appFlow.title,
            backgroundColor: appFlow.mainColor,
          ),
        ),
      );
}

import 'package:adaptive_bottom_nav_sample/main_tabs.dart';
import 'package:adaptive_bottom_nav_sample/indexed_page.dart';
import 'package:adaptive_bottom_nav_sample/pages/arena.dart';
import 'package:adaptive_bottom_nav_sample/pages/home.dart';
import 'package:adaptive_bottom_nav_sample/pages/play.dart';
import 'package:adaptive_bottom_nav_sample/pages/profile.dart';
import 'package:adaptive_bottom_nav_sample/pages/store.dart';
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
  int _currentTabIndex = 0;
  final List<MainTabs> mainTabs = [
    MainTabs(
      title: 'Xports',
      tabIcon: Icons.ondemand_video,
      selectedTabIcon: Icons.home,
      navigatorKey: GlobalKey<NavigatorState>(),
    ),
    MainTabs(
      title: 'Play',
      tabIcon: Icons.games,
      selectedTabIcon: Icons.play_circle_filled,
      navigatorKey: GlobalKey<NavigatorState>(),
    ),
    MainTabs(
      title: 'Arena',
      tabIcon: Icons.music_note,
      selectedTabIcon: Icons.business,
      navigatorKey: GlobalKey<NavigatorState>(),
    ),
    MainTabs(
      title: 'Profile',
      tabIcon: Icons.satellite,
      selectedTabIcon: Icons.person,
      navigatorKey: GlobalKey<NavigatorState>(),
    ),
    MainTabs(
      title: 'Store',
      tabIcon: Icons.fastfood,
      selectedTabIcon: Icons.store,
      navigatorKey: GlobalKey<NavigatorState>(),
    ),
  ];

  final List<Widget> _tabPages = [
    HomePage(),
    PlayPage(),
    ArenaPage(),
    ProfilePage(),
    StorePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final currentTab = mainTabs[_currentTabIndex];

    // We're preventing the root navigator from popping and closing the app
    // when the back button is pressed and the inner navigator can handle it.
    // That occurs when the inner has more than one page on its stack.
    // You can comment the onWillPop callback and watch "the bug".
    return WillPopScope(
      // Todo understand boolean
      onWillPop: () async =>
          !await currentTab.navigatorKey.currentState.maybePop(),
      child: Scaffold(
        body: IndexedStack(
          // a page for every tab
          index: _currentTabIndex,
          children: mainTabs
              .map(
                _buildIndexedPageTab,
              )
              .toList(),

          // children: _tabPages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentTabIndex,
          items: mainTabs
              .map(
                (menus) => BottomNavigationBarItem(
                    title: Container(),
                    icon: Icon(menus.tabIcon),
                    activeIcon: Icon(menus.selectedTabIcon)),
              )
              .toList(),
          onTap: (newIndex) => setState(
            () {
              if (_currentTabIndex != newIndex) {
                _currentTabIndex = newIndex;
              } else {
                // If the user is re-selecting the tab, the common
                // behavior is to empty the stack.
                currentTab.navigatorKey.currentState
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
  Widget _buildIndexedPageTab(MainTabs mainTabs) => Navigator(
        // The key enables us to access the Navigator's state inside the
        // onWillPop callback and for emptying its stack when a tab is
        // re-selected. That is why a GlobalKey is needed instead of
        // a simpler ValueKey.
        key: mainTabs.navigatorKey,
        // Since this isn't the purpose of this sample, we're not using named
        // routes. Because of that, the onGenerateRoute callback will be
        // called only for the initial route.
        onGenerateRoute: (settings) => MaterialPageRoute(
          settings: settings,
          builder: (context) => _tabPages[_currentTabIndex],
          // IndexedPage(
          //   index: 1,
          //   tabPagesTitle: mainTabs.title,
          // ),
        ),
      );
}

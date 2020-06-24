import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    this.index,
    this.backgroundColor,
    this.tabPagesTitle,
    Key key,
  }) : super(key: key);

  final int index;
  final Color backgroundColor;
  final String tabPagesTitle;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text('Home')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Horizontally pushes a new screen.
              RaisedButton(
                onPressed: () {
                  _pushPage(context, true);
                },
                child: const Text('NEXT PAGE (HORIZONTALLY)'),
              ),

              // Vertically pushes a new screen / Starts a new flow.
              // In a real world scenario, this could be an authentication flow
              // where the user can choose to sign in or sign up.
              RaisedButton(
                onPressed: () {
                  _pushPage(context, false);
                },
                child: const Text('NEXT FLOW (VERTICALLY)'),
              ),
            ],
          ),
        ),
      );
  void _pushPage(
    BuildContext context,
    bool isHorizontalNavigation,
  ) {
    // If it's not horizontal navigation,
    // we should use the rootNavigator.
    Navigator.of(
      context,
      rootNavigator: !isHorizontalNavigation,
    ).push(
      MaterialPageRoute(
        builder: (context) => HomePage(),
        fullscreenDialog: !isHorizontalNavigation,
      ),
    );
  }
}

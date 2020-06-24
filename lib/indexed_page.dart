import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Page that displays its index, flow's title and color.
///
/// Has a button for pushing another one of its kind with an incremented index,
/// and another button for starting a new flow named 'New' with
/// a random background color.
class IndexedPage extends StatelessWidget {
  const IndexedPage({
    this.index,
    this.backgroundColor,
    this.tabPagesTitle,
    Key key,
  }) : super(key: key);

  final int index;
  final Color backgroundColor;
  final String tabPagesTitle;

  @override
  Widget build(BuildContext context) {
    var pageTitle = 'Page $index';
    if (tabPagesTitle != null) {
      pageTitle += ' of $tabPagesTitle';
    }
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          pageTitle,
          maxLines: 1,
        ),
      ),
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
  }

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
          builder: (context) => IndexedPage(
                // If it's a new flow, the displayed index should be 1 again.
                index: isHorizontalNavigation ? index + 1 : 1,
              ),
          fullscreenDialog: !isHorizontalNavigation),
    );
  }
}

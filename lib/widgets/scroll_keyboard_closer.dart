import 'package:flutter/material.dart';

/// A widget that listens for [ScrollNotification]s bubbling up the tree
/// and close the keyboard on user scroll.
class ScrollKeyboardCloser extends StatelessWidget {
  final Widget child;

  ScrollKeyboardCloser({@required this.child});

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        if (scrollNotification is UserScrollNotification) {
          // close keyboard
          FocusScope.of(context).unfocus();
        }
        return false;
      },
      child: child,
    );
  }
}

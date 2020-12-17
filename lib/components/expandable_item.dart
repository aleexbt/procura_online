import 'package:flutter/material.dart';
import 'package:procura_online/models/expandable_model.dart';

import 'text_widget.dart';

/*class ExpandableItem extends StatelessWidget {
  final bool expanded;
  final double collapsedHeight;
  final double expandedHeight;
  final Widget child;

  ExpandableItem({
    @required this.child,
    this.collapsedHeight = 0.0,
    this.expandedHeight = 300.0,
    this.expanded = true,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return new AnimatedContainer(
      duration: new Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      width: screenWidth,
      height: expanded ? expandedHeight : collapsedHeight,
      child: new Container(
        child: child,
        decoration: new BoxDecoration(
            border: new Border.all(width: 1.0, color: Colors.blue)),
      ),
    );
  }
}*/
// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
class ExpandableItem extends StatelessWidget {
  const ExpandableItem(this.entry);

  final ExpandableModel entry;

  Widget _buildTiles(ExpandableModel root) {
    if (root.children.isEmpty) return ListTile(title: Text(root.title));
    return ExpansionTile(
      key: PageStorageKey<ExpandableModel>(root),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextWidget(
            text: root.title,
            textType: TextType.TEXT_LARGE,
          ),
          TextWidget(
            text: root.title,
          ),
        ],
      ),
      children: root.children.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}

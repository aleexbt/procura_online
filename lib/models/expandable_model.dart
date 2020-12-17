// One entry in the multilevel list displayed by this app.
class ExpandableModel {
  ExpandableModel(this.title, [this.children = const <ExpandableModel>[]]);
  final String title;
  final List<ExpandableModel> children;
}
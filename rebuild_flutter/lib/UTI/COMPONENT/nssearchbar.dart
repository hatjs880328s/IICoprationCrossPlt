import 'package:flutter/material.dart';

class nssearchbarDelegate extends SearchDelegate<String> {

  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(
      icon: Icon(Icons.clear),
      onPressed: () {
        query == "";
        buildSuggestions(context);
      },
    )];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('halo');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Text('输入文件名');
  }

}
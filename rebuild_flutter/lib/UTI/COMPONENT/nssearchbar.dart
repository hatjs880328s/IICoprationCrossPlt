import 'package:flutter/material.dart';

const searchList = [
  'jiejie-大长腿',
  'jiejie-水蛇腰',
  'gege-帅气欧巴',
  'gege-小鲜肉'
];

const recentSuggest = [
  '推荐-1',
  '推荐-2',
];

class nssearchbarDelegate extends SearchDelegate<String> {

  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(
      icon: Icon(Icons.clear),
      onPressed: () {
        query = "";
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
    return Container(
      width: 100.0,
      height:100.0,
      child: Card(
        color:Colors.redAccent,
        child: Center(
          child: Text(query),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionsList= query.isEmpty
      ? recentSuggest 
      : searchList.where((input)=> input.startsWith(query)).toList();

    return ListView.builder(
      itemCount:suggestionsList.length,
      itemBuilder: (context,index) => ListTile(
        title: RichText( //富文本
          text: TextSpan(
            text: suggestionsList[index].substring(0,query.length),
            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                text: suggestionsList[index].substring(query.length),
                style: TextStyle(color: Colors.grey)
              )
            ]
          ),
        ),
      ),
    ); 
  }

}
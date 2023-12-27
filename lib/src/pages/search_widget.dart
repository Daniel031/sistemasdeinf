import 'package:flutter/material.dart';
import 'package:sist/src/pages/map_widget.dart';

class CustomSearchDelegate extends SearchDelegate {
  List<dynamic> myList;
  List<dynamic> myList2;
  List<dynamic> myList3;
  int tipo;
  String searchText;
  MapScreen reference;

  CustomSearchDelegate(this.myList, this.myList2, this.myList3, this.searchText,
      this.reference, this.tipo);

  @override
  String get searchFieldLabel => searchText;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<dynamic> matchQuery = [];
    for (var element in myList) {
      String aux = '^.*$query.*';
      RegExp regex = RegExp(aux, caseSensitive: false);
      // if (element.nombre.toLowerCase().contains(query.toLowerCase())) {
      if (regex.hasMatch(element.nombre)) {
        matchQuery.add(element);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result.nombre),
            onTap: () {},
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<dynamic> matchQuery = [];
    for (var element in myList) {
      String aux = '^.*$query.*';
      RegExp regex = RegExp(aux, caseSensitive: false);
      // if (element.nombre.toLowerCase().contains(query.toLowerCase())) {
      if (regex.hasMatch(element.nombre)) {
        matchQuery.add(element);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result.nombre),
            onTap: () {},
          );
        });
  }
}

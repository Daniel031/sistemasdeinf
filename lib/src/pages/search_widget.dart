import 'package:flutter/material.dart';
import 'package:sist/src/pages/map_widget.dart';

class CustomSearchDelegate extends SearchDelegate {
  List<dynamic> myList;
  List<dynamic> myList2;
  List<dynamic> myList3;
  int tipo;
  String searchText;
  MapScreenController controller;

  CustomSearchDelegate(this.myList, this.myList2, this.myList3, this.searchText,
      this.controller, this.tipo);

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
            onTap: () {
              List<String> resultados;
              controller.clearPolygons();
              if (tipo == 0) {
                resultados =
                    getNroTiendaList(result, myList, myList3, myList2, tipo);
              } else {
                resultados =
                    getNroTiendaList(result, myList2, myList3, myList, tipo);
              }
              controller.modifyPolygons(resultados);
              close(context, null);
            },
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
            onTap: () {
              List<String> resultados;
              controller.clearPolygons();
              if (tipo == 0) {
                resultados =
                    getNroTiendaList(result, myList, myList3, myList2, tipo);
              } else {
                resultados =
                    getNroTiendaList(result, myList2, myList3, myList, tipo);
              }
              controller.modifyPolygons(resultados);
              close(context, null);
            },
          );
        });
  }

  List<String> getNroTiendaList(var result, List<dynamic> listCatalog,
      List<dynamic> listProducto, List<dynamic> listNegocio, int tipo) {
    List<String> idNegocioList = [];
    if (tipo == 0) {
      //0= catalogo, 1=negocio
      //suponiendo que 0 es para catalogo
      String getIdCatalog = result.idCatalogo;
      for (var productData in listProducto) {
        if (productData.idCatalogo == getIdCatalog) {
          idNegocioList.add(productData.idNegocio);
        }
      }
      //print(idNegocioList);
      return idNegocioList;
    } else {
      //0= catalogo, 1=negocio, se sobreentiende que es 1 para negocio
      String getIdNegocio = result.idNegocio;
      for (var negocioData in listNegocio) {
        if (negocioData.idNegocio == getIdNegocio) {
          idNegocioList.add(negocioData.nro);
        }
      }
      //print(idNegocioList);
      return idNegocioList;
    }
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sist/src/pages/search_widget.dart';
import 'map_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController searchButton = TextEditingController();
  List<Catalogo> catalogoElements = [];
  List<Producto> productoElements = [];
  List<Negocio> negocioElements = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() {
    _loadCatalogo();
    _loadDatosTienda();
    _loadProducto();
  }

  _loadProducto() async {
    // Lee el archivo GeoJSON desde tus activos
    String geoJsonString =
        await DefaultAssetBundle.of(context).loadString('assets/producto.json');

    List<dynamic> listCatalog = json.decode(geoJsonString);

    // Itera sobre cada feature y crea el polígono correspondiente
    listCatalog.forEach((catalog) {
      productoElements.add(Producto.fromJson(catalog));
    });
  }

  _loadDatosTienda() async {
    // Lee el archivo GeoJSON desde tus activos
    String geoJsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/datostienda.json');

    List<dynamic> listCatalog = json.decode(geoJsonString);

    // Itera sobre cada feature y crea el polígono correspondiente
    listCatalog.forEach((catalog) {
      negocioElements.add(Negocio.fromJson(catalog));
    });
  }

  _loadCatalogo() async {
    // Lee el archivo GeoJSON desde tus activos
    String geoJsonString =
        await DefaultAssetBundle.of(context).loadString('assets/catalogo.json');

    List<dynamic> listCatalog = json.decode(geoJsonString);

    // Itera sobre cada feature y crea el polígono correspondiente
    listCatalog.forEach((catalog) {
      catalogoElements.add(Catalogo.fromJson(catalog));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Centro comercial NEVAL'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Card(
                  child: Container(
                      padding: const EdgeInsets.only(
                          left: 3.0, right: 8.0, top: 3.0, bottom: 10.0),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {},
                          ),
                          const Text("Buscar elementos")
                        ],
                      ))),
              Expanded(
                child: Container(
                    alignment: Alignment.center, child: const MapScreen()),
              ),
              Container(
                alignment: Alignment.topRight,
                child: Row(
                  children: [
                    Card(
                      child: IconButton(
                          onPressed: () {
                            showSearch(
                                context: context,
                                delegate: CustomSearchDelegate(
                                    catalogoElements, "Buscar por catalogo"));
                          },
                          icon: const Icon(
                            Icons.shopping_bag,
                            size: 50.0,
                          )),
                    ),
                    Card(
                      child: IconButton(
                          onPressed: () {
                            showSearch(
                                context: context,
                                delegate: CustomSearchDelegate(
                                    negocioElements, "Buscar por tienda"));
                          },
                          icon: const Icon(
                            Icons.add_shopping_cart_sharp,
                            size: 50.0,
                          )),
                    ),
                    Card(
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.accessibility_new_rounded,
                            size: 50.0,
                          )),
                    ),
                    Card(
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.data_exploration_sharp,
                            size: 50.0,
                          )),
                    ),
                    Card(
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.add_location_alt,
                            size: 50.0,
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class Catalogo {
  final String idCatalogo;
  final String nombre;

  Catalogo({
    required this.idCatalogo,
    required this.nombre,
  });

  factory Catalogo.fromJson(Map<String, dynamic> json) {
    return Catalogo(
      idCatalogo: json['IdCatalogo'] ?? '',
      nombre: json['Nombre'] ?? '',
    );
  }
}

class Negocio {
  final String idNegocio;
  final String nombre;
  final String sigla;
  final String imagen;
  final String direccion;
  final String telefono;
  final String mail;
  final String paginaWeb;
  final String longitud;
  final String latitud;
  final String idCenComercial;
  final String nro;

  Negocio({
    required this.idNegocio,
    required this.nombre,
    required this.sigla,
    required this.imagen,
    required this.direccion,
    required this.telefono,
    required this.mail,
    required this.paginaWeb,
    required this.longitud,
    required this.latitud,
    required this.idCenComercial,
    required this.nro,
  });

  factory Negocio.fromJson(Map<String, dynamic> json) {
    return Negocio(
      idNegocio: json['IdNegocio'] ?? '',
      nombre: json['Nombre'] ?? '',
      sigla: json['Sigla'] ?? '',
      imagen: json['Imagen'] ?? '',
      direccion: json['Direccion'] ?? '',
      telefono: json['Telefono'] ?? '',
      mail: json['Mail'] ?? '',
      paginaWeb: json['Pagina Web'] ?? '',
      longitud: json['Longitud'] ?? '',
      latitud: json['Latitud'] ?? '',
      idCenComercial: json['IdCenComercial'] ?? '',
      nro: json['Nro'] ?? '',
    );
  }
}

class Producto {
  final String idProducto;
  final String nombre;
  final String idCatalogo;
  final String color;
  final String precio;
  final String cantidad;
  final String fotos;
  final String disponible;
  final String idNegocio;

  Producto({
    required this.idProducto,
    required this.nombre,
    required this.idCatalogo,
    required this.color,
    required this.precio,
    required this.cantidad,
    required this.fotos,
    required this.disponible,
    required this.idNegocio,
  });

  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      idProducto: json['IdPoducto'] ?? '',
      nombre: json['Producto'] ?? '',
      idCatalogo: json['IdCatalogo'] ?? '',
      color: json['Color'] ?? '',
      precio: json['Precio'] ?? '',
      cantidad: json['Cantidad'] ?? '',
      fotos: json['Fotos'] ?? '',
      disponible: json['Dsponible'] ?? '',
      idNegocio: json['IdNegocio'] ?? '',
    );
  }
}

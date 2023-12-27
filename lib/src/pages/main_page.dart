import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sist/src/classes/catalogo_classes.dart';
import 'package:sist/src/classes/negocio_classes.dart';
import 'package:sist/src/classes/producto_classes.dart';
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
  final MapScreenController mapScreenController = MapScreenController();
  final MapLocationController mapLocationController = MapLocationController();
  final MapLocationNevalController mapLocationNevalController =
      MapLocationNevalController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() {
    _loadCatalogo();
    _loadDatosTienda();
    _loadProducto();
    _loadGeoJson();
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

  _loadGeoJson() async {
    Set<Polygon> polygons = {};
    // Lee el archivo GeoJSON desde tus activos
    String geoJsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/tiendas.geojson');

    // Decodifica el GeoJSON
    Map<String, dynamic> geoJson = json.decode(geoJsonString);

    // Obtén las features del GeoJSON
    List<dynamic> features = geoJson['features'];

    // Itera sobre cada feature y crea el polígono correspondiente
    features.forEach((feature) {
      // Obtén las coordenadas del polígono
      List<LatLng> polygonLatLng = [];
      List<dynamic> polygonCoordinates = feature['geometry']['coordinates'][0];
      for (var coordinate in polygonCoordinates) {
        polygonLatLng.add(LatLng(coordinate[1], coordinate[0]));
      }

      // Crea el polígono
      Polygon polygon = Polygon(
        polygonId: PolygonId(feature['properties']['nro']),
        points: polygonLatLng,
        strokeWidth: 2,
        strokeColor: Colors.blue,
        fillColor: Colors.yellow,
      );
      setState(() {
        polygons.add(polygon);
      });
    });

    mapScreenController.chargePolygons(polygons);
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
                    alignment: Alignment.center,
                    child: MapScreen(
                      controller: mapScreenController,
                      locationController: mapLocationController,
                      locationNevalController: mapLocationNevalController,
                    )),
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
                                    catalogoElements,
                                    negocioElements,
                                    productoElements,
                                    "Buscar por catalogo",
                                    mapScreenController,
                                    0));
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
                                    negocioElements,
                                    catalogoElements,
                                    productoElements,
                                    "Buscar por tienda",
                                    mapScreenController,
                                    1));
                          },
                          icon: const Icon(
                            Icons.add_shopping_cart_sharp,
                            size: 50.0,
                          )),
                    ),
                    Card(
                      child: IconButton(
                          onPressed: () {
                            mapLocationController.getMyLocation();
                          },
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
                          onPressed: () {
                            mapLocationNevalController.getMyLocation();
                          },
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

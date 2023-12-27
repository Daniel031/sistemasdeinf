import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import '../services/json_model.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(-17.7911499296059, -63.2050266495182);
  Set<Polygon> polygons = Set();

  @override
  void initState() {
    super.initState();
    _loadGeoJson();
  }

  _loadGeoJson() async {
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
      List<List<LatLng>> coordinates = [];
      List<dynamic> polygonCoordinates = feature['geometry']['coordinates'][0];
      for (var coordinate in polygonCoordinates) {
        List<LatLng> polygonLatLng = [];

        polygonLatLng.add(LatLng(coordinate[1], coordinate[0]));
        coordinates.add(polygonLatLng);
      }

      // Crea el polígono
      Polygon polygon = Polygon(
        polygonId: PolygonId(feature['properties']['nro']),
        points: coordinates[0],
        strokeWidth: 2,
        strokeColor: Colors.blue,
        fillColor: Colors.transparent,
      );
      setState(() {
        polygons.add(polygon);
      });
    });
  }

  Future<List<JsonModel>> cargarDatosDesdeJson() async {
    final String jsonString = await rootBundle.loadString('assets/datos.json');
    final List<dynamic> jsonList = json.decode(jsonString);

    List<JsonModel> datos =
        jsonList.map((json) => JsonModel.fromJson(json)).toList();
    return datos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: (controller) {
          setState(() {
            mapController = controller;
          });
        },
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 22.0,
        ),
        polygons: polygons,
      ),
    );
  }
}

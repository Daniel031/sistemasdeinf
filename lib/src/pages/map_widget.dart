import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';
import 'package:location/location.dart';

class MapScreenController extends ChangeNotifier {
  Set<Polygon> _polygons = {};

  Set<Polygon> get polygons => _polygons;

  void chargePolygons(Set<Polygon> newPolygons) {
    _polygons = newPolygons;
    notifyListeners();
  }

  void clearPolygons() {
    _polygons = _polygons.map((polygon) {
      return polygon.copyWith(fillColorParam: Colors.yellow);
    }).toSet();
    notifyListeners();
  }

  void modifyPolygons(List<dynamic> items) {
    _polygons = _polygons.map((polygon) {
      if (items.contains(polygon.polygonId.value)) {
        return polygon.copyWith(fillColorParam: Colors.red);
      } else {
        return polygon;
      }
    }).toSet();
    notifyListeners();
  }
}

class MapLocationController extends ChangeNotifier {
  void getMyLocation() {
    notifyListeners();
  }
}

class MapLocationNevalController extends ChangeNotifier {
  void getMyLocation() {
    notifyListeners();
  }
}

class MapScreen extends StatefulWidget {
  final MapScreenController controller;
  final MapLocationController locationController;
  final MapLocationNevalController locationNevalController;

  const MapScreen(
      {Key? key,
      required this.controller,
      required this.locationController,
      required this.locationNevalController})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  Location location = Location();
  late LocationData currentLocation;

  final LatLng _center = const LatLng(-17.7911674, -63.2054262);
  Set<Polygon> polygons = Set();
  Set<Marker> markers = Set();

  @override
  void initState() {
    super.initState();
    // _loadGeoJson();
    widget.controller.addListener(_onControllerChange);
    widget.locationController.addListener(_getLocation);
    widget.locationNevalController.addListener(_getLocationNeval);
  }

  @override
  void dispose() {
    // Eliminar el listener al salir del widget
    widget.controller.removeListener(_onControllerChange);
    widget.locationController.removeListener(_getLocation);
    widget.locationNevalController.removeListener(_getLocationNeval);
    super.dispose();
  }

  // Este método se llamará cuando cambien los polígonos en el controlador
  void _onControllerChange() {
    setState(() {
      // Actualizar los polígonos en el estado local
      // Esto hará que el widget se repinte con los polígonos actualizados
      polygons = widget.controller.polygons;
    });
  }

  void _getLocation() async {
    try {
      var userLocation = await location.getLocation();
      setState(() {
        currentLocation = userLocation;
      });
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(userLocation.latitude!, userLocation.longitude!),
            zoom: 20.5,
          ),
        ),
      );
      _addMarker(LatLng(userLocation.latitude!, userLocation.longitude!),
          "Mi ubicación");
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  void _getLocationNeval() async {
    try {
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: _center,
            zoom: 20.5,
          ),
        ),
      );
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  void _addMarker(LatLng position, String markerId) {
    Marker nuevo = Marker(
        markerId: MarkerId(markerId),
        position: position,
        infoWindow: const InfoWindow(title: "Mi ubicacion"));
    setState(() {
      markers.add(nuevo);
    });
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
  }

  void modifyPoligons(List<dynamic> items) {
    setState(() {
      // Buscar el polígono con el polygonId deseado y realizar la modificación
      polygons = polygons.map((polygon) {
        //if (polygon.polygonId.value == polygonId) {
        if (items.contains(polygon.polygonId.value)) {
          // Modificar el polígono según tus necesidades
          // En este ejemplo, estoy cambiando el color de relleno
          return polygon.copyWith(fillColorParam: Colors.red);
        } else {
          return polygon;
        }
      }).toSet();
    });
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
          zoom: 20.5,
        ),
        polygons: polygons,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        markers: markers,
      ),
    );
  }
}

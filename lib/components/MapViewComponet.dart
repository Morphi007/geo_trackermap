import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';

void launchUrl(Uri url) async {
  if (await canLaunch(url.toString())) {
    await launch(url.toString());
  } else {
    throw 'Could not launch $url';
  }
}

class CurrentLocationIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue,
      ),
      child: Center(
        child: Icon(
          Icons.my_location,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }
}

class MapViewComponent extends StatefulWidget {
  @override
  _MapViewComponentState createState() => _MapViewComponentState();
}

class _MapViewComponentState extends State<MapViewComponent> {
  LatLng? _currentLocation;
  LatLng? _customLocation;
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  final MapController _mapController = MapController();
  double _currentZoom = 9.2;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
    });
  }

  void _setCustomLocation() {
  final latitude = double.tryParse(_latitudeController.text) ?? 0.0;
  final longitude = double.tryParse(_longitudeController.text) ?? 0.0;
  setState(() {
    _customLocation = LatLng(latitude, longitude);
    _mapController.move(_customLocation!, _currentZoom); // Mover el mapa al punto personalizado
  });
}
  

  void _zoomIn() {
    setState(() {
      _currentZoom = _currentZoom + 1;
      _mapController.move(_mapController.center, _currentZoom);
    });
  }

  void _zoomOut() {
    setState(() {
      _currentZoom = _currentZoom - 1;
      _mapController.move(_mapController.center, _currentZoom);
    });
  }

  @override
  Widget build(BuildContext context) {
    LatLng markerLocation = LatLng(19.2206861, -70.548792);

    return Scaffold(
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: _currentLocation ?? markerLocation,
          initialZoom: _currentZoom,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: markerLocation,
                child: const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 40.0,
                ),
              ),
              if (_currentLocation != null)
                Marker(
                  point: _currentLocation!,
                  child: CurrentLocationIcon(),
                ),
              if (_customLocation != null)
                Marker(
                  point: _customLocation!,
                  child: const Icon(
                    Icons.location_on,
                    color: Color.fromARGB(255, 0, 255, 51),
                    size: 40.0,
                  ),
                ),
            ],
          ),
          RichAttributionWidget(
            attributions: [
              TextSourceAttribution(
                'OpenStreetMap contributors',
                onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'zoom_in',
            child: Icon(Icons.add),
            onPressed: _zoomIn,
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'location',
            child: Icon(Icons.edit_location),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Ingrese las coordenadas'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: _latitudeController,
                          decoration: InputDecoration(
                            hintText: 'Latitud',
                          ),
                        ),
                        TextField(
                          controller: _longitudeController,
                          decoration: InputDecoration(
                            hintText: 'Longitud',
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () {
                          _setCustomLocation();
                          Navigator.of(context).pop();
                        },
                        child: Text('Aceptar'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'zoom_out',
            child: Icon(Icons.remove),
            onPressed: _zoomOut,
          ),
        ],
      ),
    );
  }
}
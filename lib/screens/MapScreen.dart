import 'package:flutter/material.dart';
import 'package:geo_trackermap/components/MapViewComponet.dart'; // Importa el componente de mapa

//Github ZMorphy

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:MapViewComponent(), // Mostramos el componente de mapa
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_overlay_demo/Theology/theology_paint.dart';

class TheologyBuilding extends StatelessWidget {
  const TheologyBuilding({
    super.key,
    required this.theologyBuildingScreenOffset,
    required GoogleMapController? mapController,
    required this.theologyScreenCoords,
    required CameraPosition currentPosition,
  })  : _mapController = mapController,
        _currentPosition = currentPosition;

  final Offset? theologyBuildingScreenOffset;
  final GoogleMapController? _mapController;
  final Map<String, Map<String, double>>? theologyScreenCoords;
  final CameraPosition _currentPosition;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: theologyBuildingScreenOffset!.dy, 
      left: theologyBuildingScreenOffset!.dx,
      child: CustomPaint(
        isComplex: true,
        painter: TheologyPaint(
            context: context,
            mapController: _mapController!,
            offsets: theologyScreenCoords!,
            position: _currentPosition),
      ),
    );
  }
}

// Custom painter class to draw buildings or any custom graphics

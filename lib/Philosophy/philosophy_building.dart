
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_overlay_demo/Philosophy/philosofy_paint.dart';

class PhilosophyBuilding extends StatelessWidget {
  const PhilosophyBuilding({
    super.key,
    required this.philosophyBuildingScreenOffset,
    required GoogleMapController? mapController,
    required this.philosofyScreenCoords,
    required CameraPosition currentPosition,
  }) : _mapController = mapController, _currentPosition = currentPosition;

  final Offset? philosophyBuildingScreenOffset;
  final GoogleMapController? _mapController;
  final Map<String, Map<String, double>>? philosofyScreenCoords;
  final CameraPosition _currentPosition;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: philosophyBuildingScreenOffset!.dy, 
      left: philosophyBuildingScreenOffset!.dx,
      child: IgnorePointer(
        child: CustomPaint(
          isComplex: true,
          painter: PhilosophyPaint(
              context: context,
              mapController: _mapController!,
              offsets: philosofyScreenCoords!,
              position: _currentPosition),
        ),
      ),
    );
  }
}

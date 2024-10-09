// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_overlay_demo/Philosophy/philosofy_label.dart';
import 'package:map_overlay_demo/Philosophy/philosophy_building.dart';
import 'package:map_overlay_demo/common_widgets/building_label.dart';
import 'package:map_overlay_demo/coords/philosophy_coords.dart';
import 'package:map_overlay_demo/coords/theology_coords.dart';
import 'package:map_overlay_demo/Philosophy/philosofy_paint.dart';
import 'package:map_overlay_demo/Theology/theology_building.dart';
import 'package:map_overlay_demo/Theology/theology_paint.dart';

class MapWithOverlays extends StatefulWidget {
  const MapWithOverlays({super.key});

  @override
  _MapWithOverlaysState createState() => _MapWithOverlaysState();
}

class _MapWithOverlaysState extends State<MapWithOverlays> {
  GoogleMapController? _mapController;

  //* Philosophy
  // Map Coordinates (bl=bottomLeft)
  LatLng philosophyBuildingBottomLeft = PhilosophyCoords.bl;
  LatLng philosophyBuildingCenter = PhilosophyCoords.center;
  // Screen coordinates
  Offset? philosophyBuildingBottomLeftScreenOffset;
  Offset? philosophyBuildingCenterScreenOffset;

  //* Theology
  // Map Coordinates (bl=bottomLeft)
  LatLng theologyBuildingBottomLeft = TheologyCoords.bl;
  LatLng theologyBuildingCenter = TheologyCoords.center;
  // Screen coordinates
  Offset? theologyBuildingCenterScreenOffset;
  Offset? theologyBuildingBottomLeftScreenOffset;

  Map<String, Map<String, double>>? philosofyScreenCoords;
  Map<String, Map<String, double>>? theologyScreenCoords;

  CameraPosition _currentPosition = const CameraPosition(
    target: PhilosophyCoords.center, // Initial location
    zoom: 16.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Google Map as the base layer
          GoogleMap(
            initialCameraPosition: _currentPosition,
            markers: {
              const Marker(
                  markerId: MarkerId('Αριστοτέλειο Πανεπιστήμιο'),
                  position: LatLng(40.63129348704492, 22.958239672493097))
            },
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
              _updatePhilosophyBuildingPosition();
              _updateTheologyBuildingPosition();
            },
            onCameraMove: (CameraPosition position) {
              log('${position.zoom}');
              _currentPosition = position;
              _updatePhilosophyBuildingPosition();
              _updateTheologyBuildingPosition();
            },
          ),

          // Custom overlay layer that follows the building position
          // Appears only on zoom > 16
          if (philosophyBuildingBottomLeftScreenOffset != null &&
              _currentPosition.zoom > 16)
            PhilosophyBuilding(
                philosophyBuildingScreenOffset:
                    philosophyBuildingBottomLeftScreenOffset,
                mapController: _mapController,
                philosofyScreenCoords: philosofyScreenCoords,
                currentPosition: _currentPosition),
          if (theologyBuildingBottomLeftScreenOffset != null &&
              _currentPosition.zoom > 16)
            TheologyBuilding(
                theologyBuildingScreenOffset:
                    theologyBuildingBottomLeftScreenOffset,
                mapController: _mapController,
                theologyScreenCoords: theologyScreenCoords,
                currentPosition: _currentPosition),
          if (philosophyBuildingCenterScreenOffset != null &&
              _currentPosition.zoom > 16)
            BuildingLabel(
              buildingCenterScreenOffset: philosophyBuildingCenterScreenOffset!,
              text: 'Φιλοσοφική',
            ),
          if (theologyBuildingCenterScreenOffset != null &&
              _currentPosition.zoom > 16)
            BuildingLabel(
              buildingCenterScreenOffset: theologyBuildingCenterScreenOffset!,
              text: 'Θεολογική',
            ),
        ],
      ),
    );
  }

  // Convert building's LatLng(map coordinates) to screen coordinates(Offset)
  Future<void> _updatePhilosophyBuildingPosition() async {
    final pixelRatio = MediaQuery.of(context).devicePixelRatio;

    if (_mapController != null) {
      // Get the screen coordinates for the given LatLng
      // BootomLeft is the point i will start to paint the building (CustomPaint)
      ScreenCoordinate screenCoordinateBottomLeft = await _mapController!
          .getScreenCoordinate(philosophyBuildingBottomLeft);

      ScreenCoordinate screenCoordinateCenter =
          await _mapController!.getScreenCoordinate(philosophyBuildingCenter);

      final offsets = await getBuildingScreenCoords(
        bl: PhilosophyCoords.bl, // bl = bottomLeft
        tl: PhilosophyCoords.tl, // tl = topLeft
        tr: PhilosophyCoords.tr, // tr = topRight
        br: PhilosophyCoords.br, // br = bottomRight
      );

      // Convert ScreenCoordinate to Offset (for use in Positioned widget)
      setState(() {
        philosophyBuildingBottomLeftScreenOffset = Offset(
          screenCoordinateBottomLeft.x.toDouble() / pixelRatio,
          screenCoordinateBottomLeft.y.toDouble() / pixelRatio,
        );

        philosophyBuildingCenterScreenOffset = Offset(
          screenCoordinateCenter.x.toDouble() / pixelRatio,
          screenCoordinateCenter.y.toDouble() / pixelRatio,
        );
        philosofyScreenCoords = offsets;
      });
    }
  }

  Future<void> _updateTheologyBuildingPosition() async {
    final pixelRatio = MediaQuery.of(context).devicePixelRatio;

    if (_mapController != null) {
      // Get the screen coordinates for the given LatLng
      ScreenCoordinate screenCoordinateBottomLeft =
          await _mapController!.getScreenCoordinate(theologyBuildingBottomLeft);
      ScreenCoordinate screenCoordinateCenter =
          await _mapController!.getScreenCoordinate(theologyBuildingCenter);

      final offsets = await getBuildingScreenCoords(
        bl: TheologyCoords.bl,
        tl: TheologyCoords.tl,
        tr: TheologyCoords.tr,
        br: TheologyCoords.br,
      );

      // Convert ScreenCoordinate to Offset (for use in Positioned)
      setState(() {
        theologyBuildingBottomLeftScreenOffset = Offset(
          screenCoordinateBottomLeft.x.toDouble() / pixelRatio,
          screenCoordinateBottomLeft.y.toDouble() / pixelRatio,
        );

        theologyBuildingCenterScreenOffset = Offset(
          screenCoordinateCenter.x.toDouble() / pixelRatio,
          screenCoordinateCenter.y.toDouble() / pixelRatio,
        );
        theologyScreenCoords = offsets;
      });
    }
  }

  //* Custom function to get the coordinates of 4 edges of building
  Future<Map<String, Map<String, double>>> getBuildingScreenCoords(
      {required LatLng bl,
      required LatLng tl,
      required LatLng tr,
      required LatLng br}) async {
    final pixelRatio = MediaQuery.of(context).devicePixelRatio;

    ScreenCoordinate screenLeft = await _mapController!.getScreenCoordinate(bl);
    ScreenCoordinate screenTop = await _mapController!.getScreenCoordinate(tl);
    ScreenCoordinate screenRight =
        await _mapController!.getScreenCoordinate(tr);
    ScreenCoordinate screenBottom =
        await _mapController!.getScreenCoordinate(br);

    final Map<String, Map<String, double>> coords = {
      'left': {
        'x': screenLeft.x.toDouble() / pixelRatio,
        'y': screenLeft.y.toDouble() / pixelRatio
      },
      'top': {
        'x': screenTop.x.toDouble() / pixelRatio,
        'y': screenTop.y.toDouble() / pixelRatio
      },
      'right': {
        'x': screenRight.x.toDouble() / pixelRatio,
        'y': screenRight.y.toDouble() / pixelRatio
      },
      'bottom': {
        'x': screenBottom.x.toDouble() / pixelRatio,
        'y': screenBottom.y.toDouble() / pixelRatio
      },
    };

    return coords;
  }
}

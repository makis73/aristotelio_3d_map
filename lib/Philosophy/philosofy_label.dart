import 'package:flutter/material.dart';

class Philosofy_label extends StatelessWidget {
  const Philosofy_label({
    super.key,
    required this.philosophyBuildingCenterScreenOffset,
  });

  final Offset? philosophyBuildingCenterScreenOffset;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: philosophyBuildingCenterScreenOffset!.dy,
        left: philosophyBuildingCenterScreenOffset!.dx - 40,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(1),
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(2.0, 4.0),
                  blurRadius: 3.0,
                  color: Color.fromARGB(255, 121, 121, 121),
                ),
              ]),
          child: const Text(
            'Φιλοσοφική',
            style: TextStyle(
              fontSize: 10,
              shadows: <Shadow>[
                Shadow(
                  offset: Offset(1.0, 1.0),
                  blurRadius: 3.0,
                  color: Color.fromARGB(255, 0, 51, 255),
                ),
                Shadow(
                  offset: Offset(1.0, 1.0),
                  blurRadius: 5.0,
                  color: Color.fromARGB(124, 250, 250, 249),
                ),
              ],
            ),
          ),
        ));
  }
}


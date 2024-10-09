import 'dart:developer';

import 'package:flutter/material.dart';

class BuildingLabel extends StatelessWidget {
  const BuildingLabel({
    super.key,
    required this.buildingCenterScreenOffset,
    required this.text,
  });

  final Offset buildingCenterScreenOffset;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: buildingCenterScreenOffset.dy,
        left: buildingCenterScreenOffset.dx - 40,
        child: GestureDetector(
          onTap: () {
            showModalBottomSheet(
              backgroundColor: Colors.white,
              context: context,
              builder: (context) {
                return Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(text + ' Σχολή', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
                      Text('Πληροφορίες για τον χρήστη')
                    ],
                  ),
                );
              },
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(1),
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(2.0, 4.0),
                    blurRadius: 4.0,
                    spreadRadius: 2,
                    color: Color.fromARGB(86, 6, 6, 6),
                  ),
                ]),
            // width: 100,
            child: Text(
              text,
              style: const TextStyle(
                color: Color.fromARGB(255, 137, 1, 135),
                fontSize: 14,
                fontWeight: FontWeight.bold,
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(1.0, 1.0),
                    blurRadius: 2.0,
                    color: Color.fromARGB(123, 0, 0, 0),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

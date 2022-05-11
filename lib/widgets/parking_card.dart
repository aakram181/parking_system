import 'package:flutter/material.dart';
import 'package:parking_system/utils/constants.dart';

class ParkingCard extends StatelessWidget {
  String name;
  ParkState parkState;
  bool isSelected = false;
  ParkingCard(
      {required this.name,
      required this.parkState,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        child: parkState == ParkState.empty
            ? Text(
                name,
                style: isSelected ? kSelectedTextStyle : kTitleTextStyle,
              )
            : parkState == ParkState.occupied
                ? Image.asset(
                    'images/car.png',
                  )
                : Text(
                    "R",
                    style: kReservedTextStyle,
                  ),
        decoration:
            // parkState == ParkState.occupied?
            BoxDecoration(
          border: Border.symmetric(
              horizontal: BorderSide(
                  color: Colors.grey.shade700.withOpacity(0.7), width: 3.5)),
        ),
        // : BoxDecoration(
        //     border: Border.symmetric(
        //       horizontal: BorderSide(
        //         color: parkState == ParkState.reserved
        //             ? Colors.yellow
        //             : isSelected
        //                 ? Colors.green.shade600
        //                 : Colors.grey.shade700.withOpacity(0.7),
        //         width: 3.5,
        //       ),
        //     ),
        //   ),
        padding: EdgeInsets.all(10),
      ),
    );
  }
}

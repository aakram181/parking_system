import 'package:flutter/material.dart';


class ReserveButton extends StatelessWidget {

  bool buttonVisibility=true;

  ReserveButton({required this.buttonVisibility});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: buttonVisibility,
      child: GestureDetector(
        onTap: (){
          print('switch to reserve screen !');
        },
        child: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
        borderRadius: BorderRadius.circular(8),),
          child: Center(
            child: Text(
              'Reserve',
              style: TextStyle(fontSize: 25),
            ),
          ),
          margin: EdgeInsets.only(top: 10.0),
          width: 200.0,
          height: 35.0,
        ),
      ),
    );
  }
}
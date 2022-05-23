import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking_system/utils/constants.dart';
import 'package:parking_system/widgets/main_drawer.dart';

import 'map_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> imageList = [
    'images/newcairo.png',
    'images/downtown.jpg',
    'images/maadi.jpg',
    'images/opera_square.jpg',
  ];
  final List<String> descriptionList = [
    "New Cairo",
    "Downtown Cairo",
    "Al Maadi",
    "Opera square",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xFF08051F),
          toolbarHeight: 164,
          title: Text("Choose Your Destination ", style: kSubTitleTextStyle)),
      drawer: MainDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              child: CarouselSlider.builder(
                itemCount: imageList.length,
                options: CarouselOptions(
                  enlargeCenterPage: true,
                  height: 400.h,
                  reverse: false,
                  aspectRatio: 5.0,
                ),
                itemBuilder: (context, i, id) {
                  //for onTap to redirect to another screen
                  return GestureDetector(
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            height: 300.h,
                            width: 300.w,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(imageList[i]),
                                  fit: BoxFit.fill,
                                ),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.white,
                                )),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          descriptionList[i],
                          style: kSubTitleTextStyle,
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MapPage()),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

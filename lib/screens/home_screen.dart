import 'package:flutter/material.dart';
import 'package:parking_system/utils/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'map_page.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _selectedIndex = 0;
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




  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 80),
          Center(
            child: Text(
              'Choose Your Destination',
              style: kTitleTextStyle,
          )),
          SizedBox(
            height: 50,
          ),
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
                                )
                            ),
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

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.white, width: 0.5)),
        ),
        child: BottomNavigationBar(
          backgroundColor: Color(0xFF080515),
          unselectedItemColor: Colors.white,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',

            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: kButtonColor,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

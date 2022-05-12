import 'package:flutter/material.dart';
import 'package:parking_system/screens/generateQR_screen.dart';
import 'package:parking_system/screens/history_screen.dart';
import 'package:parking_system/screens/home_screen.dart';
import 'package:parking_system/utils/constants.dart';
import 'package:parking_system/utils/view_model.dart';
import 'package:parking_system/widgets/drawer_item.dart';

class MainDrawer extends StatelessWidget {
  late String name;
  late String email;

  MainDrawer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: ViewModel.getUser(),
            builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError) {
                    throw Exception("An Error Occurred");
                  }
              }
              name = snapshot.data!['username'];
              email = snapshot.data!['email'];
              return Drawer(
                child: ListView(
                  children: [
                    UserAccountsDrawerHeader(
                      accountName: Text(name),
                      accountEmail: Text(email),
                      currentAccountPicture: CircleAvatar(
                        backgroundColor: Colors.black,
                        child: Text(
                          name.characters.first.toUpperCase(),
                          style: kTitleTextStyle,
                        ),
                      ),
                    ),
                    DrawerItem(
                      title: 'Profile',
                      onPressed: MaterialPageRoute(builder: (context) {
                        return const HomeScreen();
                      }),
                      icon: Icons.account_circle,
                    ),
                    DrawerItem(
                      title: 'History',
                      onPressed: MaterialPageRoute(builder: (context) {
                        return HistoryScreen();
                      }),
                      icon: Icons.history,
                    ),
                    DrawerItem(
                      title: 'Generate QR Code',
                      onPressed: MaterialPageRoute(builder: (context) {
                        return const GenerateQRScreen();
                      }),
                      icon: Icons.qr_code_2,
                    ),
                    DrawerItem(
                      title: 'Payment',
                      onPressed: MaterialPageRoute(builder: (context) {
                        return const HomeScreen();
                      }),
                      icon: Icons.credit_card,
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
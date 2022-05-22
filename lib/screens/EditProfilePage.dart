import 'package:flutter/material.dart';
import 'package:parking_system/screens/signup_payment.dart';
import 'package:parking_system/screens/updateInfo_screen.dart';
import 'package:parking_system/widgets/button_widget.dart';
import 'package:parking_system/widgets/textfield_widget.dart';
import 'package:parking_system/utils/constants.dart';
import 'package:parking_system/utils/view_model.dart';

class EditProfilePage extends StatefulWidget {
  static const String id = 'EditProfilePage';

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}


class _EditProfilePageState extends State<EditProfilePage> {

  late String name;
  late String email;

  @override
  Widget build(BuildContext context) => Builder(
    builder: (context) => Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
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

          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 32),
            physics: BouncingScrollPhysics(),
            children: [
              CircleAvatar(
            backgroundColor: Colors.white,
            radius: 50,
            child: Text(
              name.characters.first.toUpperCase(),
              style: avatarTextStyle,
            ),


            ),
              const SizedBox(height: 15),
              TextFieldWidget(
                label: 'Username',
                text: name,
                onChanged: (name) {},
              ),
              const SizedBox(height: 24),
              TextFieldWidget(
                label: 'Email',
                text: email,
                onChanged: (email) {},
              ),
              const SizedBox(height: 24),
              TextFieldWidget(
                label: 'Password',
                text: '**************', //USER password ,
                onChanged: (email) {},
              ),
              const SizedBox(height: 24),
              Center(child: buildUpdateButton()),
              const SizedBox(height: 24),

              Center(child: buildUpgradeButton()),
              //number expired date cvv card holder
            ],
          );
        }),
      ),
    ),
  );

  Widget buildUpdateButton() => ButtonWidget(
    text: 'Edit your personal info',
    onClicked: () {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => UpdateInfo()),
      );
    },
  );


  Widget buildUpgradeButton() => ButtonWidget(
    text: 'Edit your credit card numbers',
    onClicked: () {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => SignupPayment()),
      );
    },
  );
}

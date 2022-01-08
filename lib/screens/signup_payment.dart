import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking_system/screens/home_screen.dart';
import 'package:parking_system/utils/constants.dart';
import 'package:parking_system/utils/validators.dart';
import '../widgets/textbox.dart';
import '../widgets/main_button.dart';

class SignupPayment extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String _cardNo = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            padding: EdgeInsets.only(left: 20.0.w, right :  20.0.w,),
            child: Form(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Payment Details',
                        style: kTitleTextStyle,
                        textAlign: TextAlign.left,),
                    ),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Add your credit card information',
                        style: kSubTitleTextStyle,),
                    ),
                    SizedBox(
                      height:20.0.h,
                    ),

                    TextBox(
                      labelText : 'Credit Card no.',
                      icon: Icons.credit_card,
                      textInputType: TextInputType.numberWithOptions(),
                      maxLength: 16,
                      validator: Validator.validateCreditCard,
                      onSaved: (value){
                        _cardNo = value.toString();
                      },
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 0.3.sw,
                          child: TextFormField(
                            keyboardType: TextInputType.numberWithOptions(),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10.0),
                                labelText: 'Exp. date',
                                labelStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: kButtonColor,),
                                )
                            ),

                          ),
                        ),
                        SizedBox(
                          width:70.0.w,
                        ),
                        Container(
                          width: 0.3.sw,
                          child: TextFormField(
                            maxLength: 3,
                            keyboardType: TextInputType.numberWithOptions(),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10.0),
                                labelText: 'CVV',
                                labelStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: kButtonColor,),
                                )
                            ),

                          ),
                        )
                      ],

                          ),


                    TextBox(labelText : 'Cardholder Name', icon: Icons.account_circle_outlined, textInputType: TextInputType.numberWithOptions(), maxLength: 16,),

                    SizedBox(
                      height:50.0.h,
                    ),
                    mainButton(
                        text: 'Save',
                        onPressed: (){
                            FocusScope.of(context).unfocus();
                            final bool isValid = _formKey.currentState!.validate();
                            if(isValid){
                              _formKey.currentState!.save();
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return HomeScreen();
                              }));
                      }

                    }),




                  ]
              ),
            )
        ),
      ),
    );
  }
}
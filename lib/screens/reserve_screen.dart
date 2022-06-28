import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parking_system/utils/view_model.dart';
import 'package:parking_system/widgets/main_button.dart';
import 'package:parking_system/widgets/transaction_card.dart';
import 'package:parking_system/utils/constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:intl/intl.dart';

class ReserveScreen extends StatefulWidget {
  const ReserveScreen({Key? key}) : super(key: key);
  static const String id = 'reserve_screen';

  @override
  State<ReserveScreen> createState() => _ReserveScreenState();
}

class _ReserveScreenState extends State<ReserveScreen> {
  double popularity = 1.0;
  var now = 0;
  int available_spots =0;
  int total_spots = 0;
  int arrive_in= 0;
  int arrival_slack = 0;
  bool has_capacity = false;
  String button_text = '';

  late final DatabaseReference pop_pred_db;
  late final DocumentReference garages_db ;
  late final CollectionReference res_db;
  @override
  void initState() {
    super.initState();
    pop_pred_db = FirebaseDatabase.instance.ref("Live_pop");
    garages_db = FirebaseFirestore.instance.collection("garages").doc("cfc");
    res_db = FirebaseFirestore.instance.collection('reservations');


    pop_pred_db.onValue.listen((event) {
      final data = event.snapshot.value;
      updatePopularity(data);
    });


//TODO CHANGE CFC TO BE DYNAMIC
    garages_db.snapshots().listen(
          (event) {
        Map<String, dynamic> data = event.data()! as Map<String, dynamic> ;
        total_spots = data['total_spots'];
        available_spots = data['available_spots'];
        if(available_spots > 0){
          has_capacity = true;
        }
        else{
          has_capacity = false;
        }
        setState(() {

        });

      },
    );


  }


//TODO USE RESERVATION ENTITY/REPO AND VIEWMODEL
  dynamic reserve_function()async {
    final user = await ViewModel.getUser();
    final DateTime t = DateTime.now();
    final DateTime arrival_time = t.add(
        Duration(minutes: arrive_in + arrival_slack));
    final res = {
      'resTime': t,
      'entryTimeMax': arrival_time,
      'garageID': 'cfc',
      'uID': user['uID'],
      'status': 'pending'
    };
    res_db.add(res);
    garages_db.update({'available_spots': FieldValue.increment(-1)});
    ViewModel.updateUserReservation(true);

  }

  void updatePopularity(var pop) {
    double new_pop = double.parse(pop['cfc']); //TODO get name from prev screen
    now = new DateTime.now().hour;
    setState(() {
      print(new_pop);

      popularity = new_pop;
      print(popularity);
      now = now + 1;
    });
  }




  Future<void> _showConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text("Confirm your reservation"),
        content: SingleChildScrollView(
          child: Column(
              children:[
                  Text('You should arrive by'),
                Text(' '),
                Text(DateFormat.Hm().format(DateTime.now().add(Duration(minutes: arrive_in))),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
                  Text(' '),
                  Text.rich( TextSpan(

                    text: 'your reservation will be cancelled if you haven\'t arrived after',
                    children: [
                      TextSpan(text: ' 10 minutes ', style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: 'after the specified time.'),
                    ]
                  ),),
                ],
              ),
              ),
        actions: [
        TextButton(
              child: Text('Confirm'),
              onPressed:(){
                  reserve_function();
                  Navigator.of(context).pop();
              },
                ),
        TextButton(
              child: Text('Cancel'),
              onPressed: (){
              Navigator.of(context).pop();
              },
            ),
        ],
        );},
    );
  }

  Future<void> _showAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Warning"),
          content: SingleChildScrollView(
            child: Column(
              children:[
                Text('You already have a reservation, check your reservations menu'),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Ok'),
              onPressed:(){
                Navigator.of(context).pop();
              },
            ),
          ],
        );},
    );
  }




  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments; // TO MAKE DYNAMIC FOR LATER

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 60.0, 16.0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reserve Parking',
              style: kTitleTextStyle,
            ),
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Cairo Festival City Parking', //TODO DYNAMIC LOCATION
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(
                                Icons.location_on_outlined,
                                color: Colors.black,
                                size: 20.0,
                              ),
                            ]),
                        SizedBox(height: 5.0),
                        Container(
                          padding: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Text('$available_spots slots out of $total_spots are vacant now', //TODO color change dynamic acccording to vacancy
                              style: TextStyle(
                                color: Colors.blueAccent,
                              )),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          '30, Cairo Festival City Mall, New Cairo',
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        )
                      ],
                    ),
                  )),
            ),
            SizedBox(
              height: 50.0,
            ),
            Center(
              child: Text.rich(TextSpan(
                  text: 'The garage will have ', //TODO MAKE TEXT DYNAMIC
                  style: kSubTitleTextStyle.copyWith(height:1.2),
                  children: [
                    TextSpan(
                        text: ((1.0-popularity) * total_spots).toInt().toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        )),
                    TextSpan(text: ' vacant spots at ', style: const TextStyle()),
                    TextSpan(
                        text: now.toString() + ':00',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,

                        )),
                    TextSpan(
                      text: '. Hurry up and reserve!',
                    )
                  ])),
            ),

            SizedBox(height:20.0),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children:[
                  SleekCircularSlider(
                    appearance: CircularSliderAppearance(
                      size: 320.0,
                      customColors: CustomSliderColors(
                        trackColor: Colors.white,
                        progressBarColor: Colors.blue,
                        hideShadow: true,

                      ),
                      customWidths: CustomSliderWidths(
                        progressBarWidth: 15,
                        trackWidth: 6,
                        handlerSize: 5,
                      ),
                      infoProperties: InfoProperties(
                        mainLabelStyle: kSubTitleTextStyle.copyWith(fontWeight: FontWeight.bold,
                        fontSize: 50.0,),
                        topLabelText: 'Arrive in',
                        topLabelStyle: kSubTitleTextStyle.copyWith(fontWeight: FontWeight.bold,),
                        bottomLabelText: 'minutes',
                        bottomLabelStyle: kSubTitleTextStyle.copyWith(fontWeight: FontWeight.bold,),
                        modifier:   (double value) {
                            final roundedValue = value.ceil().toInt().toString();
                              return '$roundedValue ';
                                  },
                      )
                    ),

                    initialValue: 0,
                    max: 60,
                    onChangeEnd: (double value){
                      arrive_in = value.toInt();
                    },
                  )
                ]
              ),
            ),


            Center(child:
            mainButton(
                text: has_capacity? 'Confirm' : 'Full Capacity',
                onPressed: ()async{
                  print(popularity);
                  bool has_reservation = await ViewModel.getUserReservationStatus();
                  if(has_reservation){
                    return _showAlertDialog();
                  }
                  else if(has_capacity){
                    return _showConfirmationDialog();
                  }
                },
                color: has_capacity? kButtonColor : Colors.grey
                )
            ),
          ],
        ),
      ),
    );
  }
}







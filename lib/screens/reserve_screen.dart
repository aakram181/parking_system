import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parking_system/utils/view_model.dart';
import 'package:parking_system/widgets/main_button.dart';
import 'package:parking_system/widgets/transaction_card.dart';
import 'package:parking_system/utils/constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class ReserveScreen extends StatefulWidget {
  const ReserveScreen({Key? key}) : super(key: key);
  static const String id = 'reserve_screen';

  @override
  State<ReserveScreen> createState() => _ReserveScreenState();
}

class _ReserveScreenState extends State<ReserveScreen> {
  int popularity = 1;
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



  dynamic reserve_function()async {
    final uID = await ViewModel.getUser();
    final DateTime t = DateTime.now();
    final DateTime arrival_time = t.add(
        Duration(minutes: arrive_in + arrival_slack));
    final res = {
      'resTime': t,
      'entryTimeMax': arrival_time,
      'garageID': 'cfc',
      'uID': uID['uID'],
      'status': 'pending'
    };
    res_db.add(res);
    garages_db.update({'available_spots': FieldValue.increment(-1)});
    //TODO add to user collection his resverations

  }


  void updatePopularity(var pop) {
    print(pop);
    double new_pop = double.parse(pop['cfc']); //TODO get name from prev screen
    now = new DateTime.now().hour;
    //get next hour

    setState(() {
      popularity = new_pop.toInt();
      now = now + 1;
    });
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
              height: 10.0,
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
                                color: Colors.green,
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
              height: 20.0,
            ),
            Center(
              child: Text.rich(TextSpan(
                  text: 'The garage will have ', //TODO MAKE TEXT DYNAMIC
                  style: kSubTitleTextStyle.copyWith(height:1.2),
                  children: [
                    TextSpan(
                        text: ((1-popularity) * total_spots).toString(),
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
              //TODO CONFIRM SNACKBAR
              //TODO USER CAN ONLY HAVE 1 RESERVATION
                text: has_capacity? 'Confirm' : 'Full Capacity',
                onPressed: has_capacity? reserve_function : (){},
                color: has_capacity? kButtonColor : Colors.grey
                )
            ),
          ],
        ),
      ),
    );
  }
}

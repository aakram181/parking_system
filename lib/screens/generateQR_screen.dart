import 'package:flutter/material.dart';
import 'package:parking_system/utils/constants.dart';
import 'package:parking_system/widgets/main_drawer.dart';
import 'package:parking_system/widgets/qr_image.dart';

class GenerateQRScreen extends StatefulWidget {
  static const String id = 'generateQR_screen';

  @override
  State<GenerateQRScreen> createState() => _GenerateQRScreenState();
}

class _GenerateQRScreenState extends State<GenerateQRScreen> {
  var timeStamp = dateFormat.format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('Scan to Pass'),
          backgroundColor: Colors.grey,
        ),
        drawer: MainDrawer(),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [QImage()]),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: const Text('Scan to pass!'),
                      content: const Text(
                          "We offer a quick and easy way of entry as a second option "
                          "when you are having a car that is not saved in our system.\n"
                          "Just scan this Qr code using the gate's camera and you are good to go."),
                      actions: [
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () => Navigator.pop(context),
                        )
                      ],
                    ));
          },
          icon: const Icon(
            Icons.help,
            color: Colors.blue,
          ),
          label: const Text(
            'Help',
            style: TextStyle(color: Colors.blue),
          ),
          backgroundColor: Colors.grey[50],
        ),
      ),
    );
  }
}
//     return SafeArea(
//         child: Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         title: const Text('Scan to pass'),
//         backgroundColor: Colors.grey,
//       ), //El alwan allah ykhleko
//       drawer: MainDrawer(),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: const [QImage()],
//       ),
//
//       floatingActionButton: FloatingActionButton.extended(
//         icon: const Icon(
//           Icons.help,
//           color: Colors.blue,
//         ),
//         label: const Text(
//           'Help',
//           style: TextStyle(color: Colors.blue),
//         ),
//         backgroundColor: Colors.grey[50],
//         onPressed: () {
//           showDialog(
//             context: context,
//             builder: (context) => AlertDialog(
//               title: const Text('Scan to pass!'),
//               content: const Text(
//                   "We offer a quick and easy way of entry as a second option "
//                   "when you are having a car that is not saved in our system.\n"
//                   "Just scan this Qr code using the gate's camera and you are good to go."),
//               actions: [
//                 TextButton(
//                   child: const Text('OK'),
//                   onPressed: () => Navigator.pop(context),
//                 )
//               ],
//             ),
//           );
//         },
//       ),
//     ));
//   }
// }

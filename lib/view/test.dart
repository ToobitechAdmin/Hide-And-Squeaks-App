// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';

// class ConnectionStatusWidget extends StatefulWidget {
//   const ConnectionStatusWidget({super.key});

//   @override
//   State<ConnectionStatusWidget> createState() => _ConnectionStatusWidgetState();
// }

// class _ConnectionStatusWidgetState extends State<ConnectionStatusWidget> {
//   ConnectivityResult _connectivityResult = ConnectivityResult.none;

//   @override
//   void initState() {
//     super.initState();

//     Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
//       setState(() {
//         _connectivityResult = result;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     String connectionStatus = "";

//     switch (_connectivityResult) {
//       case ConnectivityResult.wifi:
//         connectionStatus = "Wi-Fi connection is being used.";
//         break;
//       case ConnectivityResult.bluetooth:
//         connectionStatus = "Bluetooth connection is being used.";
//         break;
//       case ConnectivityResult.ethernet:
//         connectionStatus = "Ethernet connection is being used.";
//         break;
//       case ConnectivityResult.other:
//         connectionStatus = "Other connection is being used.";
//         break;
//       case ConnectivityResult.vpn:
//         connectionStatus = "Vpn connection is being used.";
//         break;
//       case ConnectivityResult.none:
//         connectionStatus = "No connection.";
//         break;
//       case ConnectivityResult.mobile:
//         // TODO: Handle this case.
//     }

//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           const Center(
//             child: Text(
//               "Connection Status:",
//               style: TextStyle(fontSize: 18),
//             ),
//           ),
//           Center(
//             child: Text(
//               connectionStatus,
//               style: const TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class BleScanner extends StatefulWidget {
  @override
  _BleScannerState createState() => _BleScannerState();
}

class _BleScannerState extends State<BleScanner> {
  late FlutterBluePlus flutterBluePlus;
  List<BluetoothDevice> devices = [];

  @override
  void initState() {
    super.initState();
    startScanning();
  }
  Future<void> _checkPermissionsAndStartScanning() async {
    if (await Permission.bluetooth.request().isGranted &&
        await Permission.bluetoothScan.request().isGranted &&
        await Permission.location.request().isGranted) {
      startScanning();
    } else {
      print('Bluetooth permissions are not granted.');
      // Handle the case where permissions are not granted
    }
  }

  void startScanning() async {
    try {
      await FlutterBluePlus.startScan();
      FlutterBluePlus.scanResults.listen((results) {
        for (ScanResult result in results) {

          setState(() {
            devices.removeWhere((device) => device.remoteId == result.device.remoteId);
            devices.add(result.device);
          });
        }
      });
    } catch (e) {
      print('Error starting scan: $e');
    }
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect();
      await device.discoverServices();
      device.connectionState.listen((state) {
        print('Connection State: $state');
        if (state == BluetoothConnectionState.connected) {
          print('Connected to ${device.platformName ?? 'Unknown Device'}');
          // You can further interact with the connected device here.
        }
      });
    } catch (e) {
      print('Failed to connect to the device: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BLE Scanner'),
      ),
      body: ListView.builder(
        itemCount: devices.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(devices[index].name ?? 'Unknown Device', style: TextStyle(color: Colors.black)),
            subtitle: Text(devices[index].remoteId.toString(), style: TextStyle(color: Colors.black)),
            onTap: () {
              connectToDevice(devices[index]);
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    devices.forEach((device) {
      device.disconnect();
    });
    FlutterBluePlus.stopScan();
    super.dispose();
  }}
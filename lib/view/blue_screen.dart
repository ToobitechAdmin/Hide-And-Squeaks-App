import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BluetoothAudioPlayerScreen extends StatefulWidget {
  @override
  _BluetoothAudioPlayerScreenState createState() =>
      _BluetoothAudioPlayerScreenState();
}

class _BluetoothAudioPlayerScreenState
    extends State<BluetoothAudioPlayerScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  FlutterBlue flutterBlue = FlutterBlue.instance;
  BluetoothDevice? selectedDevice;

  @override
  void initState() {
    super.initState();
    _checkBluetoothPermission();
  }

  Future<void> _checkBluetoothPermission() async {
    var status = await Permission.bluetooth.request();
    if (status.isGranted) {
      // Bluetooth permission granted
      // You can start scanning for devices here if needed
    } else {
      // Handle the case where Bluetooth permission is not granted
    }
  }

  Future<void> _connectToDevice(BluetoothDevice device) async {
    // Connect to the selected Bluetooth device
    await device.connect();
    setState(() {
      selectedDevice = device;
    });

    // Play audio on the connected Bluetooth device
    await _playAudio();
  }

  Future<void> _playAudio() async {
    // Replace the audio URL with your desired audio file or stream
    String audioUrl =
        'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3';

    await _audioPlayer.setUrl(audioUrl);
    await _audioPlayer.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth Audio Player'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Show a dialog with available Bluetooth devices
            await _showBluetoothDevicesDialog();
          },
          child: Text('Connect to Bluetooth Device'),
        ),
      ),
    );
  }

  Future<void> _showBluetoothDevicesDialog() async {
    List<BluetoothDevice> devices = [];

    // Start scanning for Bluetooth devices
    flutterBlue.startScan(timeout: Duration(seconds: 4));

    // Listen for discovered devices
    var subscription = flutterBlue.scanResults.listen((results) {
      for (ScanResult result in results) {
        if (!devices.contains(result.device)) {
          devices.add(result.device);
        }
      }
    });

    // Show the devices in a dialog
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Bluetooth Device'),
          content: SingleChildScrollView(
            child: Column(
              children: devices.map((device) {
                return ListTile(
                  title: Text(device.name ?? 'Unknown Device'),
                  onTap: () async {
                    // Stop scanning when a device is selected
                    flutterBlue.stopScan();

                    // Connect to the selected Bluetooth device
                    await _connectToDevice(device);

                    Navigator.of(context).pop(); // Close the dialog
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );

    // Cancel the scan subscription
    subscription.cancel();
  }
}

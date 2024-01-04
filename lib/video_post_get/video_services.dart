import 'dart:io';
import 'package:chunked_uploader/chunked_uploader.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<PlatformFile>? _paths;
  String? _extension;
  double progress = 0.0;
  String link = '';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  void _pickFiles() async {
    setState(() {
      link = '';
      isLoading = true;
    });
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
      );

      if (result != null) {
        _paths = [result.files.first];
      }
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Unsupported operation$e');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {
      isLoading = false;
      setState(() {});
    }
  }

  upload() async {
    if (_paths == null || _paths!.isEmpty) {
      print('Select a file first.');
      return;
    }

    var path = _paths![0].path!;
    String fileName = path.split('/').last;
    String url = 'https://digimaestros.com/dev/Hide-Squeaks/api/videos-upload';

    ChunkedUploader chunkedUploader = ChunkedUploader(
      Dio(
        BaseOptions(
          baseUrl: url,
          headers: {
            'Content-Type': 'multipart/form-data',
            'Connection': 'Keep-Alive',
          },
        ),
      ),
    );
    try {
      Response? response = await chunkedUploader.upload(
       fileName: fileName,

        fileKey: "file",
        method: "POST",
        // Pass the fileDataStream parameter
        fileDataStream: Stream.fromIterable([File(path).readAsBytesSync()]),
        fileSize: File(path).lengthSync(),
        maxChunkSize: 500000000,
        path: url,
        data: {
          'additional_data': 'hiii',
        },
        onUploadProgress: (v) {
          if (kDebugMode) {
            print(v);
          }

          progress = v;
          setState(() {});
        },
      );

      if (kDebugMode) {
        print(response);
      }

      var data = response?.data;
      if (data != null) {
        if (data['status'] == true) {
          link = data['link'];
        }
        print(data['message']);
      } else {
        print('Unknown error.');
      }

      setState(() {
        _paths = null;
        progress = 0.0;
      });
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video Upload"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _pickFiles();
              },
              child: const Text('Select File'),
            ),
            const SizedBox(height: 20),
            if ((_paths?.length ?? 0) > 0)
              ElevatedButton(
                onPressed: () {
                  upload();
                },
                child: const Text('Upload'),
              ),
            if (progress > 0)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: LinearPercentIndicator(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  animation: false,
                  lineHeight: 20.0,
                  percent: double.parse(progress.toStringAsExponential(1)),
                  progressColor: Colors.green,
                  center: Text(
                    "${(progress * 100).round()}%",
                    style: const TextStyle(fontSize: 12.0),
                  ),
                ),
              ),
            const SizedBox(height: 20),
            if (link != '')
              Text(
                link,
                style: const TextStyle(),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
      floatingActionButton: link != ''
          ? FloatingActionButton(
        onPressed: () {
          _launchUrl(link);
        },
        child: const Icon(Icons.remove_red_eye_rounded),
      )
          : null,
    );
  }



  _launchUrl(url) async {
    if (!await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication))
      throw 'Could not launch $url';
  }
}

import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoThumbnailScreen extends StatefulWidget {
  @override
  _VideoThumbnailScreenState createState() => _VideoThumbnailScreenState();
}

class _VideoThumbnailScreenState extends State<VideoThumbnailScreen> {
  File? _videoFile;
  File? thumbnailFile;

  Future<void> _pickVideo() async {
    final pickedFile =
        await ImagePicker().pickVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _videoFile = File(pickedFile.path);
        _generateThumbnail();
      });
    }
  }

  Future<void> _generateThumbnail() async {
    if (_videoFile != null) {
      final thumbnailPath = await VideoThumbnail.thumbnailFile(
        video: _videoFile!.path,
        thumbnailPath: (await getTemporaryDirectory()).path,
        imageFormat: ImageFormat.PNG,
        maxHeight: 100,
        quality: 100,
      );

      setState(() {
        thumbnailFile = File(thumbnailPath!);
      });
    }
  }

  // Future<void> _generateThumbnail() async {
  //   final thumbnailPath = await VideoThumbnail.thumbnailFile(
  //     video: _videoFile!.path,
  //     thumbnailPath: (await getTemporaryDirectory()).path,
  //     imageFormat: ImageFormat.PNG,
  //     maxHeight: 100,
  //     quality: 100,
  //   );

  //   setState(() {
  //     _thumbnailFile = File(thumbnailPath!);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Thumbnail Example'),
      ),
      body: Column(
        children: [
          _videoFile != null
              ? AspectRatio(
                  aspectRatio: 16 /
                      9, // You can adjust this based on your video aspect ratio
                  child: Image.file(thumbnailFile!),
                )
              : Container(),
          ElevatedButton(
            onPressed: _pickVideo,
            child: Text('Pick Video'),
          ),
        ],
      ),
    );
  }
}
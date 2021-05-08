import 'package:digitalocean_spaces/pages/home/home_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uploader/flutter_uploader.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as path;

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = HomeController(
    Dio(
      BaseOptions(baseUrl: 'http://192.168.1.100:5000'),
    ),
    FlutterUploader(),
  );

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _uplodFile() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final mimeType = lookupMimeType(pickedFile.path)!;
      final uploadUrl = await _controller.getPreSignedUploadUrl(
        key: "development/${DateTime.now().microsecondsSinceEpoch}${path.extension(pickedFile.path)}",
        contentType: mimeType,
      );
      if (uploadUrl != null) {
        _controller.uploadImage(uploadUrl, pickedFile.path);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: _uplodFile,
        child: Icon(Icons.cloud_upload_rounded),
      ),
    );
  }
}

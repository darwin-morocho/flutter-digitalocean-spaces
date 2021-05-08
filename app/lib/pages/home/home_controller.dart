import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart' show ChangeNotifier;
import 'package:flutter_uploader/flutter_uploader.dart';

class HomeController extends ChangeNotifier {
  final FlutterUploader _uploader;
  final Dio _dio;
  StreamSubscription? _resultSubscription, _progressSubscription;

  HomeController(this._dio, this._uploader) {
    _init();
  }

  _init() async {
    await _uploader.clearUploads();
    _progressSubscription = _uploader.progress.listen((progress) {
      print("🐶 progress: ${progress.progress}");
    });
    _resultSubscription = _uploader.result.listen((response) {
      print("🐶 response: ${response.statusCode}");
      print("🐶 response: ${response.response}");
    });
  }

  Future<String?> getPreSignedUploadUrl({
    required String key,
    required String contentType,
  }) async {
    try {
      final data = {
        "Key": key,
        "ContentType": contentType,
        "ACL": "public-read",
      };
      print(data);
      final response = await _dio.post(
        '/api/get-pre-signed-upload-url',
        data: data,
      );
      final uploadUrl = response.data as String;
      print("uploadUrl $uploadUrl");
      return uploadUrl;
    } catch (e) {
      print(e);
      return null;
    }
  }

  uploadImage(String uploadUrl, String path) {
    print("-----> path $path");
    _uploader.enqueue(
      RawUpload(
        url: uploadUrl,
        method: UploadMethod.PUT,
        path: path,
        headers: {
          'x-amz-acl': 'public-read',
        },
      ),
    );
  }

  @override
  void dispose() {
    _uploader.cancelAll();
    _resultSubscription?.cancel();
    _progressSubscription?.cancel();
    super.dispose();
  }
}

import 'dart:async';
import 'dart:typed_data';

import 'package:fitnect/core/data/entities/upload_result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final storageApiProvider = Provider<StorageApi>((ref) => StorageApi());

class StorageApi {
  StorageApi();

  /// upload a file to firebase storage
  /// and return a stream of the upload progress
  Stream<UploadResult> uploadData(
    Uint8List data,
    String folder,
    String filename, {
    String? mimeType, // ex 'image/jpg'
    bool isPublic = true,
  }) async* {
    throw UnimplementedError();
  }

  Future<void> deleteFile(String? imagePath) async {
    throw UnimplementedError();
  }
}

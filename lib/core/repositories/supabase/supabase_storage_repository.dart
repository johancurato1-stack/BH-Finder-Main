import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:bh_finder/core/repositories/repositories/storage_repository.dart';

//============================================================================
//! SUPABASE STORAGE REPOSITORY
//============================================================================

class SupabaseStorageRepository implements StorageRepository {
  //============================================================================
  //! FIELDS
  //============================================================================

  final SupabaseClient _supabase = Supabase.instance.client;

  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  SupabaseStorageRepository();

  //============================================================================
  //! PROPERTY IMAGES
  //============================================================================

  @override
  Future<List<String>> uploadPropertyImages({
    required String propertyId,
    required List<String> localPaths,
  }) async {
    return _uploadFiles(
      bucket: 'properties',
      folder: propertyId,
      localPaths: localPaths,
    );
  }

  //============================================================================
  //! ROOM IMAGES
  //============================================================================

  @override
  Future<List<String>> uploadRoomImages({
    required String roomId,
    required List<String> localPaths,
  }) async {
    return _uploadFiles(
      bucket: 'rooms',
      folder: roomId,
      localPaths: localPaths,
    );
  }

  //============================================================================
  //! AVATAR
  //============================================================================

  @override
  Future<String> uploadAvatar({
    required String userId,
    required String localPath,
  }) async {
    const bucket = 'avatars';
    final objectPath = '$userId/profile.jpg';

    //----------------------------------------------------------
    // Remove Existing Avatar
    //----------------------------------------------------------

    await _supabase.storage.from(bucket).remove([objectPath]);

    //----------------------------------------------------------
    // Upload Avatar
    //----------------------------------------------------------

    await _supabase.storage
        .from(bucket)
        .upload(
          objectPath,
          File(localPath),
          fileOptions: const FileOptions(upsert: true),
        );

    return '$bucket/$objectPath';
  }

  //============================================================================
  //! DELETE FILES
  //============================================================================

  @override
  Future<void> deleteFiles(List<String> storagePaths) async {
    if (storagePaths.isEmpty) return;

    final filesByBucket = <String, List<String>>{};

    for (final storagePath in storagePaths) {
      final parts = storagePath.split('/');

      final bucket = parts.first;
      final filePath = parts.sublist(1).join('/');

      filesByBucket.putIfAbsent(bucket, () => []);
      filesByBucket[bucket]!.add(filePath);
    }

    for (final entry in filesByBucket.entries) {
      await _supabase.storage.from(entry.key).remove(entry.value);
    }
  }

  //============================================================================
  //! PUBLIC URL
  //============================================================================

  @override
  String getPublicUrl(String bucket, String storagePath) =>
      _supabase.storage.from(bucket).getPublicUrl(storagePath);

  //============================================================================
  //! UPLOAD FILES
  //============================================================================

  Future<List<String>> _uploadFiles({
    required String bucket,
    required String folder,
    required List<String> localPaths,
  }) async {
    final uploadedPaths = <String>[];

    for (final localPath in localPaths) {
      //----------------------------------------------------------
      // Build Object Path
      //----------------------------------------------------------

      final extension = path.extension(localPath);
      final fileName = '${DateTime.now().microsecondsSinceEpoch}$extension';
      final objectPath = '$folder/$fileName';

      //----------------------------------------------------------
      // Upload File
      //----------------------------------------------------------

      await _supabase.storage.from(bucket).upload(objectPath, File(localPath));

      uploadedPaths.add('$bucket/$objectPath');
    }

    return uploadedPaths;
  }
}

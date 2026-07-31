import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:bh_finder/core/property_and_room_adding_updating/repositories/storage_repository.dart';

//============================================================================
//! SUPABASE STORAGE REPOSITORY
//============================================================================

class SupabaseStorageRepository implements StorageRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

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

    final grouped = <String, List<String>>{};

    for (final storagePath in storagePaths) {
      final parts = storagePath.split('/');

      final bucket = parts.first;
      final filePath = parts.sublist(1).join('/');

      grouped.putIfAbsent(bucket, () => []);
      grouped[bucket]!.add(filePath);
    }

    for (final entry in grouped.entries) {
      await _supabase.storage.from(entry.key).remove(entry.value);
    }
  }

  //============================================================================
  //! PUBLIC URL
  //============================================================================

  @override
  String getPublicUrl(String bucket, String storagePath) {
    return _supabase.storage.from(bucket).getPublicUrl(storagePath);
  }

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
      final extension = path.extension(localPath);

      final fileName = '${DateTime.now().microsecondsSinceEpoch}$extension';

      final objectPath = '$folder/$fileName';

      await _supabase.storage.from(bucket).upload(objectPath, File(localPath));

      uploadedPaths.add('$bucket/$objectPath');
    }

    return uploadedPaths;
  }
}

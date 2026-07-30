import 'package:bh_finder/core/favorites/respositories/favorite_repository.dart';
import 'package:bh_finder/core/favorites/supabase/supabase_favorite_repository.dart';

import 'package:bh_finder/core/property_and_room_adding_updating/repositories/property_repository.dart';
import 'package:bh_finder/core/property_and_room_adding_updating/repositories/room_repository.dart';
import 'package:bh_finder/core/property_and_room_adding_updating/repositories/storage_repository.dart';

import 'package:bh_finder/core/property_and_room_adding_updating/supabase/supabase_property_repository.dart';
import 'package:bh_finder/core/property_and_room_adding_updating/supabase/supabase_room_repository.dart';
import 'package:bh_finder/core/property_and_room_adding_updating/supabase/supabase_storage_repository.dart';

//============================================================================
//! REPOSITORIES
//============================================================================

class Repositories {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  Repositories._();

  static final Repositories instance = Repositories._();

  //============================================================================
  //! STORAGE REPOSITORY
  //============================================================================

  late final StorageRepository storageRepository = SupabaseStorageRepository();

  //============================================================================
  //! ROOM REPOSITORY
  //============================================================================

  late final RoomRepository roomRepository = SupabaseRoomRepository(
    storageRepository: storageRepository,
  );

  //============================================================================
  //! FAVORITE REPOSITORY
  //============================================================================

  late final FavoriteRepository favoriteRepository =
      SupabaseFavoriteRepository();

  //============================================================================
  //! PROPERTY REPOSITORY
  //============================================================================

  late final PropertyRepository propertyRepository = SupabasePropertyRepository(
    roomRepository: roomRepository,
    storageRepository: storageRepository,
  );
}

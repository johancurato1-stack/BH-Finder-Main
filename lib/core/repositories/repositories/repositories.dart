import 'package:bh_finder/core/repositories/repositories/chat_repository.dart';
import 'package:bh_finder/core/repositories/repositories/favorite_repository.dart';
import 'package:bh_finder/core/repositories/repositories/inquiry_repository.dart';
import 'package:bh_finder/core/repositories/repositories/property_repository.dart';
import 'package:bh_finder/core/repositories/repositories/room_repository.dart';
import 'package:bh_finder/core/repositories/repositories/storage_repository.dart';

import 'package:bh_finder/core/repositories/supabase/supabase_chat_repository.dart';
import 'package:bh_finder/core/repositories/supabase/supabase_favorite_repository.dart';
import 'package:bh_finder/core/repositories/supabase/supabase_inquiry_repository.dart';
import 'package:bh_finder/core/repositories/supabase/supabase_property_repository.dart';
import 'package:bh_finder/core/repositories/supabase/supabase_room_repository.dart';
import 'package:bh_finder/core/repositories/supabase/supabase_storage_repository.dart';

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

  //============================================================================
  //! CHAT REPOSITORY
  //============================================================================

  late final ChatRepository chatRepository = SupabaseChatRepository(
    storageRepository: storageRepository,
  );

  //============================================================================
  //! INQUIRY REPOSITORY
  //============================================================================

  late final InquiryRepository inquiryRepository = SupabaseInquiryRepository();
}

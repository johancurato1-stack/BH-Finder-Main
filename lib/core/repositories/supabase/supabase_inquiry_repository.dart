import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:bh_finder/core/enums/enums.dart';

import 'package:bh_finder/core/models/inquiry_model.dart';

import 'package:bh_finder/core/repositories/repositories/inquiry_repository.dart';

//============================================================================
//! SUPABASE INQUIRY REPOSITORY
//============================================================================

class SupabaseInquiryRepository implements InquiryRepository {
  //============================================================================
  //! FIELDS
  //============================================================================

  final SupabaseClient _supabase = Supabase.instance.client;

  //============================================================================
  //! GET BY ID
  //============================================================================

  @override
  Future<InquiryModel?> getById(String inquiryId) async {
    final response = await _supabase
        .from('inquiries')
        .select()
        .eq('id', inquiryId)
        .maybeSingle();

    if (response == null) {
      return null;
    }

    return _mapInquiry(response);
  }

  //============================================================================
  //! GET BY CHAT ID
  //============================================================================

  @override
  Future<List<InquiryModel>> getByChatId(String chatId) async {
    final response = await _supabase
        .from('inquiries')
        .select()
        .eq('chat_id', chatId)
        .order('created_at', ascending: false);

    return response.map<InquiryModel>(_mapInquiry).toList();
  }

  //============================================================================
  //! CREATE
  //============================================================================

  @override
  Future<InquiryModel> create(InquiryModel inquiry) async {
    final response = await _supabase
        .from('inquiries')
        .insert({
          //====================================================================
          //! CHAT REFERENCE
          //====================================================================
          'chat_id': inquiry.chatId,

          //====================================================================
          //! ROOM REFERENCE
          //====================================================================
          'room_id': inquiry.roomId,

          //====================================================================
          //! PROPERTY SNAPSHOT
          //====================================================================
          'property_name': inquiry.propertyName,

          //====================================================================
          //! ROOM SNAPSHOT
          //====================================================================
          'room_image_url': inquiry.roomImageUrl,
          'room_title': inquiry.roomTitle,
          'room_price': inquiry.roomPrice,
          'room_capacity': inquiry.roomCapacity,
          'room_gender_preference': inquiry.roomGenderPreference,

          //====================================================================
          //! INQUIRY
          //====================================================================
          'message': inquiry.message,

          //====================================================================
          //! STATUS
          //====================================================================
          'status': inquiry.status.name,
        })
        .select()
        .single();

    return _mapInquiry(response);
  }

  //============================================================================
  //! ACCEPT INQUIRY
  //============================================================================

  @override
  Future<void> acceptInquiry(String inquiryId) async {
    await _supabase
        .from('inquiries')
        .update({'status': InquiryStatus.accepted.name})
        .eq('id', inquiryId);
  }

  //============================================================================
  //! DECLINE INQUIRY
  //============================================================================

  @override
  Future<void> declineInquiry(String inquiryId) async {
    await _supabase
        .from('inquiries')
        .update({'status': InquiryStatus.declined.name})
        .eq('id', inquiryId);
  }

  //============================================================================
  //! EXPIRE INQUIRY
  //============================================================================

  @override
  Future<void> expireInquiry(String inquiryId) async {
    await _supabase
        .from('inquiries')
        .update({'status': InquiryStatus.expired.name})
        .eq('id', inquiryId);
  }

  //============================================================================
  //! MAP INQUIRY
  //============================================================================

  InquiryModel _mapInquiry(Map<String, dynamic> row) {
    return InquiryModel(
      id: row['id'] as String,

      //======================================================================
      //! CHAT REFERENCE
      //======================================================================
      chatId: row['chat_id'] as String?,

      //======================================================================
      //! ROOM REFERENCE
      //======================================================================
      roomId: row['room_id'] as String?,

      //======================================================================
      //! PROPERTY SNAPSHOT
      //======================================================================
      propertyName: row['property_name'] as String? ?? '',

      //======================================================================
      //! ROOM SNAPSHOT
      //======================================================================
      roomImageUrl: row['room_image_url'] as String? ?? '',

      roomTitle: row['room_title'] as String? ?? '',

      roomPrice: (row['room_price'] as num?)?.toDouble() ?? 0,

      roomCapacity: (row['room_capacity'] as num?)?.toInt() ?? 0,

      roomGenderPreference: row['room_gender_preference'] as String? ?? '',

      //======================================================================
      //! INQUIRY
      //======================================================================
      message: row['message'] as String? ?? '',

      //======================================================================
      //! STATUS
      //======================================================================
      status: InquiryStatus.values.firstWhere(
        (status) => status.name == row['status'],
        orElse: () => InquiryStatus.pending,
      ),

      createdAt: DateTime.parse(row['created_at'] as String),
    );
  }
}

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
  //! CURRENT USER
  //============================================================================

  String get _currentUserId {
    final userId = _supabase.auth.currentUser?.id;

    if (userId == null) {
      throw Exception('User is not authenticated.');
    }

    return userId;
  }

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
  //! GET TENANT INQUIRIES
  //============================================================================

  @override
  Future<List<InquiryModel>> getTenantInquiries() async {
    final userId = _currentUserId;

    final response = await _supabase
        .from('inquiries')
        .select()
        .eq('tenant_id', userId)
        .order('created_at', ascending: false);

    return Future.wait(response.map<Future<InquiryModel>>(_mapInquiry));
  }

  //============================================================================
  //! GET LANDLORD INQUIRIES
  //============================================================================

  @override
  Future<List<InquiryModel>> getLandlordInquiries() async {
    final userId = _currentUserId;

    final response = await _supabase
        .from('inquiries')
        .select()
        .eq('landlord_id', userId)
        .order('created_at', ascending: false);

    return Future.wait(response.map<Future<InquiryModel>>(_mapInquiry));
  }

  //============================================================================
  //! GET BY CHAT ID
  //============================================================================

  @override
  Future<InquiryModel?> getByChatId(String chatId) async {
    final response = await _supabase
        .from('inquiries')
        .select()
        .eq('chat_id', chatId)
        .order('created_at', ascending: false)
        .limit(1)
        .maybeSingle();

    if (response == null) {
      return null;
    }

    return _mapInquiry(response);
  }

  //============================================================================
  //! CREATE
  //============================================================================

  @override
  Future<InquiryModel> create(InquiryModel inquiry) async {
    final userId = _currentUserId;

    if (inquiry.tenantId != userId) {
      throw Exception('Inquiry does not belong to the current user.');
    }

    final response = await _supabase
        .from('inquiries')
        .insert({
          'chat_id': inquiry.chatId,
          'tenant_id': inquiry.tenantId,
          'landlord_id': inquiry.landlordId,
          'room_id': inquiry.roomId,
          'room_title': inquiry.roomTitle,
          'room_price': inquiry.roomPrice,
          'room_capacity': inquiry.roomCapacity,
          'gender_preference': inquiry.genderPreference.name,
          'message': inquiry.message,
          'status': inquiry.status.name,
        })
        .select()
        .single();

    return _mapInquiry(response);
  }

  //============================================================================
  //! UPDATE STATUS
  //============================================================================

  @override
  Future<void> updateStatus({
    required String inquiryId,
    required String status,
  }) async {
    await _supabase
        .from('inquiries')
        .update({
          'status': status,
          'updated_at': DateTime.now().toUtc().toIso8601String(),
        })
        .eq('id', inquiryId);
  }

  //============================================================================
  //! MAP INQUIRY
  //============================================================================

  Future<InquiryModel> _mapInquiry(Map<String, dynamic> row) async {
    final roomId = row['room_id'] as String;

    final room = await _supabase
        .from('rooms')
        .select('property_id')
        .eq('id', roomId)
        .maybeSingle();

    if (room == null) {
      throw Exception('Room not found for inquiry.');
    }

    return InquiryModel(
      id: row['id'] as String,

      chatId: row['chat_id'] as String,

      tenantId: row['tenant_id'] as String,

      landlordId: row['landlord_id'] as String,

      propertyId: room['property_id'] as String,

      roomId: roomId,

      roomTitle: row['room_title'] as String,

      roomPrice: (row['room_price'] as num).toDouble(),

      roomCapacity: row['room_capacity'] as int,

      genderPreference: GenderPreference.values.firstWhere(
        (e) => e.name == row['gender_preference'],
      ),

      message: row['message'] as String? ?? '',

      status: InquiryStatus.values.firstWhere((e) => e.name == row['status']),

      createdAt: DateTime.parse(row['created_at'] as String),

      updatedAt: DateTime.parse(row['updated_at'] as String),
    );
  }
}

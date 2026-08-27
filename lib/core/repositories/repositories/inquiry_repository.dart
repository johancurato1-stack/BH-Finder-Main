import 'package:bh_finder/core/models/inquiry_model.dart';

//============================================================================
//! INQUIRY REPOSITORY
//============================================================================

abstract class InquiryRepository {
  //============================================================================
  //! GETTERS
  //============================================================================

  Future<InquiryModel?> getById(String inquiryId);

  Future<List<InquiryModel>> getTenantInquiries();

  Future<List<InquiryModel>> getLandlordInquiries();

  Future<InquiryModel?> getByChatId(String chatId);

  //============================================================================
  //! COMMANDS
  //============================================================================

  Future<InquiryModel> create(InquiryModel inquiry);

  Future<void> updateStatus({
    required String inquiryId,
    required String status,
  });
}

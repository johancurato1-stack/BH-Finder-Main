import 'package:bh_finder/core/models/inquiry_model.dart';

//============================================================================
//! INQUIRY REPOSITORY
//============================================================================

abstract class InquiryRepository {
  //============================================================================
  //! GETTERS
  //============================================================================

  Future<InquiryModel?> getById(String inquiryId);

  Future<List<InquiryModel>> getByChatId(String chatId);

  //============================================================================
  //! COMMANDS
  //============================================================================

  Future<InquiryModel> create(InquiryModel inquiry);

  //============================================================================
  //! INQUIRY ACTIONS
  //============================================================================

  Future<void> acceptInquiry(String inquiryId);

  Future<void> declineInquiry(String inquiryId);

  Future<void> expireInquiry(String inquiryId);
}

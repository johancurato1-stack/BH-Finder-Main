import 'package:flutter/material.dart';

import 'package:bh_finder/core/enums/enums.dart';

//============================================================================
//! MESSAGE STATUS EXTENSION
//============================================================================

extension MessageStatusExtension on MessageStatus {
  //============================================================================
  //! ICON
  //============================================================================

  IconData get icon {
    switch (this) {
      case MessageStatus.sending:
        return Icons.access_time;

      case MessageStatus.sent:
        return Icons.check;

      case MessageStatus.delivered:
        return Icons.done_all;

      case MessageStatus.seen:
        return Icons.done_all;
    }
  }

  //============================================================================
  //! COLOR
  //============================================================================

  Color get color {
    switch (this) {
      case MessageStatus.seen:
        return Colors.blue;

      default:
        return Colors.grey;
    }
  }
}

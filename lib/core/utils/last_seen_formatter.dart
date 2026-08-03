//============================================================================
//! LAST SEEN FORMATTER
//============================================================================

class LastSeenFormatter {
  const LastSeenFormatter._();

  //============================================================================
  //! ONLINE
  //============================================================================

  static bool isOnline(DateTime? lastSeenAt) {
    if (lastSeenAt == null) {
      return false;
    }

    return DateTime.now().difference(lastSeenAt).inMinutes < 2;
  }

  //============================================================================
  //! FORMAT
  //============================================================================

  static String format(DateTime? lastSeenAt) {
    if (lastSeenAt == null) {
      return 'Active recently';
    }

    final difference = DateTime.now().difference(lastSeenAt);

    if (difference.inMinutes < 2) {
      return 'Active now';
    }

    if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;

      return 'Active $minutes minute${minutes == 1 ? '' : 's'} ago';
    }

    if (difference.inHours < 24) {
      final hours = difference.inHours;

      return 'Active $hours hour${hours == 1 ? '' : 's'} ago';
    }

    if (difference.inDays == 1) {
      return 'Active yesterday';
    }

    return 'Active ${difference.inDays} days ago';
  }
}

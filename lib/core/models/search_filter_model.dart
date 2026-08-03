import 'package:bh_finder/core/options/search_filter_options.dart';

//============================================================================
//! SEARCH FILTER MODEL
//============================================================================

class SearchFilterModel {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  SearchFilterModel({
    this.query = '',
    this.budget = 'Any',
    this.gender = 'Any',
    this.status = 'Any',
    List<String>? amenities,
  }) : amenities = amenities ?? [];

  //============================================================================
  //! VARIABLES
  //============================================================================

  String query;

  String budget;

  String gender;

  String status;

  List<String> amenities;

  //============================================================================
  //! RESET
  //============================================================================

  void reset() {
    query = '';
    budget = 'Any';
    gender = 'Any';
    status = 'Any';
    amenities.clear();
  }

  //============================================================================
  //! COPY
  //============================================================================

  SearchFilterModel copyWith({
    String? query,
    String? budget,
    String? gender,
    String? status,
    List<String>? amenities,
  }) {
    return SearchFilterModel(
      query: query ?? this.query,
      budget: budget ?? this.budget,
      gender: gender ?? this.gender,
      status: status ?? this.status,
      amenities: amenities ?? List.from(this.amenities),
    );
  }

  //============================================================================
  //! FILTER SUMMARY
  //============================================================================

  String buildSummary() {
    final parts = <String>[];

    if (query.trim().isNotEmpty) {
      parts.add(query.trim());
    }

    if (budget != 'Any') {
      parts.add(budget);
    }

    if (amenities.isNotEmpty) {
      for (final value in amenities) {
        final amenity = SearchFilterOptions.amenities.firstWhere(
          (item) => item['value'] == value,
        );

        parts.add(amenity['label'] as String);
      }
    }

    if (gender != 'Any') {
      parts.add(gender);
    }

    if (status != 'Any') {
      parts.add(status);
    }

    return parts.join(' • ');
  }

  //============================================================================
  //! HAS ACTIVE FILTERS
  //============================================================================

  bool get hasActiveFilters =>
      query.trim().isNotEmpty ||
      budget != 'Any' ||
      amenities.isNotEmpty ||
      gender != 'Any' ||
      status != 'Any';

  //============================================================================
  //! JSON
  //============================================================================

  Map<String, dynamic> toJson() {
    return {
      'query': query,
      'budget': budget,
      'gender': gender,
      'status': status,
      'amenities': amenities,
    };
  }

  factory SearchFilterModel.fromJson(Map<String, dynamic> json) {
    return SearchFilterModel(
      query: json['query'] ?? '',
      budget: json['budget'] ?? 'Any',
      gender: json['gender'] ?? 'Any',
      status: json['status'] ?? 'Any',
      amenities: List<String>.from(json['amenities'] ?? []),
    );
  }

  //============================================================================
  //! DEBUG
  //============================================================================

  @override
  String toString() {
    return '''
SearchFilterModel(
  query: $query,
  budget: $budget,
  gender: $gender,
  status: $status,
  amenities: $amenities,
)
''';
  }
}

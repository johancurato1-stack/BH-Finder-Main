class SearchFilterModel {
  String query;
  String budget;
  String distance;
  String gender;
  String status;
  List<String> amenities;

  SearchFilterModel({
    this.query = '',
    this.budget = 'Any',
    this.distance = 'Any',
    this.gender = 'Mixed',
    this.status = 'Available',
    List<String>? amenities,
  }) : amenities = amenities ?? [];

  //============================================================================
  //! RESET
  //============================================================================

  void reset() {
    query = '';
    budget = 'Any';
    distance = 'Any';
    gender = 'Mixed';
    status = 'Available';
    amenities.clear();
  }

  //============================================================================
  //! COPY
  //============================================================================

  SearchFilterModel copyWith({
    String? query,
    String? budget,
    String? distance,
    String? gender,
    String? status,
    List<String>? amenities,
  }) {
    return SearchFilterModel(
      query: query ?? this.query,
      budget: budget ?? this.budget,
      distance: distance ?? this.distance,
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
      parts.addAll(amenities);
    }

    if (distance != 'Any') {
      parts.add(distance);
    }

    if (gender != 'Mixed') {
      parts.add(gender);
    }

    if (status != 'Available') {
      parts.add(status);
    }

    return parts.join(' • ');
  }

  //============================================================================
  //! HAS ACTIVE FILTERS
  //============================================================================

  bool get hasActiveFilters {
    return query.trim().isNotEmpty ||
        budget != 'Any' ||
        amenities.isNotEmpty ||
        distance != 'Any' ||
        gender != 'Mixed' ||
        status != 'Available';
  }

  //============================================================================
  //! TO JSON
  //============================================================================

  Map<String, dynamic> toJson() {
    return {
      'query': query,
      'budget': budget,
      'distance': distance,
      'gender': gender,
      'status': status,
      'amenities': amenities,
    };
  }

  //============================================================================
  //! FROM JSON
  //============================================================================

  factory SearchFilterModel.fromJson(Map<String, dynamic> json) {
    return SearchFilterModel(
      query: json['query'] ?? '',
      budget: json['budget'] ?? 'Any',
      distance: json['distance'] ?? 'Any',
      gender: json['gender'] ?? 'Mixed',
      status: json['status'] ?? 'Available',
      amenities: List<String>.from(json['amenities'] ?? []),
    );
  }

  //============================================================================
  //! TO STRING
  //============================================================================

  @override
  String toString() {
    return '''
SearchFilterModel(
  query: $query,
  budget: $budget,
  distance: $distance,
  gender: $gender,
  status: $status,
  amenities: $amenities,
)
''';
  }
}

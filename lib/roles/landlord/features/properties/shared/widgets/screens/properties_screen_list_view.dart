import 'package:flutter/material.dart';

import 'package:bh_finder/core/repositories/repositories/property_repository.dart';

import 'package:bh_finder/core/ui_models/landlord_property_card_data.dart';

import 'package:bh_finder/shared/widgets/animations/animated_entrance.dart';

import 'package:bh_finder/roles/landlord/features/properties/shared/widgets/cards/add_property_card_vertical/add_property_card_vertical.dart';
import 'package:bh_finder/roles/landlord/features/properties/shared/widgets/cards/property_card_vertical/property_card_vertical.dart';

import 'package:bh_finder/roles/landlord/shared/models/landlord_property_origin.dart';

import 'package:bh_finder/roles/landlord/shared/widgets/screens/add_property_screen/add_property_screen.dart';
import 'package:bh_finder/roles/landlord/shared/widgets/screens/property_detail_screen/property_detail_screen.dart';

//============================================================================
//! PROPERTIES SCREEN LIST VIEW
//============================================================================

class PropertiesScreenListView extends StatefulWidget {
  //==========================================================================
  //! CONSTRUCTOR
  //==========================================================================

  const PropertiesScreenListView({
    super.key,
    required this.propertyRepository,
    required this.propertyRefreshNotifier,
  });

  //==========================================================================
  //! PROPERTIES
  //==========================================================================

  final PropertyRepository propertyRepository;

  final ValueNotifier<int> propertyRefreshNotifier;

  @override
  State<PropertiesScreenListView> createState() =>
      _PropertiesScreenListViewState();
}

//============================================================================
//! STATE
//============================================================================

class _PropertiesScreenListViewState extends State<PropertiesScreenListView> {
  //==========================================================================
  //! STATE
  //==========================================================================

  List<LandlordPropertyCardData> _properties = [];

  bool _loading = true;

  //==========================================================================
  //! LIFECYCLE
  //==========================================================================

  @override
  void initState() {
    super.initState();

    widget.propertyRefreshNotifier.addListener(_onPropertyRefresh);

    _loadProperties();
  }

  @override
  void dispose() {
    widget.propertyRefreshNotifier.removeListener(_onPropertyRefresh);

    super.dispose();
  }

  //==========================================================================
  //! PROPERTY REFRESH
  //==========================================================================

  void _onPropertyRefresh() {
    _loadProperties();
  }

  //==========================================================================
  //! LOAD PROPERTIES
  //==========================================================================

  Future<void> _loadProperties() async {
    if (mounted) {
      setState(() {
        _loading = true;
      });
    }

    try {
      final properties = await widget.propertyRepository
          .getLandlordPropertyCards();

      if (!mounted) return;

      setState(() {
        _properties = properties;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;

      debugPrint('Failed to load landlord properties: $e');

      setState(() {
        _loading = false;
      });
    }
  }

  //==========================================================================
  //! SLIDE ROUTE
  //==========================================================================

  Route<T> _buildSlideRoute<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
          child: child,
        );
      },
    );
  }

  //==========================================================================
  //! OPEN PROPERTY
  //==========================================================================

  Future<void> _openProperty(LandlordPropertyCardData property) async {
    final updated = await Navigator.push<bool>(
      context,
      _buildSlideRoute(
        PropertyDetailScreen(
          propertyId: property.id,
          origin: LandlordPropertyOrigin.properties,
        ),
      ),
    );

    if (!mounted || updated != true) {
      return;
    }

    await _loadProperties();

    widget.propertyRefreshNotifier.value++;
  }

  //==========================================================================
  //! OPEN ADD PROPERTY
  //==========================================================================

  Future<void> _openAddProperty() async {
    final created = await Navigator.push<bool>(
      context,
      _buildSlideRoute(
        const AddPropertyScreen(origin: LandlordPropertyOrigin.properties),
      ),
    );

    if (!mounted || created != true) {
      return;
    }

    await _loadProperties();

    widget.propertyRefreshNotifier.value++;
  }

  //==========================================================================
  //! BUILD
  //==========================================================================

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    final properties = _properties;

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: properties.length + 1,
      itemBuilder: (context, index) {
        //======================================================================
        //! ADD PROPERTY CARD
        //======================================================================

        if (index == properties.length) {
          return AnimatedEntrance(
            order: index,
            beginOffset: const Offset(-0.25, 0),
            child: AddPropertyCardVertical(onTap: _openAddProperty),
          );
        }

        //======================================================================
        //! PROPERTY CARD
        //======================================================================

        final property = properties[index];

        return AnimatedEntrance(
          order: index,
          beginOffset: const Offset(-0.25, 0),
          child: PropertyCardVertical(
            data: property,
            onTap: () => _openProperty(property),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';

import 'package:bh_finder/core/ui_models/landlord_property_card_data.dart';

import 'package:bh_finder/core/repositories/repositories/property_repository.dart';
import 'package:bh_finder/core/repositories/repositories/repositories.dart';

import 'package:bh_finder/core/repositories/supabase/supabase_auth_repository.dart';
import 'package:bh_finder/core/repositories/supabase/supabase_profile_repository.dart';
import 'package:bh_finder/core/repositories/supabase/supabase_storage_repository.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/core/view_models/profile_view_model.dart';

import 'package:bh_finder/shared/widgets/animations/animated_entrance.dart';
import 'package:bh_finder/shared/widgets/others/page_indicator.dart';

import 'package:bh_finder/roles/landlord/features/dashboard/shared/widgets/dashboard_screen/widgets/dashboard_screen_greeting_section.dart';
import 'package:bh_finder/roles/landlord/features/dashboard/shared/widgets/dashboard_screen/widgets/dashboard_screen_header.dart';
import 'package:bh_finder/roles/landlord/features/dashboard/shared/widgets/dashboard_screen/widgets/dashboard_screen_recent_inquiries_section.dart';
import 'package:bh_finder/roles/landlord/features/dashboard/shared/widgets/dashboard_screen/widgets/dashboard_property_card_carousel.dart';

import 'package:bh_finder/roles/landlord/shared/widgets/screens/add_property_screen/add_property_screen.dart';
import 'package:bh_finder/roles/landlord/shared/widgets/screens/property_detail_screen/property_detail_screen.dart';
import 'package:bh_finder/roles/landlord/shared/models/landlord_property_origin.dart';

//============================================================================
//! DASHBOARD SCREEN
//============================================================================

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key, required this.propertyRefreshNotifier});

  final ValueNotifier<int> propertyRefreshNotifier;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

//============================================================================
//! STATE
//============================================================================

class _DashboardScreenState extends State<DashboardScreen> {
  //==========================================================================
  //! REPOSITORIES
  //==========================================================================

  final PropertyRepository _propertyRepository =
      Repositories.instance.propertyRepository;

  final SupabaseStorageRepository _storageRepository =
      SupabaseStorageRepository();

  //==========================================================================
  //! VIEW MODELS
  //==========================================================================

  late final ProfileViewModel _profileViewModel = ProfileViewModel(
    repository: SupabaseProfileRepository(),
    storageRepository: _storageRepository,
    authRepository: SupabaseAuthRepository(),
  );

  //==========================================================================
  //! STATE
  //==========================================================================

  int _currentPage = 0;

  bool _loading = true;

  List<LandlordPropertyCardData> _properties = [];

  //==========================================================================
  //! LIFECYCLE
  //==========================================================================

  @override
  void initState() {
    super.initState();

    widget.propertyRefreshNotifier.addListener(_onPropertyRefresh);

    _profileViewModel.loadProfile();

    _loadProperties();
  }

  @override
  void dispose() {
    widget.propertyRefreshNotifier.removeListener(_onPropertyRefresh);

    _profileViewModel.dispose();

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

    final properties = await _propertyRepository.getLandlordPropertyCards();

    if (!mounted) return;

    setState(() {
      _properties = properties;

      if (_currentPage >= _properties.length + 1) {
        _currentPage = 0;
      }

      _loading = false;
    });
  }

  //==========================================================================
  //! REFRESH
  //==========================================================================

  Future<void> _refreshProperties() async {
    await _loadProperties();
  }

  //==========================================================================
  //! NAVIGATION
  //==========================================================================

  Route<T> _buildSlideRoute<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0, 1);
        const end = Offset.zero;
        const curve = Curves.easeOut;

        final offsetAnimation = animation.drive(
          Tween(begin: begin, end: end).chain(CurveTween(curve: curve)),
        );

        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }

  //==========================================================================
  //! BUILD
  //==========================================================================

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _profileViewModel,
      builder: (context, _) {
        final profile = _profileViewModel.profile;

        if (_loading || _profileViewModel.isLoading || profile == null) {
          return const Scaffold(
            backgroundColor: AppColors.background,
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //==========================================================
                  //! HEADER
                  //==========================================================
                  AnimatedEntrance(
                    order: 0,
                    child: DashboardScreenHeader(onNotificationPressed: () {}),
                  ),

                  //==========================================================
                  //! GREETING
                  //==========================================================
                  AnimatedEntrance(
                    order: 1,
                    child: DashboardScreenGreetingSection(
                      firstName: profile['first_name'] ?? '',
                      avatarUrl: _storageRepository.getPublicUrl(
                        'avatars',
                        (profile['avatar_path'] ?? '').replaceFirst(
                          'avatars/',
                          '',
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  //==========================================================
                  //! PROPERTY CAROUSEL
                  //==========================================================
                  AnimatedEntrance(
                    order: 2,
                    child: DashboardPropertyCardCarousel(
                      properties: _properties,

                      onPageChanged: (page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },

                      onPropertyTap: (property) async {
                        final updated = await Navigator.push<bool>(
                          context,
                          _buildSlideRoute(
                            PropertyDetailScreen(
                              propertyId: property.id,
                              origin: LandlordPropertyOrigin.dashboard,
                            ),
                          ),
                        );

                        if (!mounted || updated != true) {
                          return;
                        }

                        await _refreshProperties();

                        widget.propertyRefreshNotifier.value++;
                      },

                      onAddProperty: () async {
                        final created = await Navigator.push<bool>(
                          context,
                          _buildSlideRoute(
                            const AddPropertyScreen(
                              origin: LandlordPropertyOrigin.dashboard,
                            ),
                          ),
                        );

                        if (!mounted || created != true) {
                          return;
                        }

                        await _refreshProperties();

                        widget.propertyRefreshNotifier.value++;
                      },
                    ),
                  ),

                  //==========================================================
                  //! PAGE INDICATOR
                  //==========================================================
                  AnimatedEntrance(
                    order: 3,
                    child: PageIndicator(
                      currentPage: _currentPage,
                      pageCount: _properties.length + 1,
                    ),
                  ),

                  const SizedBox(height: 18),

                  //==========================================================
                  //! RECENT INQUIRIES
                  //==========================================================
                  const AnimatedEntrance(
                    order: 4,
                    child: DashboardScreenRecentInquiriesSection(),
                  ),

                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

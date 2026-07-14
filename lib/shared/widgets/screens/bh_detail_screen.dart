import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/data/models/bh_model.dart';
import 'package:bh_finder/core/providers/bh_provider.dart';
import 'package:bh_finder/shared/widgets/buttons/custom_button.dart';
import 'package:bh_finder/shared/widgets/screens/view_rooms_screen.dart';

class BhDetailScreen extends StatefulWidget {
  final BhModel boardingHouse;

  const BhDetailScreen({super.key, required this.boardingHouse});

  @override
  State<BhDetailScreen> createState() => _BhDetailScreenState();
}

class _BhDetailScreenState extends State<BhDetailScreen> {
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _autoScrollTimer;
  late List<String> _images;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    _images = [
      widget.boardingHouse.imageUrl,
      'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?q=80&w=600',
      'https://images.unsplash.com/photo-1598928506311-c55ded91a20c?q=80&w=600',
    ];

    _startAutoScroll();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_pageController.hasClients) {
        int nextPage = _currentPage + 1;
        if (nextPage >= _images.length) {
          nextPage = 0;
        }
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'occupied':
        return const Color(0xFFEF5350);
      case 'pending':
        return const Color(0xFFFFB300);
      case 'available':
      default:
        return const Color(0xFF00E676);
    }
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bh = widget.boardingHouse;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: ClipRRect(
        // <--- ADD THIS
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.40,
                        child: PageView.builder(
                          controller: _pageController,
                          onPageChanged: (index) =>
                              setState(() => _currentPage = index),
                          itemCount: _images.length,
                          itemBuilder: (context, index) =>
                              Image.network(_images[index], fit: BoxFit.cover),
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).padding.top + 12,
                        left: 16,
                        right: 16,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildFloatingButton(
                              Icons.arrow_back_ios_new_rounded,
                              iconColor: AppColors.secondary,
                              () => Navigator.pop(context),
                            ),
                            Consumer<BhProvider>(
                              builder: (context, provider, child) {
                                return Row(
                                  children: [
                                    _buildFloatingButton(
                                      bh.isSaved
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      () => provider.toggleSaved(bh),
                                      iconColor: bh.isSaved
                                          ? Colors.red
                                          : AppColors.secondary,
                                    ),
                                    const SizedBox(width: 12),
                                    _buildFloatingButton(
                                      Icons.share,
                                      iconColor: AppColors.secondary,
                                      () {},
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(bh.status),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleAvatar(
                                radius: 4,
                                backgroundColor: AppColors.white,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                bh.status,
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          bh.title,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: AppColors.secondary,
                            fontFamily: 'Roboto',
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '₱ ${bh.price} / month',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                            fontFamily: 'Roboto',
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 16,
                              color: AppColors.tertiary,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                bh.distanceText,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: AppColors.tertiary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            _buildMetaChip(
                              Icons.person_outline,
                              bh.genderRules,
                            ),
                            const SizedBox(width: 8),
                            _buildMetaChip(
                              Icons.meeting_room,
                              '${bh.totalRooms} Rooms',
                            ),
                            const SizedBox(width: 8),
                            _buildMetaChip(
                              Icons.group_outlined,
                              '${bh.availabilityCount} Tenants',
                            ),
                          ],
                        ),
                        const Divider(
                          height: 32,
                          thickness: 0.5,
                          color: AppColors.tertiary,
                        ),
                        const Text(
                          'About this place',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.secondary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          bh.description,
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.secondary,
                            height: 1.4,
                          ),
                        ),
                        const Divider(
                          height: 32,
                          thickness: 0.5,
                          color: AppColors.tertiary,
                        ),
                        const Text(
                          'Amenities',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.secondary,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: bh.amenities
                              .map((amenity) => _buildAmenityBox(amenity))
                              .toList(),
                        ),
                        const Divider(
                          height: 32,
                          thickness: 0.5,
                          color: AppColors.tertiary,
                        ),
                        const Text(
                          'Contact the owner',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.secondary,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 24,
                              backgroundImage: NetworkImage(
                                bh.landlord.imageUrl,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    bh.landlord.name,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.secondary,
                                    ),
                                  ),
                                  Text(
                                    bh.landlord.responseTime,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.tertiary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.phone,
                                color: AppColors.primary,
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                20,
                10,
                20,
                MediaQuery.of(context).padding.bottom + 12,
              ),
              child: CustomButton(
                text: 'View Rooms (${bh.totalRooms})',
                onPressed: () {
                  final provider = Provider.of<BhProvider>(
                    context,
                    listen: false,
                  );
                  final filteredRooms = provider.getRoomsForBh(bh.id);

                  // LOGGING TO VERIFY
                  debugPrint(
                    "BH ID: ${bh.id} | Found Rooms: ${filteredRooms.length}",
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewRoomsScreen(
                        bhName: bh.title,
                        rooms: filteredRooms,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingButton(
    IconData icon,
    VoidCallback onTap, {
    Color? iconColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 40,
        decoration: const BoxDecoration(
          color: AppColors.background,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor ?? AppColors.secondary, size: 20),
      ),
    );
  }

  Widget _buildMetaChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white, // The background color
        borderRadius: BorderRadius.circular(
          8,
        ), // Shadows look best with rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Shadow color
            blurRadius: 3, // How soft the shadow is
            offset: const Offset(0, 0), // Changes position of shadow (x, y)
          ),
        ],
      ),
      child: Row(
        mainAxisSize:
            MainAxisSize.min, // Added to keep the chip width tight to content
        children: [
          Icon(icon, size: 14, color: AppColors.tertiary),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.tertiary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmenityBox(String title) {
    IconData icon;
    switch (title.toLowerCase()) {
      case 'wi-fi':
        icon = Icons.wifi;
        break;
      case 'aircon':
        icon = Icons.ac_unit;
        break;
      case 'own cr':
        icon = Icons.bathroom;
        break;
      case 'kitchen':
        icon = Icons.countertops;
        break;
      case 'laundry':
        icon = Icons.local_laundry_service;
        break;
      case 'study area':
        icon = Icons.menu_book;
        break;
      case 'desk':
        icon = Icons.desk;
        break;
      case 'cabinet':
        icon = Icons.shelves;
        break;
      case 'cctv':
        icon = Icons.videocam;
        break;
      case 'security':
        icon = Icons.security;
        break;
      case 'parking':
        icon = Icons.directions_car;
        break;
      default:
        icon = Icons.star;
    }
    return Container(
      width: (MediaQuery.of(context).size.width - 70) / 4,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        // Add this shadow block
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Very light shadow
            blurRadius: 3,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 24, color: AppColors.tertiary),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(fontSize: 10, color: AppColors.tertiary),
          ),
        ],
      ),
    );
  }
}

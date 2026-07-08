import 'package:flutter/material.dart';
import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/features/home/widgets/room_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                //!======================================================================================================================================== T O P  I C O N S

                //* Top Logo
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //* Brand Logo
                    Row(
                      children: const [
                        Icon(
                          Icons.home_work_rounded,
                          color: AppColors.primary,
                          size: 25,
                        ),

                        //* Title
                        SizedBox(width: 8),
                        Text(
                          'BH Finder',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),

                    //* Notification Bell Icon
                    IconButton(
                      icon: const Icon(
                        Icons.notifications_none_rounded,
                        color: AppColors.secondary,
                        size: 28,
                      ),
                      onPressed: () {
                        print("Notification bell clicked");
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                //!======================================================================================================================================== T O P  T E X T

                //* Hero Typography Header
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 32,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                    ),
                    children: [
                      TextSpan(
                        text: 'Find your\nnext home,\n',
                        style: TextStyle(color: AppColors.secondary),
                      ),
                      TextSpan(
                        text: 'near your school.',
                        style: TextStyle(color: AppColors.primary),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                //* Slogan Subtitle Text
                const Text(
                  'Simple. Trusted. Affordable.',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondary,
                  ),
                ),

                const SizedBox(height: 20),

                //!======================================================================================================================================== S E A R C H  B A R

                //* Background
                GestureDetector(
                  onTap: () {
                    print("Search bar clicked!");
                  },
                  child: Container(
                    height: 63,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.06),
                          blurRadius: 15,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),

                    //* Row
                    child: Row(
                      children: [
                        const SizedBox(width: 10),

                        //* Search Icon 1
                        const Icon(
                          Icons.search_rounded,
                          color: AppColors.tertiary,
                          size: 18,
                        ),

                        const SizedBox(width: 8),

                        //* Floating Text
                        const Text(
                          'Search by location, school, \nor area..',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            color: AppColors.tertiary,
                            fontSize: 12,
                          ),
                        ),

                        const Spacer(),

                        //* Seach Icon 2 (Incased)
                        Center(
                          child: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.search_rounded,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                //!======================================================================================================================================== N E A R  Y O U  H E A D E R
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Near You',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: AppColors.secondary,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print("See all listings clicked");
                        },
                        child: const Text(
                          'See all',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primary,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 5),

                //!======================================================================================================================================== S C R O L L A B L E  R O O M  C A R D S
                SizedBox(
                  height: 255,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 0.5),
                    physics: const BouncingScrollPhysics(),

                    //* Room #1
                    children: [
                      SizedBox(
                        width: 175,
                        child: RoomCard(
                          imageUrl:
                              'https://images.unsplash.com/photo-1598928506311-c55ded91a20c?q=80&w=500&auto=format&fit=crop',
                          price: '2,800',
                          title: 'Green Haven Boarding House',
                          distanceText:
                              '5 minute walk to Caraga State University',
                          genderRules: 'Female Only',
                          availabilityCount: '4/6',
                        ),
                      ),
                      SizedBox(width: 16),

                      //* Room #2
                      SizedBox(
                        width: 175,
                        child: RoomCard(
                          imageUrl:
                              'https://images.unsplash.com/photo-1616486338812-3dadae4b4ace?q=80&w=500&auto=format&fit=crop',
                          price: '3,200',
                          title: 'Blessed Home Boarding House',
                          distanceText:
                              '8 minute walk to Caraga State University',
                          genderRules: 'Female Only',
                          availabilityCount: '5/8',
                        ),
                      ),
                      SizedBox(width: 16),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

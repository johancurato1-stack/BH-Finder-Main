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

                //*-----------------------------------------------------------------------------------------------------------------

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
                        size: 25,
                      ),
                      onPressed: () {
                        print("Notification bell clicked");
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                //*-----------------------------------------------------------------------------------------------------------------

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

                const SizedBox(height: 25),

                //*----------------------------------------------------------------------------------------------------------------- S E A R C H  B A R

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
                          color: Colors.black.withOpacity(0.06),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/features/home/widgets/room_card_horizontal.dart';
import 'package:bh_finder/core/data/mock_room.dart';
import 'package:bh_finder/features/messages/notification_chat_screen.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onSearchPressed;
  final bool hasNotification;
  final VoidCallback onNotificationsRead;

  const HomeScreen({
    super.key,
    required this.onSearchPressed,
    required this.hasNotification, // Add this parameter
    required this.onNotificationsRead,
  });

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            //!======================================================================================================================================== T O P  I C O N S  &  H E A D E R S
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          //* Brand Logo
                          children: const [
                            Icon(
                              Icons.home_work_rounded,
                              color: AppColors.primary,
                              size: 25,
                            ),

                            SizedBox(width: 8),

                            //* Brand Title
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

                        //* Notification Button
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.notifications_none_rounded,
                                color: AppColors.secondary,
                                size: 28,
                              ),
                              onPressed: () {
                                // 1. Push the screen open
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const NotificationChatScreen(),
                                  ),
                                );
                                // 2. Call the parent function to turn off the red dot
                                widget.onNotificationsRead();
                              },
                            ),
                            // 3. Render the red dot overlay if true
                            if (widget.hasNotification)
                              Positioned(
                                right: 8,
                                top: 8,
                                child: Container(
                                  width: 9,
                                  height: 9,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppColors.background,
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),

                    //!======================================================================================================================================== H E R O  H E A D E R

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

                    //!======================================================================================================================================== S U B T I T L E  H E A D E R

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
                    GestureDetector(
                      onTap: widget.onSearchPressed,
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
                        child: Row(
                          children: [
                            const SizedBox(width: 10),
                            const Icon(
                              Icons.search_rounded,
                              color: AppColors.tertiary,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Search by location, school, \nor area..',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                color: AppColors.tertiary,
                                fontSize: 12,
                              ),
                            ),
                            const Spacer(),
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
                    Row(
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
                    const SizedBox(height: 10),
                  ],
                ),
              ),

              //!======================================================================================================================================== R O O M  L I S T
              SizedBox(
                height: 255,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  physics: const BouncingScrollPhysics(),
                  itemCount: mockRooms.length,
                  itemBuilder: (context, index) {
                    final room = mockRooms[index];
                    return Container(
                      width: 175,
                      margin: const EdgeInsets.only(right: 16),
                      child: RoomCardHorizontal(
                        title: room.title,
                        imageUrl: room.imageUrl,
                        price: room.price,
                        distanceText: room.distanceText,
                        genderRules: room.genderRules,
                        availabilityCount: room.availabilityCount,
                        status: room.status,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

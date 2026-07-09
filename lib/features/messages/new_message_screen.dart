import 'package:flutter/material.dart';
import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/data/mock_contact.dart';

class NewMessageScreen extends StatefulWidget {
  const NewMessageScreen({super.key});

  @override
  State<NewMessageScreen> createState() => _NewMessageScreenState();
}

class _NewMessageScreenState extends State<NewMessageScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //!========================================================================= HEADER
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppColors.secondary,
                      size: 24,
                    ),
                  ),
                  const Text(
                    'New message',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.secondary,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  const SizedBox(width: 48), // Keeps title perfectly centered
                ],
              ),
            ),

            //!========================================================================= "TO:" SEARCH FIELD
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  const Text(
                    'To:',
                    style: TextStyle(fontSize: 16, color: AppColors.tertiary),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: 'Type a name or a group',
                        hintStyle: TextStyle(
                          color: AppColors.tertiary,
                          fontSize: 16,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //!========================================================================= MAIN CONTENT LIST
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 2),
                children: [
                  // Group Chat Entry Option Row
                  ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Color(0xFF2C2C2C),
                      radius: 17,
                      child: Icon(Icons.group, color: Colors.white, size: 17),
                    ),
                    title: const Text(
                      'Group chat',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: AppColors.secondary,
                      ),
                    ),
                    onTap: () {
                      // Handled later
                    },
                  ),

                  // Suggested Header Divider Label
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                    child: Text(
                      'Suggested',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.tertiary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  // Suggested Contacts mapping directly from your core centralized array
                  ...suggestedContacts.map((String contactName) {
                    return ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Color(0xFF2C2C2C),
                        radius: 17,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 17,
                        ),
                      ),
                      title: Text(
                        contactName,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: AppColors.secondary,
                        ),
                      ),
                      onTap: () {
                        // Handled later
                      },
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

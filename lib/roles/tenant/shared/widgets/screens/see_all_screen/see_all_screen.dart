import 'package:flutter/material.dart';

import 'package:bh_finder/core/data/models/boarding_house_model.dart';
import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/filters/filter_bottom_sheet/filter_bottom_sheet.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/screens/see_all_screen/widgets/see_all_property_list_view.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/screens/see_all_screen/widgets/see_all_header.dart';

class SeeAllScreen extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const SeeAllScreen({
    super.key,
    required this.title,
    required this.boardingHouses,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final String title;
  final List<BoardingHouseModel> boardingHouses;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            //==================================================================
            //! HEADER
            //==================================================================
            SeeAllHeader(
              title: title,
              onBack: () => Navigator.pop(context),
              onFilter: () => FilterBottomSheet.show(context),
            ),

            //==================================================================
            //! PROPERTY LIST
            //==================================================================
            Expanded(child: PropertyListView(boardingHouses: boardingHouses)),
          ],
        ),
      ),
    );
  }
}

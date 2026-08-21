import 'package:flutter/material.dart';

import 'package:bh_finder/core/models/room_model.dart';

import 'package:bh_finder/shared/widgets/images/app_network_image.dart';

//============================================================================
//! PROPERTY ROOM IMAGE
//============================================================================

class PropertyRoomImage extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const PropertyRoomImage({super.key, required this.room});

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final RoomModel room;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,

      child: ClipRRect(
        //======================================================================
        //! ROUNDED IMAGE
        //======================================================================
        borderRadius: BorderRadius.circular(16),

        child: room.images.isEmpty
            ? Container(
                color: Colors.grey.shade100,
                alignment: Alignment.center,
                child: const Icon(Icons.image_not_supported_outlined),
              )
            : AppNetworkImage(
                imageUrl: room.images.first.path,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:bh_finder/core/property_and_room_adding_updating/models/room_model.dart';

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
    return ClipRRect(
      //======================================================================
      //! ROUNDED IMAGE
      //======================================================================
      borderRadius: BorderRadius.circular(16),

      child: room.images.isEmpty
          ? const SizedBox(
              width: 80,
              height: 80,
              child: Center(child: Icon(Icons.image_not_supported_outlined)),
            )
          : Image.network(
              room.images.first.path,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const SizedBox(
                  width: 80,
                  height: 80,
                  child: Center(child: Icon(Icons.broken_image_outlined)),
                );
              },
            ),
    );
  }
}

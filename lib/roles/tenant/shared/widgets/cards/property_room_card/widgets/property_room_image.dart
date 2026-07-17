import 'package:flutter/material.dart';

import 'package:bh_finder/core/data/models/room_model.dart';

class PropertyRoomImage extends StatelessWidget {
  //* Room data to display.
  final RoomModel room;

  const PropertyRoomImage({super.key, required this.room});

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      //* Rounded image corners.
      borderRadius: BorderRadius.circular(16),

      child: Image.network(
        //* Room thumbnail.
        room.imageUrl,

        //* Image dimensions.
        width: 80,
        height: 80,

        //* Crop image to completely fill the container.
        fit: BoxFit.cover,
      ),
    );
  }
}

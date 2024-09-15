import 'package:flutter/material.dart';

  Widget plantItem(dynamic plant, VoidCallback onTap,Set<int> favoritePlantIds , VoidCallback onFavoriteTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: GestureDetector(
              onTap: onTap, 

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Plant image
          Stack(
            children: [
            ClipRRect(
               borderRadius: BorderRadius.circular(8),
         child: Container(
           color: Colors.grey.shade200, // Light background color
           child: Image.network(
           plant['image_url'],
            height: 112, // Increased height
            width: 112,  // Increased width
            fit: BoxFit.cover,
          ),
     ),
   ),

              // Favorite icon at the bottom left
              Positioned(
                bottom: 8,
                left: 78,
                child: GestureDetector(
                  onTap: onFavoriteTap, // Handle tap on favorite icon
                  child: Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      favoritePlantIds.contains(plant['id']) // Check if this plant is a favorite
                          ? Icons.favorite
                          : Icons.favorite_border, // Toggle between filled and border icon
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          // Plant details (Name, Size, Price)
          Expanded(
           // Navigate to detail screen
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    plant['name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold, 
                      fontSize: 18, // Increased font size
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${plant['display_size']} cm',
                    style: const TextStyle(fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${plant['price']} ${plant['price_unit']}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            
          ),
          // Rating
          Row(
            children: [
              Icon(
                Icons.star,
                color: Colors.orange.shade400,
                size: 15,
              ),
              const SizedBox(width: 7),
              Text(
                '${plant['rating']}',
                style: TextStyle(color: Colors.orange.shade400),
              ),
            ],
          ),
        ],
      ),
      )
    );
  }

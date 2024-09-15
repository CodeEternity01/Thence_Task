import 'package:flutter/material.dart';

class PlantDetailScreen extends StatefulWidget {
  final dynamic plant;
  final Set<int> favoritePlantIds;
  final VoidCallback onFavoriteTap;

  const PlantDetailScreen(
      {super.key,
      required this.plant,
      required this.favoritePlantIds,
      required this.onFavoriteTap});

  @override
  _PlantDetailScreenState createState() => _PlantDetailScreenState();
}

class _PlantDetailScreenState extends State<PlantDetailScreen> {
  int? _selectedSize; // Holds the currently selected size

  @override
  Widget build(BuildContext context) {
    final imageUrl = widget.plant['image_url'];
    final name = widget.plant['name'];
    final rating = widget.plant['rating'];
    final availableSizes = widget.plant['available_size']; // List of available sizes
    final price = widget.plant['price'];
    final priceUnit = widget.plant['price_unit'];
    final description = widget.plant['description'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image of the plant
                  Image.network(imageUrl, fit: BoxFit.cover),

                  const SizedBox(height: 16.0),

                  // Plant name and price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '$price$priceUnit',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8.0),

                  // Rating
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber),
                        Text(
                          '$rating',
                          style:
                              const TextStyle(fontSize: 18, color: Colors.amber),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16.0),

                  // Size options
                  const Text(
                    'Choose Size',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  Wrap(
                    spacing: 8.0,
                    children: availableSizes.map<Widget>((size) {
                      final isSelected = _selectedSize == size; // Check if this size is selected
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedSize = size; // Update selected size
                          });
                        },
                        child: Chip(
                          label: Text('$size cm'),
                          backgroundColor: isSelected
                              ? const Color.fromARGB(255, 183, 136, 119) // Change color if selected
                              : Colors.grey[200], // Default color
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 16.0),

                  // Description
                  const Text(
                    'Description',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 12.0),

                  Text(
                    description,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Row: Favorite icon and Add to Cart button
          Padding(
            padding: const EdgeInsets.only(left: 30, bottom: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Favorite Icon
                GestureDetector(
                  onTap: widget.onFavoriteTap, // Handle tap on favorite icon
                  child: Container(
                    padding: const EdgeInsets.all(11.0),
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        shape: BoxShape.rectangle,
                        borderRadius: const BorderRadius.all(Radius.circular(20))),
                    child: Icon(
                      widget.favoritePlantIds.contains(widget.plant['id'])
                          ? Icons.favorite
                          : Icons.favorite_border, // Toggle between filled and border icon
                      color: Colors.black,
                      size: 40,
                    ),
                  ),
                ),
                // Add to Cart button
                ElevatedButton(
                  onPressed: () {
                    // Handle adding to cart action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 183, 136, 119),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 60.0, vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17.0),
                    ),
                  ),
                  child: const Text(
                    'Add to cart',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

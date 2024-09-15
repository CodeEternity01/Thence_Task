import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:skeletonizer/skeletonizer.dart';
import 'package:thence_assignment/widgets/filter_chip_widget.dart';
import 'package:thence_assignment/widgets/plant_item_widget.dart';
import 'package:thence_assignment/widgets/promo_banner_widget.dart';
import 'plant_detail_screen.dart'; // Import the updated detail screen

class ApiScreen extends StatefulWidget {
  const ApiScreen({super.key});

  @override
  State<ApiScreen> createState() => _ApiScreenState();
}

class _ApiScreenState extends State<ApiScreen> {
  List<dynamic> plants = [];
  List<dynamic> repeatedPlants = [];
  List<dynamic> filteredPlants = []; // Filtered plants for search functionality
  final int itemsToRepeat = 10; // Number of items to show in a cycle
  Set<int> favoritePlantIds = {}; // Local variable to store favorite plant IDs
  int _selectedCategoryIndex =
      0; // To store the index of selected category chip
  bool isSearching = false; // Track whether search is active
  TextEditingController searchController = TextEditingController();
  bool enabled = true;
  @override
  void initState() {
    super.initState();
    fetchPlants();
  }

  @override
  Widget build(BuildContext context) {
    // List of categories for chips
    final categories = ["All", "Succulents", "In pots", "Dried flowers"];
    List<dynamic> displayPlants = isSearching ? filteredPlants : repeatedPlants;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false, // Remove default back button
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(left: 16, top: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              isSearching
                  ? Expanded(
                      child: TextField(
                        controller: searchController,
                        onChanged: searchPlants,
                        autofocus: true,
                        decoration: const InputDecoration(
                          hintText: 'Search plants...',
                          border: InputBorder.none,
                        ),
                      ),
                    )
                  : const Text(
                      'All plants',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
              IconButton(
                icon: Icon(isSearching ? Icons.close : Icons.search,
                    color: Colors.black),
                iconSize: 30,
                onPressed: () {
                  setState(() {
                    if (isSearching) {
                      searchController.clear();
                      searchPlants(''); // Reset search results
                    }
                    isSearching = !isSearching;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      body: Skeletonizer(
        enabled: enabled,
        child: Column(
          children: [
            // Heading "Houseplants"
            if (!isSearching) // Only show the heading if not searching
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 16.0, bottom: 10),
                child: const Text(
                  'Houseplants',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
            // Tab bar for categories
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children:
                      List<Widget>.generate(categories.length, (int index) {
                    return categoryChip(
                      categories[index],
                      isSelected: _selectedCategoryIndex == index,
                      onSelected: (bool selected) {
                        setState(() {
                          _selectedCategoryIndex = index;
                        });
                      },
                    );
                  }),
                ),
              ),
            ),
            Expanded(
              child: displayPlants.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: displayPlants.length +
                          (displayPlants.length ~/
                              3), // Adjust count for banners
                      itemBuilder: (context, index) {
                        int adjustedIndex =
                            index - (index ~/ 4); // Adjust index for banners

                        // Check if we should show a banner
                        if ((index + 1) % 4 == 0) {
                          return freeShippingBanner(); // Display the free shipping banner
                        }

                        // Ensure adjustedIndex does not go out of bounds
                        if (adjustedIndex >= displayPlants.length)
                          return const SizedBox.shrink();

                        final plant = displayPlants[adjustedIndex];
                        return plantItem(
                            plant,
                            () {
                              // Navigate to details screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PlantDetailScreen(
                                    plant: plant,
                                    favoritePlantIds: favoritePlantIds,
                                    onFavoriteTap: () {
                                      setState(() {
                                        if (favoritePlantIds
                                            .contains(plant['id'])) {
                                          favoritePlantIds.remove(plant[
                                              'id']); // Un-favorite the plant
                                        } else {
                                          favoritePlantIds.add(plant[
                                              'id']); // Favorite the plant
                                        }
                                      });
                                    },
                                  ),
                                ),
                              );
                            },
                            favoritePlantIds,
                            () {
                              // Handle favorite tap (toggle the favorite status)
                              setState(() {
                                if (favoritePlantIds.contains(plant['id'])) {
                                  favoritePlantIds.remove(
                                      plant['id']); // Un-favorite the plant
                                } else {
                                  favoritePlantIds
                                      .add(plant['id']); // Favorite the plant
                                }
                              });
                            });
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to fetch plants data
  void fetchPlants() async {
    print('Fetching plants...');
    const url =
        'https://www.jsonkeeper.com/b/6Z9C'; // Replace with your actual URL
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);

    setState(() {
      enabled = !enabled;
      plants = json['data'];
      repeatedPlants = List.generate(
        itemsToRepeat,
        (index) => plants[index % plants.length],
      );
    });
    print('Fetch completed');
  }

  // Search method
  void searchPlants(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredPlants = repeatedPlants;
      } else {
        filteredPlants = repeatedPlants
            .where((plant) => plant['name'].toLowerCase().contains(query
                .toLowerCase())) // Adjust to match your plant's key for name
            .toList();
      }
    });
  }
}

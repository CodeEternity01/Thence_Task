import 'package:flutter/material.dart';

Widget freeShippingBanner() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
    child: Container(
      
      height: 100,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color.fromARGB(255, 206, 229, 248),Color.fromARGB(255, 241, 185, 181)]),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Make sure the text can flex within the available space
        
          Flexible(
            child: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'Free shipping\non orders ',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  TextSpan(
                    text: 'over \$100',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow[700], // Set yellow color for "$100"
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Wrap the Image in a Flexible to avoid overflow
          Image.asset(
            'assets/images/saly.png', // Use the local asset image
            width: 100, // Adjust the width of the image as needed
            height: 100, // Adjust the height of the image as needed
            fit: BoxFit.contain,
          ),
        ],
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ComingSoonScreen extends StatelessWidget {
  const ComingSoonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Container(
          //   color: Colors.brown.withOpacity(0.6),
          // ),
          // Overlay Text
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      'New Fashion',
                      style: GoogleFonts.merriweather(
                        fontSize: 40, // Font size
                        fontWeight: FontWeight.bold, // Font weight
                        color: Colors.black87, // Text color
                        shadows: [
                          Shadow(
                            blurRadius: 20.0,
                            color: Colors.grey,
                            offset: Offset(0.0, 10.0),
                          ),
                        ],
                      ),
                    ),
                    Image.asset(
                      'assets/images/ComingSoon2.png', // Replace with your image path
                      height: 300,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}

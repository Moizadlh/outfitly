import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:outfitly/Screens/SignUpScreen.dart';
import 'package:outfitly/Components/ZigZag.dart';


class Splashscreen extends StatefulWidget {
   const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Restart the timer whenever dependencies change (e.g., when navigating back to this screen)
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer(
      Duration(seconds: 3),
          () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignupScreen()),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel(); // Clean up the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'assets/images/SplashImage.jpg', // Keep your fashion background image
            fit: BoxFit.cover,
          ),
          // Updated Brownish Overlay with Pastel Colors
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFE6F5EA).withOpacity(1), // Mint Green with opacity
                  Color(0xFFFDE4E4).withOpacity(0.6), // Blush Pink with opacity
                ],
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Welcome",
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87, // Dark neutral for high contrast
                      letterSpacing: 2,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Experience elegance with every step.",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF4D4D4D), // Deep Gray for subtext
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Logo and Text
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App Name
                Padding(
                  padding: const EdgeInsets.only(top: 120.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: 25),
                          Text(
                            "Outfitly",
                            style: GoogleFonts.arvo(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87, // Electric Blue for boldness
                              letterSpacing: 2,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 3),
                      Text(
                        "Find Your Perfect Outfit",
                        style: GoogleFonts.caveat(
                          fontSize: 20,
                          color: Color(0xFF4D4D4D), // Soft Gray for subtitle text
                        ),
                      ),
                    ],
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

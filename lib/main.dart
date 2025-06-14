import 'package:flutter/material.dart';
import 'package:outfitly/Screens/SplashScreen.dart';


void main() {
  runApp(OutfitlyApp());
}

class OutfitlyApp extends StatelessWidget {
  final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [routeObserver],
      debugShowCheckedModeBanner: false,
      home: Splashscreen(),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/services.dart';
import 'package:outfitly/Screens/ClosetScreen.dart';
import 'package:outfitly/Screens/ComingSoonScreen.dart';
import 'package:outfitly/Screens/HomeScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outfitly/Screens/ProfileScreen.dart';
import 'package:outfitly/Screens/SocialScreen.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';

class MainLayout extends StatefulWidget {
  final int? userId;
  const MainLayout({Key? key, required this.userId}) : super(key: key);

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;
  int _page = 0;
  int ColorChangetimer = 0;
  DateTime? lastBackPressTime;
  bool isDay = true;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    // Initialize _pages using widget.userId
    _pages = [
      HomeScreen(userId: widget.userId),
      ClosetScreen(userId: widget.userId),
      SocialFeedScreen(userId: widget.userId),
      ComingSoonScreen(),
      ProfileScreen(userId: widget.userId),
    ];
  }

  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _page = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // setState(() {
        //   _page = 0; // Reset page index
        //   _selectedIndex = 0; // Reset selected index
        // });
        if (_page == 0) {
          DateTime now = DateTime.now();
          if (lastBackPressTime == null ||
              now.difference(lastBackPressTime!) > Duration(seconds: 2)) {
            lastBackPressTime = now;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Press back again to exit"),
                duration: Duration(seconds: 1),
                backgroundColor: Colors.blueGrey,
              ),
            );
            return false;
          }
          SystemNavigator.pop();
          return false;
        }
        else{
          setState(() {
              _page = 0; // Reset page index
              _selectedIndex = 0; // Reset selected index
            });
        }
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFFFFFFF).withOpacity(0.8),
          automaticallyImplyLeading: false,
          title: Text(
            'Outfitly Trends',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 26,
              color: Colors.black,
              letterSpacing: 1,
            ),
          ),
          centerTitle: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color(0xFFE0E0E0),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.notifications_active,
                    color: Colors.black,
                    size: 32,
                  ),
                  onPressed: () {
                    // Help action
                  },
                ),
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Icon(isDay ? Icons.nightlight_round : Icons.wb_sunny,),
            //     SizedBox(width: 10),
            //     Switch(
            //       value: isDay,
            //       onChanged: (value) {
            //         setState(() {
            //           isDay = value;
            //         });
            //       },
            //       activeTrackColor: Colors.yellow,
            //       inactiveTrackColor: Colors.blueGrey,
            //       activeColor: Colors.orange,
            //       inactiveThumbColor: Colors.grey,
            //     ),
            //     SizedBox(width: 10),
            //     Icon(isDay ? Icons.wb_sunny : Icons.nightlight_round , color: Colors.yellow),
            //   ],
            // ),
          ],
        ),
        backgroundColor: Colors.white,
        // bottomNavigationBar: Container(
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(15),
        //     boxShadow: [
        //       BoxShadow(
        //         color: Color(0xFF000000).withOpacity(0.8), // Dark shadow
        //         blurRadius: 45.0,
        //         offset: Offset(0, 6),
        //         spreadRadius: 15.0, // Shadow position
        //       ),],
        //   ),
        //   child: CurvedNavigationBar(
        //     key: _bottomNavigationKey,
        //     items: <Widget>[
        //       Icon(
        //         Icons.home,
        //         size: 30,
        //         color: _page == 0 ? Color(0xFF6f4f38) : Color(0xFFB0BEC5),
        //       ),
        //       Icon(
        //         Icons.favorite,
        //         size: 30,
        //         color: _page == 1 ? Color(0xFF6f4f38) : Color(0xFFB0BEC5),
        //       ),
        //       Icon(
        //         Icons.grid_view,
        //         size: 30,
        //         color: _page == 2 ? Color(0xFF6f4f38) : Color(0xFFB0BEC5),
        //       ),
        //       Icon(
        //         Icons.watch_later,
        //         size: 30,
        //         color: _page == 3 ? Color(0xFF6f4f38) : Color(0xFFB0BEC5),
        //       ),
        //       Icon(
        //         Icons.account_circle,
        //         size: 30,
        //         color: _page == 4 ? Colors.brown.shade800 : Color(0xFFB0BEC5),
        //       ),
        //     ],
        //     backgroundColor: Colors.white,
        //     height: 60,
        //     color: Color(0xFF000000).withOpacity(1),
        //     buttonBackgroundColor: Colors.brown.shade100,
        //     animationCurve: Curves.easeInOut,
        //     animationDuration: Duration(milliseconds: 600),
        //     onTap: (index) {
        //       setState(() {
        //         _page = index;
        //       });
        //     },
        //   ),
        // ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
            width:double.infinity,
            child: CrystalNavigationBar(
              currentIndex: _selectedIndex,
              indicatorColor: Colors.white,
              unselectedItemColor: Colors.white54,
              backgroundColor: Colors.black87,
              // outlineBorderColor: Colors.brown.withOpacity(01),
              onTap: _onItemTapped,
              items: [
                CrystalNavigationBarItem(
                  icon: Icons.home,
                  unselectedIcon: Icons.home_outlined,
                  selectedColor: Colors.white,
                ),
                CrystalNavigationBarItem(
                  icon: Icons.favorite,
                  unselectedIcon: Icons.favorite_outline,
                  selectedColor: Colors.white,
                ),
                CrystalNavigationBarItem(
                  icon: Icons.grid_view,
                  unselectedIcon: Icons.grid_view_outlined,
                  selectedColor: Colors.white,
                ),
                CrystalNavigationBarItem(
                    icon: Icons.watch_later,
                    unselectedIcon: Icons.watch_later_outlined,
                    selectedColor: Colors.white),
                CrystalNavigationBarItem(
                  icon: Icons.person,
                  unselectedIcon: Icons.person_outlined,
                  selectedColor: Colors.white,
                ),
              ],
            ),
          ),
        ),
        body: _pages[_page],
        extendBody: true,
      ),
    );
  }
}

import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:outfitly/AIModels/AIModel.dart';
import 'package:outfitly/Screens/CreateOutfitScreen.dart';
// import 'package:bootstrap_icons/bootstrap_icons.dart';




class HomeScreen extends StatefulWidget {
  final int? userId;
  const HomeScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  AIModel aiModel = new AIModel();

  late final List<Map<String, String>> outfits;
  List<Map<String, String>>? searchOutfits;
  final TextEditingController searchController = TextEditingController();
  String? sorted;

  final List<Map<String, dynamic>> categories = [
    {'name': 'TShirt' , 'icon': "assets/images/tshirt.png"},
    {'name': 'Pant', 'icon': "assets/images/pant.png"},
    {'name': 'Dress', 'icon': "assets/images/dress.png"},
    {'name': 'Jacket', 'icon': "assets/images/jacket.png"},
  ];

  late PageController _pageController;
  int _currentPage = 0;
  Timer? _carouselTimer;
  late Timer _timer;
  bool _isBlue = true;

  @override
  void initState() {
    super.initState();
    outfits = aiModel.GetSuggestedOutfits();
    searchOutfits = List.from(outfits);
    _pageController = PageController();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round(); // Corrected to round
      });
    });
    _startColorChange();

    // Start the carousel timer
    _carouselTimer = Timer.periodic(Duration(seconds: 4), (timer) {
      // Automatically move to the next page
      if (_currentPage < 3) { // Change this to (number of items - 1)
        _currentPage++;
      } else {
        _currentPage = 0; // Reset to the first item
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 1000), // Adjust duration as needed
        curve: Curves.easeInOut, // Smooth animation curve
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _carouselTimer?.cancel();
    _timer.cancel();
    super.dispose();
  }

  void SearchingProcess() {
    if (searchController.text.isNotEmpty) {
      // Create a new list to hold the filtered results.
      List<Map<String, String>> filteredOutfits = [];

      for (var outfit in outfits) {
        // Check if the outfit title contains the search text.
        if (outfit['title']!
            .toLowerCase()
            .contains(searchController.text.toLowerCase())) {
          // If it matches, add it to the filtered list.
          filteredOutfits.add(outfit);
        }
      }

      // Update searchOutfits with the filtered list.
      setState(() {
        searchOutfits = filteredOutfits;
        if(sorted == "Ascending"){
          sorting(true);
        }
        else if (sorted == "Descending"){
          sorting(false);
        }
      });
    } else {
      // Reset to the original list when the search is empty.
      setState(() {
        searchOutfits = List.from(outfits);
        if(sorted == "Ascending"){
          sorting(true);
        }
        else if (sorted == "Descending"){
          sorting(false);
        }
      });
    }
  }

  void sorting(bool ascending){
    if (ascending) {
      searchOutfits!.sort((a, b) => int.parse(a['price']!).compareTo(int.parse(b['price']!)));
    }
    else {
      searchOutfits!.sort((a, b) => int.parse(b['price']!).compareTo(int.parse(a['price']!)));
    }

    setState(() {
      // No need to create a new filteredOutfits list, just assign the sorted list back
      searchOutfits = searchOutfits;
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( // Wrap the main content with SingleChildScrollView
        child: Container(
          color: Color(0xFFFFFFFF).withOpacity(0.8),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Bar just under the AppBar
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search",
                          prefixIcon: Icon(Icons.search, color: Color(0xFF6f4f38).withOpacity(0.9)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                        controller: searchController,
                        style: GoogleFonts.playfairDisplay(
                          color: Color(0xFF333333),
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                        cursorColor: Colors.brown.shade600,
                        onChanged: (value) {
                          setState(() {
                            SearchingProcess();
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF6f4f38),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.tune, color: Color(0xFFFFFFFF), size: 32),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        builder: (BuildContext context) {
                          return Container(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  title: Text('Low to High Price'),
                                  onTap: () {
                                    // Handle low to high price sorting
                                    sorting(true);
                                    sorted = "Ascending";
                                    Navigator.pop(context); // Close the bottom sheet
                                  },
                                ),
                                ListTile(
                                  title: Text('High to Low Price'),
                                  onTap: () {
                                    // Handle high to low price sorting
                                    sorting(false);
                                    sorted = "Descending";
                                    Navigator.pop(context); // Close the bottom sheet
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
        ],
                ),
                SizedBox(height: 20),

                // New Collection Banner
                Column(
                  children: [
                    Container(
                      height: 180, // Set the height for the carousel
                      child: PageView(
                        controller: _pageController,
                        children: [
                          buildCarouselItem('assets/images/banner1.jpg', "Create Now"),
                          buildCarouselItem('assets/images/banner2.jpg', 'Create Now'),
                          buildCarouselItem('assets/images/banner3.jpg', 'Create Now'),
                          buildCarouselItem('assets/images/banner4.jpg', 'Create Now'),
                          // Add more items as needed
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(4, (index) {
                        return Container(
                          margin: EdgeInsets.all(4.0),
                          height: 10.0,
                          width: 10.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentPage == index ? Color(0xFF6f4f38) : Colors.grey,
                          ),
                        );
                      }),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // Category Section
                Text(
                  'Category',
                  style: GoogleFonts.robotoCondensed(
                      fontSize: 21,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF242426),
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.brown.shade200.withOpacity(0.9),
                          offset: Offset(0.0, 6),
                        ),
                      ],
                      // letterSpacing: 0.5
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: categories.map((category) {
                    return Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            // gradient: LinearGradient(
                            //   begin: Alignment.topCenter,
                            //   end: Alignment.bottomCenter,
                            //   colors: [
                            //     Colors.brown.shade200,
                            //     Colors.brown.shade200,
                            //   ],
                            // ),
                            color:Colors.brown.shade100,
                            borderRadius:BorderRadius.circular(30),
                            // boxShadow:
                          ),
                          child:CircleAvatar(
                            backgroundColor: Colors.brown.shade100, // Background color
                            radius: 30,
                            child: TweenAnimationBuilder<Color?>(
                              tween: ColorTween(
                                begin: Color(0xFF6e4e37),
                                end: _isBlue ? Colors.brown.shade700 : Color(0xFF6e4e37),
                              ),
                              duration: Duration(milliseconds: 1500), // Duration of the color change
                              curve: Curves.easeInOut, // Easing curve
                              builder: (context, color, child) {
                                return ColorFiltered(
                                  colorFilter: ColorFilter.mode(color ?? Colors.black87, BlendMode.srcIn), // Fallback color if null
                                  child: Image.asset(
                                    category['icon']!, // Use the icon path passed to the widget
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          category['name']!,
                          style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w500),
                        ),
                      ],
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),

                // Suggested Outfits Section
                Center(
                  child: Text(
                    'Suggested Outfits',
                    style: GoogleFonts.robotoCondensed(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF242426),
                      shadows: [
                        Shadow(
                          blurRadius: 20.0,
                          color: Colors.brown.shade200.withOpacity(0.9),
                          offset: Offset(0.0, 6),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8),
                // Suggested outfits list
                ListView.builder(
                  itemCount: searchOutfits!.length,
                  shrinkWrap: true, // Important: Set shrinkWrap to true
                  physics: NeverScrollableScrollPhysics(), // Disable scrolling for the ListView
                  itemBuilder: (context, index) {
                    var outfit = searchOutfits![index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 13),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: Colors.white70,
                      child: ListTile(
                        leading:
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.brown, // Choose the border color
                              width: 2.0,         // Set the width of the border
                            ),
                            borderRadius: BorderRadius.circular(8.0), // Optional: for rounded corners
                          ),
                          child: Image.asset(
                            outfit['image']!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(outfit['title']!, style: GoogleFonts.robotoCondensed(color: Colors.black,fontWeight: FontWeight.bold)),
                        subtitle: Text("${outfit['description']} || Price: ${outfit['price']}", style: GoogleFonts.playfairDisplay(color: Colors.black54,fontWeight: FontWeight.bold)),
                        // trailing:Text(outfit['description']!, style: GoogleFonts.playfairDisplay(color: Colors.black54,fontWeight: FontWeight.w600)),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCarouselItem(String imagePath, String buttonText) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.brown.shade50,
      ),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
            ),
          ),
          Positioned(
            left: 25,
            bottom: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Style Your Wardrobe,' ,style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87.withOpacity(0.9)
                ),),
                Text('Define Your Fashion!' ,style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color:Colors.black87.withOpacity(0.8)
                ),),
                SizedBox(height: 5),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF6f4f38),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: Size(40, 35),
                    maximumSize: Size(120, 35),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CreateOutfitScreen()),
                    );
                    // Add your action here
                  },
                  child: Text(buttonText, style: GoogleFonts.robotoCondensed(color: Color(0xFFFFFFFF),fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _startColorChange() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        _isBlue = !_isBlue; // Toggle the color state
      });
    });
  }
}

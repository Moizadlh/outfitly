import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_loading_border/animated_loading_border.dart';
import 'package:outfitly/DatabaseContext/DbContext.dart';
import 'package:outfitly/Models/AccessoryClothItemModel.dart';
import 'package:outfitly/Models/AthleticWearClothItemModel.dart';
import 'package:outfitly/Models/ClothingItemModel.dart';
import 'package:outfitly/Models/PostItemModel.dart';
import 'package:outfitly/Models/PostModel.dart';
import 'package:outfitly/Models/ShirtClothItemModel.dart';
import 'package:outfitly/Models/DressClothItemModel.dart';
import 'package:outfitly/Models/FootwearClothItemModel.dart';
import 'package:outfitly/Models/OutWearClothItemModel.dart';
import 'package:outfitly/Models/PantClothItemModel.dart';
import 'package:outfitly/Models/ShirtClothItemModel.dart';
import 'package:outfitly/Models/SwimWearClothItemModel.dart';
import 'package:outfitly/Models/UndergarmentsClothItemModel.dart';
import 'package:outfitly/Screens/MakePostScreen.dart';
import 'package:outfitly/Screens/MyPostScreen.dart';


class PostItem extends StatefulWidget {
  final CompletePostItemModel post;
  final bool Myposts;

  PostItem({required this.Myposts,required this.post});

  @override
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {

  DbContext? _dbContext;
  bool isLiked = false;
  bool _isExpanded = false;
  late String formattedDate;

  final Map<String,Color> _myColors =
  {'Red': Colors.red,
    'Blue': Colors.blue,
    'Green': Colors.green,
    'Black': Colors.black,
    'White': Colors.white,
    'Yellow': Colors.yellow,
    'Pink': Colors.pink,
    'Gray': Colors.grey,
    'Purple': Colors.purple,
    'Brown': Colors.brown.shade800};


  @override
  void initState() {
    super.initState();
    _dbContext = DbContext();
    var postDateTime = widget.post.PostDateTime;
    int year = postDateTime!.year;
    int month = postDateTime.month;
    int day = postDateTime.day;
    formattedDate = "${day}/${month}/${year}";
  }



  @override
  Widget build(BuildContext context) {
    final item = widget.post.Item;
    print(item);

    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 10),
        child: AnimatedLoadingBorder(
          duration: Duration(seconds: 10), // Duration of the animation
          borderColor: Colors.brown.shade600, // Border color
          borderWidth: 16, // Width of the border
          cornerRadius: 20, // Radius of the corners
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  spreadRadius: 4,
                  blurRadius: 8,
                  offset: Offset(10,12),
                ),
              ],
              border: Border.all(color: Colors.white54, width: 2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Post Header
                ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundImage:AssetImage('assets/images/profile.png') , // Replace with user image if available
                  ),
                  title: Text(widget.post.UserName ?? 'Unknown User', style: TextStyle(color: Colors.brown)),
                  subtitle: Text('Outfitly', style: TextStyle(color: Colors.brown[300])),
                  trailing: widget.Myposts ? PopupMenuButton<String>(
                    onSelected: (value) async {
                      if (value == 'Edit') {
                        PostItemModel? post = await  _dbContext!.getPostItemById(widget.post.PostId);
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MakePostScreen(
                              userId: post!.UserId,
                              item: widget.post.Item,
                              editingPost: post,
                            ),
                          ),
                        );
                        // Handle edit action
                        print('Edit pressed');
                      } else if (value == 'Delete') {
                        PostItemModel? post = await  _dbContext!.getPostItemById(widget.post.PostId);
                        _dbContext!.DeletePost(post!);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyPostScreen(userId: post.UserId),
                          ),
                        );
                        // Handle delete action
                        print('Delete pressed');
                      }
                    },
                    icon: Icon(Icons.more_vert, color: Colors.brown),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'Edit',
                        child: Text('Edit'),
                      ),
                      PopupMenuItem(
                        value: 'Delete',
                        child: Text('Delete'),
                      ),
                    ],
                  ) : null,
        ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      height: _isExpanded ? null : ((_getTextHeight(widget.post.Caption ?? "") > 70) ? 70 : null), // Height limits
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          widget.post.Caption ?? "",
                          maxLines: _isExpanded ? null : 3, // Show limited lines
                          overflow: _isExpanded ? null : TextOverflow.ellipsis, // Handle overflow
                          style: GoogleFonts.playfairDisplay(fontSize: 17),
                        ),
                      ),
                    ),
                    SizedBox(height: 4), // Space between text and button
                    if (_getTextHeight(widget.post.Caption ?? "") > 70) ...[
                      SizedBox(height: 0), // Space between text and button
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isExpanded = !_isExpanded; // Toggle expansion
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Text(
                            _isExpanded ? 'Show less' : 'Read more',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: 10,),
                // Post Image
                Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: ("White" == item!.primaryColor) ? Colors.black45 : Colors.white,
                  ),
                  child: SvgPicture.network(
                    generateIcon(item),
                    color: _myColors[item.primaryColor]
                  ),
                ),
                // Post Actions
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(item is ShirtModel || item is PantModel || item is DressModel ? item.subcategory :
                            item is SwimWearModel ? item.swimwearType :
                            item is AthleticWearModel ? item.athleticwearType:
                            item is FootwearModel ? item.footwearType :
                            item is UnderGarmentModel ? item.lingerieType:
                            item is OuterWearModel ? item.closureType:
                            item.accessoryClosure,
                              style: GoogleFonts.merriweather(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
                          Text("${item is SwimWearModel ? item.swimwearMaterial :
                          item is AthleticWearModel ? item.athleticwearMaterial:
                          item is UnderGarmentModel ? item.lingerieFabricType :
                          item is AccessoryModel ? item.accessoryMaterial:
                          item is FootwearModel ? item.footwearMaterial:
                          item.material} | ${item.primaryColor}", style: GoogleFonts.merriweather(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            (item is PantModel)?
                            "Waist: ${item.waistType}":
                            (item is AccessoryModel)?
                            "Dimensions: ${item.accessoryDimensions}":
                            "Size: ${item.size}",
                            style: GoogleFonts.merriweather(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            (item is PantModel) ? '${item.legStyle} | ${item.fit} | ${item.occasion}' :
                            (item is AccessoryModel) ? '${item.accessoryStyle} | ${item.accessoryHeaviness} | ${item.occasion}' :
                            (item is UnderGarmentModel) ? '${item.patternDetails} | ${item.waistbandStyle} | ${item.supportType}' :
                            (item is SwimWearModel) ? '${item.swimwearStrapType} | ${item.swimwearSupportType} | Swimming' :
                            (item is AthleticWearModel) ? '${item.athleticwearWaistType} | ${item.athleticwearFitType} | Athletics' :
                            (item is FootwearModel) ? '${item.toeShape} | ${item.soleType} | ${item.occasion}' :
                            '${item.pattern} | ${item.fit} | ${item.occasion}',
                            style: GoogleFonts.merriweather(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Season: ${item.season}",
                            style: GoogleFonts.merriweather(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            '${item.sustainability} | ${item.careInstructions}',
                            style: GoogleFonts.merriweather(
                              fontSize: 11,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      Divider(height: 1, color: Colors.black26),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    isLiked ? Icons.favorite : Icons.favorite_border,
                                    color: isLiked ? Colors.red : Colors.black87,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isLiked = !isLiked;
                                    });
                                  },
                                ),
                                Text('Like', style: GoogleFonts.playfairDisplay(color: Colors.black87, fontWeight: FontWeight.w600, fontSize: 16)),
                              ],
                            ),
                            Text(formattedDate, style: GoogleFonts.playfairDisplay(color: Colors.black87, fontWeight: FontWeight.w600, fontSize: 16))
                            // IconButton(onPressed: (){}, icon: Icon(Icons.menu))
                            // Row(
                            //   children: [
                            //     Icon(Icons.comment, color: Colors.brown),
                            //     SizedBox(width: 8),
                            //     Text('Comments', style: TextStyle(color: Colors.brown)),
                            //   ],
                            // ),
                            // Icon(Icons.share, color: Colors.brown),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double _getTextHeight(String text) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: GoogleFonts.playfairDisplay(fontSize: 17)),
      // maxLines: 3, // Limit to 3 lines
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(maxWidth: (MediaQuery.of(context).size.width)-60); // Calculate width
    // print((MediaQuery.of(context).size.width)-200);
    // print(textPainter.size.height);
    return textPainter.size.height; // Return height
  }

  String generateIcon(dynamic item) {
    String itemType;
    if(item is ShirtModel || item is PantModel || item is DressModel){
      itemType = item.subcategory ?? "";
    }
    else{
      itemType = "";
    }
    String color = item . primaryColor;
    // print(itemType + color);
    String iconSvg;

    // if(item.category == 'Shirt' || item.category == 'Pant' ||
    //     item.category == 'Dress' || item.category == 'Skirt'){
    //   itemType = item.subcategory ?? "";
    // }
    // else{
    //   itemType = item.category;
    // }
    switch (itemType) {
      case 'T_Shirt':
        if(!(item.hasPockets)){
          iconSvg = 'https://www.svgrepo.com/show/4454/t-shirt.svg';
        }
        else{
          iconSvg = 'https://www.svgrepo.com/show/127530/tshirt-with-pocket.svg';
        }
        break;

      case 'Full Sleeve':
        if(!(item.hasPockets)){
          iconSvg = 'https://www.svgrepo.com/show/482554/y-shirt-6.svg';
        }
        else{
          iconSvg = 'https://www.svgrepo.com/show/275032/shirt.svg';
        }
        break;

      case 'Half Sleeve':
        if(!(item.hasPockets)){
          iconSvg = 'https://www.svgrepo.com/show/275017/shirt.svg';
        }
        else{
          iconSvg = 'https://www.svgrepo.com/show/275019/shirt.svg';
        }
        break;

      case 'Polo':
        if(!(item.hasPockets)){
          iconSvg = 'https://www.svgrepo.com/show/506962/clo-polo.svg';
        }
        else{
          iconSvg = 'https://www.svgrepo.com/show/507016/clo-polo.svg';
        }
        break;

      case 'Button-Down':
        if(!(item.hasPockets)){
          iconSvg = 'https://www.svgrepo.com/show/297933/shirt.svg';
        }
        else{
          iconSvg = 'https://www.svgrepo.com/show/346341/shirt-fill.svg';
        }
        break;

      case 'Blouse':
        if(!(item.hasPockets)){
          iconSvg = 'https://www.svgrepo.com/show/128688/blouse.svg';
        }
        else{
          iconSvg = 'https://www.svgrepo.com/show/128688/blouse.svg';
        }
        break;

      case 'Tank Top':
        if(!(item.hasPockets)){
          iconSvg = 'https://www.svgrepo.com/show/323430/tank-top.svg';
        }
        else{
          iconSvg = 'https://www.svgrepo.com/show/323430/tank-top.svg';
        }
        break;

      case 'Jeans':
        if(!(item.hasPockets)){
          iconSvg = 'https://www.svgrepo.com/show/275023/jeans-garment.svg';
        }
        else{
          iconSvg = 'https://www.svgrepo.com/show/275018/jeans.svg';
        }
        break;

      case 'Cargo':
        if(!(item.hasPockets)){
          iconSvg = 'https://www.svgrepo.com/show/260982/pants.svg';
        }
        else{
          iconSvg = 'https://www.svgrepo.com/show/275005/jeans-pants.svg';
        }
        break;

      case 'Trousers':
        if(!(item.hasPockets)){
          iconSvg = 'https://www.svgrepo.com/show/274925/trousers.svg';
        }
        else{
          iconSvg = 'https://www.svgrepo.com/show/275004/trousers.svg';
        }
        break;

      case 'Sweatpants':
        if(!(item.hasPockets)){
          iconSvg = 'https://www.svgrepo.com/show/274929/trousers-pants.svg';
        }
        else{
          iconSvg = 'https://www.svgrepo.com/show/275007/trousers-pants.svg';
        }
        break;

      case 'Leggings':
        if(!(item.hasPockets)){
          iconSvg = 'https://www.svgrepo.com/show/278189/trousers-pants.svg';
        }
        else{
          iconSvg = 'https://www.svgrepo.com/show/278189/trousers-pants.svg';
        }
        break;

      case 'Shorts':
        if(!(item.hasPockets)){
          iconSvg = 'https://www.svgrepo.com/show/513346/shorts.svg';
        }
        else{
          iconSvg = 'https://www.svgrepo.com/show/513248/shorts.svg';
        }
        break;

      case 'Casual Dress':
        if(!(item.hasPockets)){
          iconSvg = 'https://www.svgrepo.com/show/308544/dress-clothes-gown.svg';
        }
        else{
          iconSvg = 'https://www.svgrepo.com/show/308544/dress-clothes-gown.svg';
        }
        break;

      case 'Formal Dress':
        if(!(item.hasPockets)){
          iconSvg = 'https://www.svgrepo.com/show/320091/dress.svg';
        }
        else{
          iconSvg = 'https://www.svgrepo.com/show/320091/dress.svg';
        }
        break;

      case 'Maxi':
        if(!(item.hasPockets)){
          iconSvg = 'https://www.svgrepo.com/show/409424/dress-3.svg';
        }
        else{
          iconSvg = 'https://www.svgrepo.com/show/409424/dress-3.svg';
        }
        break;

      case 'Midi':
        if(!(item.hasPockets)){
          iconSvg = 'https://www.svgrepo.com/show/482607/dress-3.svg';
        }
        else{
          iconSvg = 'https://www.svgrepo.com/show/482607/dress-3.svg';
        }
        break;

      case 'Cocktail Dress':
        iconSvg = '''
        <svg xmlns="http://www.w3.org/2000/svg" width="50" height="70">
          <rect width="50" height="70" fill="#D2B48C"/> <!-- Light brown background -->
          <path d="M10 10 H40 L35 40 H15 Z" fill="$color"/> <!-- Cocktail Dress shape -->
          <path d="M10 40 Q25 60 40 40 Z" fill="$color"/> <!-- Cocktail Dress Bottom -->
        </svg>
      ''';
        break;

      case 'Sundress':
        iconSvg = '''
        <svg xmlns="http://www.w3.org/2000/svg" width="50" height="70">
          <rect width="50" height="70" fill="#D2B48C"/> <!-- Light brown background -->
          <path d="M10 10 H40 L35 40 H15 Z" fill="$color"/> <!-- Sundress shape -->
          <path d="M10 40 Q25 60 40 40 Z" fill="$color"/> <!-- Sundress Bottom -->
        </svg>
      ''';
        break;

      case 'Mini Skirt':
        iconSvg = '''
        <svg xmlns="http://www.w3.org/2000/svg" width="50" height="30">
          <rect width="50" height="30" fill="#D2B48C"/> <!-- Light brown background -->
          <path d="M10 0 H40 L35 30 H15 Z" fill="$color"/> <!-- Mini Skirt shape -->
        </svg>
      ''';
        break;

      case 'Midi Skirt':
        iconSvg = '''
        <svg xmlns="http://www.w3.org/2000/svg" width="50" height="40">
          <rect width="50" height="40" fill="#D2B48C"/> <!-- Light brown background -->
          <path d="M10 0 H40 L35 40 H15 Z" fill="$color"/> <!-- Midi Skirt shape -->
        </svg>
      ''';
        break;

      case 'Maxi Skirt':
        iconSvg = '''
        <svg xmlns="http://www.w3.org/2000/svg" width="50" height="60">
          <rect width="50" height="60" fill="#D2B48C"/> <!-- Light brown background -->
          <path d="M10 0 H40 L35 60 H15 Z" fill="$color"/> <!-- Maxi Skirt shape -->
        </svg>
      ''';
        break;

      case 'Pencil Skirt':
        iconSvg = '''
        <svg xmlns="http://www.w3.org/2000/svg" width="50" height="50">
          <rect width="50" height="50" fill="#D2B48C"/> <!-- Light brown background -->
          <path d="M10 0 H40 L35 50 H15 Z" fill="$color"/> <!-- Pencil Skirt shape -->
        </svg>
      ''';
        break;

      case 'A-Line Skirt':
        iconSvg = '''
        <svg xmlns="http://www.w3.org/2000/svg" width="50" height="50">
          <rect width="50" height="50" fill="#D2B48C"/> <!-- Light brown background -->
          <path d="M10 0 H40 L35 50 H15 Z" fill="$color"/> <!-- A-Line Skirt shape -->
        </svg>
      ''';
        break;

      case 'Jacket':
        iconSvg = '''
        <svg xmlns="http://www.w3.org/2000/svg" width="50" height="50">
          // <rect width="100" height="100" fill="#D2B48C"/> <!-- Light brown background -->
          <path d="M10 10 H40 L35 40 H15 Z" fill="$color"/> <!-- Jacket shape -->
          <path d="M5 10 L15 0 L15 10 Z" fill="$color"/> <!-- Left Sleeve -->
          <path d="M35 10 L45 0 L45 10 Z" fill="$color"/> <!-- Right Sleeve -->
        </svg>
      ''';
        break;

      default:
        iconSvg ="https://www.svgrepo.com/show/163823/landscape-photo.svg";
        break;
    }

    return iconSvg;
  }

}

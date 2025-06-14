import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_loading_border/animated_loading_border.dart';
import 'package:outfitly/DatabaseContext/DbContext.dart';
import 'package:outfitly/Models/ClothingItemModel.dart';
import 'package:outfitly/Models/PostItemModel.dart';
import 'package:outfitly/Models/PostModel.dart';
import 'package:outfitly/Models/UsersModel.dart';
import 'package:outfitly/Screens/HomeScreen.dart';
import 'package:outfitly/Screens/PostItem.dart';

class MyPostScreen extends StatefulWidget {
  final int? userId;
  const MyPostScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _MyPostScreenState createState() => _MyPostScreenState();
}

class _MyPostScreenState extends State<MyPostScreen> {

  DbContext? _dbContext;
  // Sample list of posts
  List<CompletePostItemModel> posts = [];

  @override
  void initState() {
    super.initState();
    _dbContext = DbContext();
    LoadData();
  }

  Future<void> LoadData() async {
    try {
      if (_dbContext == null) {
        throw Exception("DbContext is not initialized");
      }
      List<PostItemModel> allItems = await _dbContext!.GetAllPosts();
      for (var item in allItems){
        if(item.UserId == widget.userId){
          dynamic clothingItem;
          if(item.shirtId != null){
            clothingItem = await _dbContext!.getShirtItemById(item.shirtId);
          }
          else if(item.pantId  != null){
            clothingItem = await _dbContext!.getPantsItemById(item.pantId);
          }
          else if(item.dressId != null){
            clothingItem = await _dbContext!.getDressItemById(item.dressId);
          }
          else if(item.outerwearId != null){
            clothingItem = await _dbContext!.getOuterwearItemById(item.outerwearId);
          }
          else if(item.AccessoryId != null){
            clothingItem = await _dbContext!.getAccessoryItemById(item.AccessoryId);
          }
          else if(item.undergarmentId != null){
            clothingItem = await _dbContext!.getUnderGarmentItemById(item.undergarmentId);
          }
          else if(item.swimWearId != null){
            clothingItem = await _dbContext!.getSwimWearItemById(item.swimWearId);
          }
          else if(item.athleticWearId != null){
            clothingItem = await _dbContext!.getAthleticWearItemById(item.athleticWearId);
          }
          else if(item.footWearId != null){
            clothingItem = await _dbContext!.getFootwearItemById(item.footWearId);
          }
          print(clothingItem);
          if((item.IsUnknownPost)){
            posts.add(CompletePostItemModel(PostId: item.postId,UserName: "Unknown", Item: clothingItem, Caption: item.ScreenCaption, PostDateTime: item.postDateTime));
          }
          else{
            UsersModel? user = await _dbContext!.getUserById(item.UserId);
            posts.add(CompletePostItemModel(PostId: item.postId,UserName: user?.FullName, Item: clothingItem, Caption: item.ScreenCaption, PostDateTime: item.postDateTime));
          }
        }
      }
      // _closetItems = await _dbContext!.getAllClothingItems();
    } catch (e) {
      print("Error loading data: $e");
      posts = []; // Set to an empty list in case of error
    } finally {
      setState(() {}); // Update the UI regardless of success or error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text("My Posts",style: TextStyle(color: Colors.white),),
      ),
      body: ListView(
        children: [
          // Stories Section
          // SizedBox(
          //   height: 105,
          //   child: ListView(
          //     scrollDirection: Axis.horizontal,
          //     padding: const EdgeInsets.all(8.0),
          //     children: List.generate(6, (index) => _buildStoryItem()),
          //   ),
          // ),
          // Divider(height: 1, color: Colors.brown),
          SizedBox(height: 20,),
          // Posts Section
          Column(
            children: posts.map((post) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: PostItem(post: post , Myposts: true,),
            )).toList(),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }

  // Function to build the story items
  Widget _buildStoryItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.brown.shade100,
            child: SvgPicture.network(
              "https://www.svgrepo.com/show/275019/shirt.svg",
              color: Colors.blue,
              height: 40,
              width: 40,
              semanticsLabel: 'Shirt Icon', // Optional: provides a label for accessibility
            ), // Dummy image
          ),
          SizedBox(height: 6),
          Text('Jane', style: TextStyle(color: Colors.brown)),
        ],
      ),
    );
  }
}

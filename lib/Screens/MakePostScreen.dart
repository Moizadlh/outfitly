import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outfitly/DatabaseContext/DbContext.dart';
import 'package:outfitly/Models/AccessoryClothItemModel.dart';
import 'package:outfitly/Models/AthleticWearClothItemModel.dart';
import 'package:outfitly/Models/DressClothItemModel.dart';
import 'package:outfitly/Models/FootwearClothItemModel.dart';
import 'package:outfitly/Models/OutWearClothItemModel.dart';
import 'package:outfitly/Models/PantClothItemModel.dart';
import 'package:outfitly/Models/PostModel.dart';
import 'package:outfitly/Models/ShirtClothItemModel.dart';
import 'package:outfitly/Models/SwimWearClothItemModel.dart';
import 'package:outfitly/Models/UndergarmentsClothItemModel.dart';
import 'package:outfitly/Screens/MyPostScreen.dart';

class MakePostScreen extends StatefulWidget {
  final int? userId;
  final dynamic item;
  final PostItemModel? editingPost;
  const MakePostScreen({Key? key, this.editingPost ,required this.userId , required this.item,}) : super(key: key);

  @override
  _MakePostScreenState createState() => _MakePostScreenState();
}

class _MakePostScreenState extends State<MakePostScreen> {
  DbContext? _dbContext;
  bool _isUnknownPost = false;
  final TextEditingController _captionController = TextEditingController();

  @override
  void dispose() {
    _captionController.dispose(); // Dispose the controller when the widget is removed
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _dbContext = DbContext();
    initializingItem();
  }

  void initializingItem(){
    if(widget.editingPost != null){
      _captionController.text = widget.editingPost!.ScreenCaption ?? "";
      _isUnknownPost = widget.editingPost!.IsUnknownPost;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade100,
      appBar: AppBar(
        backgroundColor: Colors.brown.shade200,
        title: Text(
          "Make Post",
          style: GoogleFonts.merriweather(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.brown.shade700,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _captionController, // Use the controller for the TextField
              maxLines: 6,
              style: TextStyle(color: Colors.brown.shade600),
              cursorColor: Colors.brown[800],
              decoration: InputDecoration(
                hintText: 'Write a caption...',
                hintStyle: TextStyle(color: Colors.brown.shade600),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.brown.shade900),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.brown.shade700, width: 2.0),
                ),
              ),
            ),
            SizedBox(height: 16),

            // Radio buttons for "Is Unknown Post"
            Text(
              'Is Unknown Post?',
              style: TextStyle(
                color: Colors.brown.shade700,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<bool>(
                    title: Text('Yes'),
                    value: true,
                    groupValue: _isUnknownPost,
                    onChanged: (value) {
                      setState(() {
                        _isUnknownPost = value!;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<bool>(
                    title: Text('No'),
                    value: false,
                    groupValue: _isUnknownPost,
                    onChanged: (value) {
                      setState(() {
                        _isUnknownPost = value!;
                      });
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Add your post submission logic here
                String caption = _captionController.text;
                print("Caption: $caption, Is Unknown Post: $_isUnknownPost");
                DateTime? Nowdatetime = DateTime.now();
                PostItemModel post = new PostItemModel(IsUnknownPost: _isUnknownPost,ScreenCaption: caption,UserId: widget.userId,postDateTime: Nowdatetime,Likes: widget.editingPost == null ? 0 : widget.editingPost!.Likes);
                if(widget.item is ShirtModel){
                 post.shirtId = widget.item.id;
                }
                else if(widget.item is PantModel){
                  post.pantId = widget.item.id;
                }
                else if(widget.item is DressModel){
                  post.dressId = widget.item.id;
                }
                else if(widget.item is OuterWearModel){
                  post.outerwearId = widget.item.id;
                }
                else if(widget.item is AccessoryModel){
                  post.AccessoryId = widget.item.id;
                }
                else if(widget.item is UnderGarmentModel){
                  post.undergarmentId = widget.item.id;
                }
                else if(widget.item is SwimWearModel){
                  post.swimWearId = widget.item.id;
                }
                else if(widget.item is AthleticWearModel){
                  post.athleticWearId = widget.item.id;
                }
                else if(widget.item is FootwearModel){
                  post.footWearId = widget.item.id;
                }

                if (widget.editingPost == null){
                  _dbContext!.InsertPost(post);
                  Navigator.pop(context);
                }
                else{
                  post.postId = widget.editingPost!.postId;
                  _dbContext!.UpdatePost(post);
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => MyPostScreen(userId: widget.userId)));
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown.shade700,
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Center(
                child: Text(
                  widget.editingPost==null ? 'Post' : 'Edit Post' ,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

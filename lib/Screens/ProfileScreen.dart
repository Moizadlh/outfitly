import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:outfitly/DatabaseContext/DbContext.dart';
import 'package:outfitly/Models/UsersModel.dart';
import 'package:outfitly/Screens/EditProfileScreen.dart';
import 'package:outfitly/Screens/MyPostScreen.dart';
import 'package:outfitly/Screens/SignInScreen.dart';
import 'package:outfitly/Screens/SignUpScreen.dart';

class ProfileScreen extends StatefulWidget {
  final int? userId;
  const ProfileScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UsersModel? User;
  DbContext? _dbContext;

  String userName = 'Jone Doe';
  String userEmail = 'JohnDoe@example.com';


  @override
  void initState() {
    super.initState();
    _dbContext = DbContext();
    LoadUser();
  }

  Future<void> LoadUser() async{
    try {
      if (_dbContext == null) {
        throw Exception("DbContext is not initialized");
      }
      User = await _dbContext!.getUserById(widget.userId); // Assign the fetched user
    } catch (e) {
      print("Error loading data: $e");
    } finally {
      setState(() {}); // Refresh the UI after loading the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Dark background
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 15),
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/images/personal.png'), // Replace with your image URL
                ),
                SizedBox(height: 16),
                // Text(
                //   User!.FullName ?? "",
                //   style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                // ),
                User == null // Check if user is null
                    ? Center(child: CircularProgressIndicator()) // Show loading indicator
                    : Center(
                  child: Text('${User?.FullName ?? ""}',style: GoogleFonts.playfairDisplay(color: Colors.black87, fontSize: 22, fontWeight: FontWeight.bold , letterSpacing: 1.5,
                    shadows: [
                    Shadow(
                    blurRadius: 10.0,
                    color: Colors.brown.shade200.withOpacity(0.9),
                    offset: Offset(0.0, 6),
                  ),
                    ],)), // Use null-aware operator
                ),
                User == null // Check if user is null
                    ? Center(child: CircularProgressIndicator()) // Show loading indicator
                    : Center(
                  child: Text('${User?.Email ?? ""}',style: GoogleFonts.playfairDisplay(color: Colors.black87, fontSize: 18, fontStyle: FontStyle.italic,letterSpacing: 1.5,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.brown.shade200.withOpacity(0.9),
                        offset: Offset(0.0, 6),
                      ),
                    ],
                  ),), // Use null-aware operator
                ),
                // Text(
                //   User!.Email ?? "",
                //   style: TextStyle(color: Colors.white70, fontSize: 16),
                // ),
                SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfilePage(
                          user: User!, // Ensure 'User' is the actual UsersModel instance
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87, // Gold color for button
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  ),
                  icon: Icon(Icons.edit_note,color: Colors.white,size: 20,),
                  label: Text('Edit Profile',style: TextStyle(color: Colors.white),),
                ),
                SizedBox(height: 10,),
                Divider(color: Colors.black26,height: 1,),
                Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildMenuItem('Change Password',Icons.lock_reset),
                        SizedBox(height: 15,),
                        _buildMenuItem('My Posts',Icons.upload_file_sharp),
                        SizedBox(height: 15,),
                        _buildMenuItem('Information',Icons.info),
                        SizedBox(height: 20,),
                        Divider(color: Colors.black26,height: 1,),
                        SizedBox(height: 20,),
                        _buildMenuItem('Delete Account',Icons.delete,isRed: true),
                        SizedBox(height: 15,),
                        _buildMenuItem('Logout',Icons.logout,isLogout: true),
                        SizedBox(height: 70,),
                      ],
                    ),
                  ),
                ),
              ],
            ),
        
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(String title, IconData icon, {bool isLogout = false , bool isRed = false}) {
    return GestureDetector(
      onTap: () {
        if (isLogout) {
          Navigator.push(context , MaterialPageRoute(builder: (context) => SigninScreen()));
          print('Logout tapped');
        } else {
          // Handle other menu actions
          print('$title tapped');
          if(title == 'Information'){
            showInfoDialog(context);
          }
          if(title == 'Delete Account'){
            showDeleteDialog(context);
          }
          if(title == 'Change Password'){
            showPasswordDialog(context);
          }
          if(title == 'My Posts'){
            // showPasswordDialog(context);
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => MyPostScreen(userId: widget.userId)));
          }
        }
      },
      // Ensure that the entire row responds to the gesture
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(30),
        ),
        // padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16), // Add padding for better touch area
        child: Row(
          children: [
            Container(
              height: 45,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.black45,
              ),
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.merriweather(
                    color: isRed ? Colors.red : Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.black38,
                ),
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete this Account?'),
          actions: [
            TextButton(
              onPressed: () {
                // Add your delete logic here
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupScreen()),);
                _dbContext!.DeleteUser(User!);
                // Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Delete'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Info'),
          content: Text('This App is for your Virtual wardrobe.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  void showPasswordDialog(BuildContext context) {
    TextEditingController passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey, // Light brown background
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // Rounded corners
          ),
          title: Text(
            'Enter Previous Password',
            style: TextStyle(
              color: Colors.white, // Darker brown for title
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Container(
            width: double.maxFinite, // Full width for content
            child: TextField(
              controller: passwordController,
              style: GoogleFonts.playfairDisplay(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
              obscureText: false, // Hides the password input
              decoration: InputDecoration(
                labelText: 'Previous Password',
                labelStyle: TextStyle(color: Colors.white), // Label color
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black87), // Focused border color
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black54), // Normal border color
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cancel button
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.white), // Cancel button text color
              ),
            ),
            ElevatedButton(
              onPressed: () {
                String previousPassword = passwordController.text;
                // Handle the previous password input
                if (previousPassword.isNotEmpty) {
                  // You can process the password here
                  print('Previous Password: $previousPassword');
                  if(previousPassword == User!.LoginPassword){
                    Navigator.of(context).pop();
                    NewPasswordDialog(context);
                  }
                  else{
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Center(child: Text('INVALID PASSWORD')),
                        duration: Duration(seconds: 3), // The duration for which the SnackBar will be visible
                        backgroundColor: Color(0xFFFF6B6B), // Optional: Set a background color for the error message
                      ),
                    );
                  }
                }
                // Proceed button
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // Button background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded button corners
                ),
              ),
              child: Text('Proceed',style: TextStyle(color: Colors.black54),),
            ),
          ],
        );
      },
    );
  }


  void NewPasswordDialog(BuildContext context) {
    TextEditingController passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey, // Light brown background
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // Rounded corners
          ),
          title: Text(
            'Enter New Password',
            style: TextStyle(
              color: Colors.white, // Darker brown for title
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Container(
            width: double.maxFinite, // Full width for content
            child: TextField(
              controller: passwordController,
              style: GoogleFonts.playfairDisplay(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
              obscureText: false, // Hides the password input
              decoration: InputDecoration(
                labelText: 'New Password',
                labelStyle: TextStyle(color: Colors.white), // Label color
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black87), // Focused border color
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black54), // Normal border color
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cancel button
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.white), // Cancel button text color
              ),
            ),
            ElevatedButton(
              onPressed: () {
                String newPassword = passwordController.text;
                // Handle the previous password input
                if (newPassword.length >= 8){
                  User!.LoginPassword = newPassword;
                  _dbContext!.UpdateUser(User!);
                  Navigator.of(context).pop();
                }
                else{
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Center(child: Text('INVALID PASSWORD length')),
                      duration: Duration(seconds: 3), // The duration for which the SnackBar will be visible
                      backgroundColor: Color(0xFFFF6B6B), // Optional: Set a background color for the error message
                    ),
                  );
                }
                // Proceed button
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // Button background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded button corners
                ),
              ),
              child: Text('Proceed',style: TextStyle(color: Colors.black54),),
            ),
          ],
        );
      },
    );
  }
}
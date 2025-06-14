import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outfitly/Models/UsersModel.dart';
import 'package:outfitly/Screens/HomeScreen.dart';
import 'package:outfitly/Screens/MainLayout.dart';
import 'package:outfitly/Screens/SignInScreen.dart';
import 'dart:math';
import '../DatabaseContext/DbContext.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  DbContext? _dbContext;
  // late Future<List<UsersModel>> UserModels;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool IsEmailValid = true;
  bool IsNameValid = true;
  bool IsPasswordValid = true;
  bool IsConfirmPasswordValid = true;
  bool IsPasswordShow = false;
  bool IsConfirmPasswordShow = false;

  @override
  void initState() {
    super.initState();
    _dbContext = DbContext();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'assets/images/SplashImage.jpg', // Your background image
            fit: BoxFit.cover,
          ),
          //Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFE6F5EA).withOpacity(1), // Mint Green with opacity
                  Color(0xFFFDE4E4).withOpacity(0.7), // Blush Pink with opacity
                ],
              ),
              // boxShadow: [
              //     BoxShadow(
              //     color: Color(0xFFE6F5EA).withOpacity(1),
              //     blurRadius: 15.0,
              //     offset: Offset(0, 6), // Shadow position
              //   ),],
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Spacer(),
                  // Title
                  SizedBox(height: 100),
                  Text(
                    "Register",
                    style: GoogleFonts.arvo(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4D4D4D),
                      letterSpacing: 2,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.brown.shade200.withOpacity(0.9),
                          offset: Offset(0.0, 6),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
            
                  // Name Input
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF9F7F3).withOpacity(0.7),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: nameController,
                          style: GoogleFonts.playfairDisplay(
                            color: Color(0xFF333333),
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                          cursorColor: Colors.brown.shade600,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person, color: Colors.brown.shade600),
                            suffixIcon: Icon(IsNameValid ? Icons.check_circle : Icons.error, color: Colors.brown.shade600),
                            labelText: 'Name',
                            labelStyle: TextStyle(
                              color: Color(0xFFA1A1A1),
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                          ),
                          onChanged: (value) {
                            setState(() {
                              if (value.isNotEmpty) {
                                IsNameValid = IsValidName(value); // Name validation logic
                              } else {
                                IsNameValid = true;
                              }
                            });
                          },
                        ),
                        if (!IsNameValid)
                          Padding(
                            padding: EdgeInsets.only(left: 20), // Move error text 20 units right
                            child: Text(
                              'Invalid name',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
            
                  // Email Input
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF9F7F3).withOpacity(0.7),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,  // Align children to start
                      children: [
                        TextField(
                          controller: emailController,
                          style: GoogleFonts.playfairDisplay(
                            color: Color(0xFF333333),
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                          cursorColor: Colors.brown.shade600,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email, color: Colors.brown.shade600),
                            suffixIcon: Icon(
                              IsEmailValid ? Icons.check_circle : Icons.error,
                              color: Colors.brown.shade600,
                            ),
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              color: Color(0xFFA1A1A1),
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                            errorText: null, // Manually handle the error text outside
                          ),
                          onChanged: (value) {
                            setState(() {
                              if (value != "") {
                                IsEmailValid = isValidEmail(value);
                              } else {
                                IsEmailValid = true;
                              }
                            });
                          },
                        ),
                        if (!IsEmailValid)
                          Padding(
                            padding: EdgeInsets.only(left: 40), // Move the error text 40 units to the right
                            child: Text(
                              'Invalid email',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
            
                  // Password Input
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF9F7F3).withOpacity(0.7),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Column(
                      children: [
                        TextField(
                          controller: passwordController,
                          obscureText: IsPasswordShow ? false : true,
                          style: GoogleFonts.playfairDisplay(color: Color(0xFF333333),fontWeight: FontWeight.w600,fontSize: 18),
                          cursorColor: Colors.brown.shade600,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock, color: Colors.brown.shade600),
                            suffixIcon: IconButton(icon: Icon(IsPasswordShow ? BootstrapIcons.eye_fill : BootstrapIcons.eye_slash_fill, color: Colors.brown.shade600),onPressed: (){setState(() {IsPasswordShow = !IsPasswordShow;});},),
                            labelText: 'password',
                            labelStyle: TextStyle(color: Color(0xFFA1A1A1),fontWeight: FontWeight.w500,fontSize: 14),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                            errorText: null,
                          ),
                          onChanged: (value) {
                            setState(() {
                              if(value != ""){
                                IsPasswordValid = IsValidPassword(value);
                              }
                              else{
                                IsPasswordValid = true;
                              }
                            });
                          },
                        ),
                        if (!IsPasswordValid)
                          Padding(
                            padding: EdgeInsets.only(left: 0), // Move the error text 40 units to the right
                            child: Text(
                              'Password must be 8 character long',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 10,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
            
                  // Confirm Password Input
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF9F7F3).withOpacity(0.7),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Column(
                      children: [
                        TextField(
                          controller: confirmPasswordController,
                          obscureText: IsConfirmPasswordShow ? false : true,
                          style: GoogleFonts.playfairDisplay(color: Color(0xFF333333),fontWeight: FontWeight.w600,fontSize: 18),
                          cursorColor: Colors.brown.shade600,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock, color: Colors.brown.shade600),
                            suffixIcon: IconButton(icon: Icon(IsConfirmPasswordShow ? BootstrapIcons.eye_fill : BootstrapIcons.eye_slash_fill, color: Colors.brown.shade600),onPressed: (){setState(() {IsConfirmPasswordShow = !IsConfirmPasswordShow;});},),
                            labelText: 'Confirm Password',
                            labelStyle: TextStyle(color: Color(0xFFA1A1A1),fontWeight: FontWeight.w500,fontSize: 14),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                            errorText: null,
                          ),
                          onChanged: (value) {
                            setState(() {
                              if(value != ""){
                                IsConfirmPasswordValid = IsValidConfirmPassword(value,passwordController.text);
                              }
                              else{
                                IsConfirmPasswordValid = true;
                              }
                            });
                          },
                        ),
                        if (!IsConfirmPasswordValid)
                          Padding(
                            padding: EdgeInsets.only(left: 0), // Move the error text 40 units to the right
                            child: Text(
                              'Password mismmatch',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 10,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
            
                  // Sign Up Button
                  ElevatedButton(
                    onPressed: () async {
                      String name = nameController.text;
                      String email = emailController.text;
                      String password = passwordController.text;
                      String confirmPassword = confirmPasswordController.text;
                      if (name.isNotEmpty &&
                          email.isNotEmpty &&
                          password.isNotEmpty &&
                          confirmPassword.isNotEmpty &&
                          isValidEmail(email)) {
                        // Code when all fields are non-empty and email is valid
                        if(password.length >= 8){
                          if(password == confirmPassword){
                            if(await IsEmailNotDuplicate(email)){
                              Random random = Random();
                              int randomNumber = 100000 + random.nextInt(900000);
                              _dbContext!.InsertUser(UsersModel(
                                  UserId : randomNumber,
                                  FullName : name,
                                  Email : email,
                                  LoginPassword : password));
            
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => MainLayout(userId: randomNumber)));
                              nameController.clear();
                              emailController.clear();
                              passwordController.clear();
                              confirmPasswordController.clear();
                            }
                            else{
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Center(child: Text('Already Registered Please SignIn')),
                                  duration: Duration(seconds: 2), // The duration for which the SnackBar will be visible
                                  backgroundColor: Color(0xFFFF6B6B), // Optional: Set a background color for the error message
                                ),
                              );
                            }
                          }
                          else{
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Center(child: Text('Passwords not matched')),
                                duration: Duration(seconds: 3), // The duration for which the SnackBar will be visible
                                backgroundColor: Color(0xFFFF6B6B), // Optional: Set a background color for the error message
                              ),
                            );
                          }
                        }
                        else{
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Center(child: Text('Password should be 8 character long')),
                              duration: Duration(seconds: 3), // The duration for which the SnackBar will be visible
                              backgroundColor: Color(0xFFFF6B6B), // Optional: Set a background color for the error message
                            ),
                          );
                        }
                      }
                      else{
                        if(name.isEmpty){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Center(child: Text('Enter Full Name')),
                              duration: Duration(seconds: 3), // The duration for which the SnackBar will be visible
                              backgroundColor: Color(0xFFFF6B6B), // Optional: Set a background color for the error message
                            ),
                          );
                        }
                        else if(email.isEmpty){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Center(child: Text('Enter your Email')),
                              duration: Duration(seconds: 3), // The duration for which the SnackBar will be visible
                              backgroundColor: Color(0xFFFF6B6B), // Optional: Set a background color for the error message
                            ),
                          );
                        }
                        else if(password.isEmpty){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Center(child: Text('Enter secure password')),
                              duration: Duration(seconds: 3), // The duration for which the SnackBar will be visible
                              backgroundColor: Color(0xFFFF6B6B), // Optional: Set a background color for the error message
                            ),
                          );
                        }
                        else if(confirmPassword.isEmpty){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Center(child: Text('Confirm Your password')),
                              duration: Duration(seconds: 3), // The duration for which the SnackBar will be visible
                              backgroundColor: Color(0xFFFF6B6B), // Optional: Set a background color for the error message
                            ),
                          );
                        }
                        else if (!(isValidEmail(email))) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Center(child: Text('INVALID EMAIL Detected')),
                              duration: Duration(seconds: 3), // The duration for which the SnackBar will be visible
                              backgroundColor: Color(0xFFFF6B6B), // Optional: Set a background color for the error message
                            ),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 60),
                      backgroundColor: Colors.brown.shade700,
                      shape: CircleBorder(),
                    ),
                    child: Icon(
                      Icons.arrow_forward,
                      color: Color(0xFFFFFFFF),
                      size: 30,
                    ),
                  ),
                  SizedBox(height: 100),
                  // Spacer(),
                  // Sign In Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: GoogleFonts.playfairDisplay(color: Color(0xFF333333),fontSize: 16,fontWeight: FontWeight.w600),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigate to Sign In screen
                          Navigator.push(context , MaterialPageRoute(builder: (context) => SigninScreen()));
                        },
                        child: Text(
                          "Sign In",
                          style: GoogleFonts.playfairDisplay(
                            color: Colors.brown.shade600,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.brown.shade700,
                            decorationThickness: 3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isValidEmail(String email) {
    // This regex checks for a basic email structure (letters, @, domain, etc.)
    String pattern = r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  bool IsValidName(String name){
    if(name.isEmpty){
      return false;
    }
    if (name.length < 3) {
      return false;
    }
    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(name)) {
      return false;
    }
    return true;
  }

  bool IsValidPassword(String password){
    if(password.isEmpty){
      return false;
    }
    if (password.length < 8) {
      return false;
    }
    return true;
  }

  bool IsValidConfirmPassword(String confirmPassword,String password){
    if(confirmPassword.isEmpty){
      return false;
    }
    if (confirmPassword.length < 8) {
      return false;
    }
    if(confirmPassword != password){
      return false;
    }
    return true;
  }

  Future<bool> IsEmailNotDuplicate(String email) async {
    List<UsersModel> users = await _dbContext!.GetAllUsers();
    for(var user in users){
      if(user.Email == email){
        return false;
      }
    }
    return true;
  }

}
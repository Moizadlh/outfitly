import 'package:flutter/material.dart';
import 'package:outfitly/DatabaseContext/DbContext.dart';
import 'package:outfitly/Models/UsersModel.dart';
import 'package:outfitly/Screens/HomeScreen.dart';
import 'package:outfitly/Screens/MainLayout.dart';
import 'package:outfitly/Screens/SignUpScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {

  DbContext? _dbContext;
  int? SignInUserId;
  bool isEmailValid = true;
  bool IsPasswordShow = false;

  @override
  void initState() {
    super.initState();
    _dbContext = DbContext();
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signIn(String email, String password) async {
    await Future.delayed(Duration(seconds: 2));
    if (email == "test@example.com" && password == "password") {
      print("Sign-in successful");
    } else {
      print("Invalid credentials");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/SplashImage.jpg', // Background image
            fit: BoxFit.cover,
          ),
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
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 70),
                  // Logo (S letter)
                  Text(
                    "S",
                    style: GoogleFonts.whisper(
                      fontSize: 120,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4D4D4D),
                    ),
                  ),
                  SizedBox(height: 30),
                  // Sign In Text
                  Text(
                    "Login",
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
                  SizedBox(height: 20),
                  // Email Field with rounded border and icon
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF9F7F3).withOpacity(0.7),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // Align children to the left
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
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.brown.shade600,
                            ),
                            suffixIcon: Icon(
                              isEmailValid ? Icons.check_circle : Icons.error,
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
                            errorText: null, // Disable the default error text rendering
                          ),
                          onChanged: (value) {
                            setState(() {
                              if (value != "") {
                                isEmailValid = isValidEmail(value);
                              } else {
                                isEmailValid = true;
                              }
                            });
                          },
                        ),
                        if (!isEmailValid)
                          Padding(
                            padding: EdgeInsets.only(left: 45), // Shift the error text 20 units to the right
                            child: Text(
                              'Invalid Email',
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
                  // Password Field with rounded border and icon
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF9F7F3).withOpacity(0.7),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: TextField(
                      controller: passwordController,
                      obscureText: IsPasswordShow ? false : true,
                      style: GoogleFonts.playfairDisplay(color: Color(0xFF333333),fontWeight: FontWeight.w600,fontSize: 18),
                      cursorColor: Colors.brown.shade600,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock, color: Colors.brown.shade600),
                        suffixIcon: IconButton(icon: Icon(IsPasswordShow ? BootstrapIcons.eye_fill : BootstrapIcons.eye_slash_fill, color: Colors.brown.shade600),onPressed: (){setState(() {IsPasswordShow = !IsPasswordShow;});},),
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Color(0xFFA1A1A1),fontWeight: FontWeight.w500,fontSize: 14),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  // Circular Sign In Button with Arrow Icon
                  Center(
                    child: GestureDetector(
                      onTap: () async {
                        String email = emailController.text;
                        String password = passwordController.text;
                        if (email.isEmpty || password.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please fill in all fields.'),
                              duration: Duration(seconds: 2),
                              backgroundColor: Color(0xFFFF6B6B),
                            ),
                          );
                        } else {
                          if (isValidEmail(email)) {
                            if (await CheckUserExistence(email, password)) {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => MainLayout(userId: SignInUserId),),);
                            }
                            else{
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Username or Password is incorrect'),
                                  duration: Duration(seconds: 2),
                                  backgroundColor: Color(0xFFFF6B6B),
                                ),
                              );
                            }

                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Invalid email detected.'),
                                duration: Duration(seconds: 2),
                                backgroundColor: Color(0xFFFF6B6B),
                              ),
                            );
                          }
                        }
                      },
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.brown.shade700,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.arrow_forward, size: 40, color: Color(0xFFFFFFFF)),
                      ),
                    ),
                  ),
                  SizedBox(height: 70),
                  // Sign Up prompt
                  // Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an account?',
                        style: GoogleFonts.playfairDisplay(color: Color(0xFF333333),fontSize: 16,fontWeight: FontWeight.w600),),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignupScreen()),
                          );
                        },
                        child: Text(
                          'Register',
                          style: GoogleFonts.playfairDisplay(
                            color: Colors.brown.shade600,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            fontSize: 16,
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
    String pattern = r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  Future<bool> CheckUserExistence(String email, String password) async {
    List<UsersModel> users = await _dbContext!.GetAllUsers();
    for (var user in users) {
      if (user.Email == email && user.LoginPassword == password) {
        SignInUserId = user.UserId;
        return true;
      }
    }
    return false;
  }
}

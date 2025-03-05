import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_app/components/my_button.dart';
import 'package:flutter_app/components/my_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() {
    // TODO: Thực hiện chức năng đăng nhập ở đây
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    if (username.isNotEmpty && password.isNotEmpty) {
      // Chuyển sang màn hình Home
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // Hiển thị thông báo nếu thiếu thông tin
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Vui lòng nhập Username và Password")),
      );
    }
  }

  void signInWithGoogle() {
    // TODO: Thực hiện chức năng đăng nhập Google
  }

  void signInWithFacebook() {
    // TODO: Thực hiện chức năng đăng nhập Facebook
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFe0f7fa),
                  Color(0xFFffffff),
                ],
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),

                    // Text Login
                    Text(
                      'Welcome Back!',
                      style: GoogleFonts.poppins(
                        color: Colors.blue[900],
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Login to continue',
                      style: GoogleFonts.poppins(
                        color: Colors.grey[700],
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Username TextField
                    MyTextField(
                      controller: usernameController,
                      hintText: 'Username',
                      obsecureText: false,
                    ),

                    const SizedBox(height: 25),

                    // Password TextField
                    MyTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      obsecureText: true,
                    ),

                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),

                    // Button Login
                    MyButton(
                      onTap: signUserIn,

                    ),

                    const SizedBox(height: 30),

                    // Or continue with
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text('or continue with'),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // Social Media Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: signInWithGoogle,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/icons/google.png',
                                  height: 24,
                                ),
                                const SizedBox(width: 10),
                                const Text('Google'),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        GestureDetector(
                          onTap: signInWithFacebook,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/icons/facebook.png',
                                  height: 24,
                                ),
                                const SizedBox(width: 10),
                                const Text('Facebook'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

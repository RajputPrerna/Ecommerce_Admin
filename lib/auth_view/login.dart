// import 'package:e_commerce/HomePages/HomePage.dart';
// import 'package:e_commerce/auth_view/singup.dart';
// import 'package:e_commerce/categories/CategoryScreen.dart';
// import 'package:flutter/material.dart';
//
// import '../categories/AddCategoryScreen.dart';
//
// class LoginPage extends StatelessWidget {
//   const LoginPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         body: SingleChildScrollView(
//           child: Container(
//             margin: const EdgeInsets.all(24),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 _header(context),
//                 _inputField(context),
//                 _forgotPassword(context),
//                 _signup(context),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   _header(context) {
//     return const Column(
//       children: [
//         Text(
//           "Welcome Back",
//           style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
//         ),
//         Text("Enter your credential to login"),
//       ],
//     );
//   }
//
//   _inputField(context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         TextField(
//           decoration: InputDecoration(
//               hintText: "Username",
//               border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(18),
//                   borderSide: BorderSide.none
//               ),
//               fillColor: Colors.blue.withOpacity(0.1),
//               filled: true,
//               prefixIcon: const Icon(Icons.person)),
//         ),
//         const SizedBox(height: 10),
//         TextField(
//           decoration: InputDecoration(
//             hintText: "Password",
//             border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(18),
//                 borderSide: BorderSide.none),
//             fillColor: Colors.blue.withOpacity(0.1),
//             filled: true,
//             prefixIcon: const Icon(Icons.password),
//           ),
//           obscureText: true,
//         ),
//         const SizedBox(height: 10),
//         ElevatedButton(
//           onPressed: () {
//             Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
//
//           },
//           style: ElevatedButton.styleFrom(
//             shape: const StadiumBorder(),
//             padding: const EdgeInsets.symmetric(vertical: 16),
//             backgroundColor: Colors.blue,
//           ),
//           child: const Text(
//             "Login",
//             style: TextStyle(fontSize: 20),
//           ),
//         ),
//       ],
//     );
//   }
//
//   _forgotPassword(context) {
//     return TextButton(
//       onPressed: () {},
//       child: const Text("Forgot password?",
//         style: TextStyle(color: Colors.blue),
//       ),
//     );
//   }
//
//   _signup(context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         const Text("Dont have an account? "),
//         TextButton(
//             onPressed: () {
//               Navigator.pushReplacement(context,
//                   MaterialPageRoute(builder: (context) => SignupPage()));
//             },
//             child: const Text("Sign Up", style: TextStyle(color: Colors.blue),)
//         )
//       ],
//     );
//   }
// }
import 'package:e_commerce/auth_view/singup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../HomePages/HomePage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Form_key = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  var password = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: Form_key,
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 100, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Welcome TrendyTreasures",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Let's Admin Login in TrendyTreasures",
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter email";
                      } else if (!value.contains("@") || !value.contains(".")) {
                        return "Please enter valid email";
                      }
                      return null;
                    },
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: "Enter Your Email",
                      label: const Text("Email"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      prefixIcon: const Icon(Icons.email_outlined),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter Password";
                      }
                      return null;
                    },
                    controller: passController,
                    obscureText: password,
                    decoration: InputDecoration(
                      hintText: "Enter Your Password",
                      label: const Text("Password"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      prefixIcon: const Icon(Icons.lock_outline_rounded),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            password = !password;
                          });
                        },
                        icon: password
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    height: 60,
                    width: 60,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (Form_key.currentState!.validate()) {
                          try {
                            await FirebaseAuth.instance.signInWithEmailAndPassword(
                              email: emailController.text,
                              password: passController.text,
                            );
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage())

                        );
                          } on FirebaseAuthException catch (e) {
                            if (e.code == "user-not-found" || e.code == "wrong-password") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Invalid email or password"),
                                ),
                              );
                            }
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey,
                        side: const BorderSide(color: Colors.black),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(70),

                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Center(
                          child: Icon(Icons.arrow_forward_outlined, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an Account ?"),
                    const SizedBox(width: 10),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RegisterPage()));
                      },
                      child: const Text("Sign Up", style: TextStyle(color: Colors.blueGrey)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



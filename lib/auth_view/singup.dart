// import 'package:e_commerce/auth_view/login.dart';
// import 'package:e_commerce/categories/CategoryScreen.dart';
// import 'package:flutter/material.dart';
//
// import '../categories/AddCategoryScreen.dart';
//
// class SignupPage extends StatelessWidget {
//   const SignupPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         body: SingleChildScrollView(
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 40),
//             height: MediaQuery
//                 .of(context)
//                 .size
//                 .height - 50,
//             width: double.infinity,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: <Widget>[
//                 Column(
//                   children: <Widget>[
//                     const SizedBox(height: 60.0),
//
//                     const Text(
//                       "Sign up",
//                       style: TextStyle(
//                         fontSize: 30,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     Text(
//                       "Create your account",
//                       style: TextStyle(fontSize: 15, color: Colors.grey[700]),
//                     )
//                   ],
//                 ),
//                 Column(
//                   children: <Widget>[
//                     TextField(
//                       decoration: InputDecoration(
//                           hintText: "Username",
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(18),
//                               borderSide: BorderSide.none),
//                           fillColor: Colors.blue.withOpacity(0.1),
//                           filled: true,
//                           prefixIcon: const Icon(Icons.person)),
//                     ),
//
//                     const SizedBox(height: 20),
//
//                     TextField(
//                       decoration: InputDecoration(
//                           hintText: "Email",
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(18),
//                               borderSide: BorderSide.none),
//                           fillColor: Colors.blue.withOpacity(0.1),
//                           filled: true,
//                           prefixIcon: const Icon(Icons.email)),
//                     ),
//
//                     const SizedBox(height: 20),
//
//                     TextField(
//                       decoration: InputDecoration(
//                         hintText: "Password",
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(18),
//                             borderSide: BorderSide.none),
//                         fillColor: Colors.blue.withOpacity(0.1),
//                         filled: true,
//                         prefixIcon: const Icon(Icons.password),
//                       ),
//                       obscureText: true,
//                     ),
//
//                     const SizedBox(height: 20),
//
//                     TextField(
//                       decoration: InputDecoration(
//                         hintText: "Confirm Password",
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(18),
//                             borderSide: BorderSide.none),
//                         fillColor: Colors.blue.withOpacity(0.1),
//                         filled: true,
//                         prefixIcon: const Icon(Icons.password),
//                       ),
//                       obscureText: true,
//                     ),
//                   ],
//                 ),
//                 Container(
//                     padding: const EdgeInsets.only(top: 3, left: 3),
//
//                     child: ElevatedButton(
//                       onPressed: () {},
//                       child: const Text(
//                         "Sign up",
//                         style: TextStyle(fontSize: 20),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         shape: const StadiumBorder(),
//                         padding: const EdgeInsets.symmetric(vertical: 16),
//                         backgroundColor: Colors.blue,
//                       ),
//                     )
//                 ),
//
//                 const Center(child: Text("Or")),
//
//                 Container(
//                   height: 45,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(25),
//                     border: Border.all(
//                       color: Colors.blue,
//                     ),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.white.withOpacity(0.5),
//                         spreadRadius: 1,
//                         blurRadius: 1,
//                         offset: const Offset(
//                             0, 1), // changes position of shadow
//                       ),
//                     ],
//                   ),
//                   child: TextButton(
//                     onPressed: () {},
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Container(
//                           height: 30.0,
//                           width: 30.0,
//                           decoration: const BoxDecoration(
//                             image: DecorationImage(
//                                 image: AssetImage(
//                                     'assets/images/login_signup/google.png'),
//                                 fit: BoxFit.cover),
//                             shape: BoxShape.circle,
//                           ),
//                         ),
//
//                         const SizedBox(width: 18),
//
//                         const Text("Sign In with Google",
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: Colors.blue,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     const Text("Already have an account?"),
//                     TextButton(
//                         onPressed: () {
//                           Navigator.pushReplacement(
//                               context, MaterialPageRoute(builder: (context) =>
//                               AddCategoryScreen()));
//                         },
//                         child: const Text(
//                           "Login", style: TextStyle(color: Colors.blue),)
//                     )
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/HomePages/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final Form_key = GlobalKey<FormState>();
  var password = false, con_password = true;
  bool passwordVisible = false;
  bool con_passwordVisible = true;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController cpass = TextEditingController();
  bool isLoading = false;
  String uniquefilename = DateTime.now().millisecondsSinceEpoch.toString();

  // Future<bool>doesRegisterExist(String email) async{
  //
  //   final querySnapshot = await FirebaseFirestore.instance
  //       .collection("User")
  //       .where("email", isEqualTo: email)
  //       .get();
  //
  //   return querySnapshot.docs.isNotEmpty;
  // }
  //
  // Future<void>addRegisterToFirestore() async{
  //   final Name = name.text.trim();
  //   final Email = email.text.trim();
  //   final Password = pass.text.trim();
  //   final ConfirmPassword = cpass.text.trim();
  //
  //
  //   if(Name.isEmpty)
  //     {
  //       ScaffoldMessenger.of(context).showSnackBar
  //         (const SnackBar(content: Text("Please enter your name")));
  //     }
  //
  //   if(Email.isEmpty)
  //     {
  //       ScaffoldMessenger.of(context).showSnackBar
  //         (const SnackBar(content: Text("Please enter your email")));
  //     }
  //
  //   if(Password.isEmpty)
  //     {
  //       ScaffoldMessenger.of(context).showSnackBar
  //         (const SnackBar(content: Text("Please Enter your password")));
  //     }
  //
  //   if(ConfirmPassword.isEmpty)
  //     {
  //       ScaffoldMessenger.of(context).showSnackBar
  //         (const SnackBar(content: Text("Please re-enter your password")));
  //     }
  //
  //
  //   final doesExist = await doesRegisterExist(email.text);
  //
  //   if (doesExist) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text("Email already exists")),
  //     );
  //   } else {
  //     setState(() {
  //       isLoading = true;
  //     });
  //
  //
  //     try
  //         {
  //           FirebaseFirestore.instance.collection("SignUp").add({
  //             'name': name.text,
  //             'email': email.text,
  //             'password': pass.text,
  //             'confirm password': cpass.text,
  //           }).then((value){
  //             name.clear();
  //             pass.clear();
  //             email.clear();
  //             cpass.clear();
  //             isLoading = false;
  //
  //             ScaffoldMessenger.of(context).showSnackBar
  //               (const SnackBar(content: Text("Register successfull")));
  //           });
  //         }
  //         catch (error)
  //   {
  //     print("Error Uploading Data: $error",);
  //   }
  //     {
  //       setState(() {
  //         isLoading = false;
  //       });
  //     }
  //   }  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: Form_key,
            child: Container(
              margin: const EdgeInsets.only(top: 100, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Welcome to Treandy-Treasures",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                  ),
                  const Text(
                    "Let's Register in Treandy-Treasures",
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: TextFormField(
                      controller: name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your name";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: "Enter your username",
                          label: const Text("Username"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: const Icon(Icons.account_box_rounded)),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: TextFormField(
                      controller: email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your email";
                        } else if (!value.contains("@") || !value.contains(".")) {
                          return "Please enter valid email";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: "Enter your email",
                          label: const Text("Email"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: const Icon(Icons.email_outlined)),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: TextFormField(
                      controller: pass,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter Password";
                        }
                        return null;
                      },
                      obscureText: !passwordVisible,
                      decoration: InputDecoration(
                        hintText: "Enter your password",
                        label: const Text("Password"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: const Icon(Icons.lock_outline_rounded),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                          icon: Icon(
                            passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: TextFormField(
                      controller: cpass,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter Password";
                        }
                        return null;
                      },
                      obscureText: !con_passwordVisible,
                      decoration: InputDecoration(
                        hintText: "Please confirm your password",
                        label: const Text("Confirm Password"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: const Icon(Icons.lock_outline_rounded),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              if(con_password == true)
                              {
                                con_password = false;
                              }
                              else
                              {
                                con_password= true;
                              }

                              con_passwordVisible = !con_passwordVisible;
                            });
                          },
                          icon: Icon(
                            con_passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
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
                              await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                email: email.text, password: pass.text,)
                                  .then((value) {
                                FirebaseFirestore.instance.collection(
                                    "Admin").add(
                                    {
                                      "Username": name.text,
                                      "Email": email.text,
                                      "Password": pass.text,
                                    });
                              });
                              ScaffoldMessenger.of(context).showSnackBar
                                (const SnackBar(
                                  content: Text("Register Successfull")));
                            }
                            on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Password is too weak"),
                                    ));
                              }
                              else if (e.code == 'email-already-in-use') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          "Email is already Registered"),
                                    ));
                              }
                            }
                          }
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueGrey,
                          side: const BorderSide(color: Colors.black),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(70),
                          ),
                        ),
                        child: const Icon(Icons.arrow_forward_rounded, color: Colors.black),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have Account ?"),
                      const SizedBox(width: 10),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                        },
                        child: const Text("Login!", style: TextStyle(color: Colors.lightGreen)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

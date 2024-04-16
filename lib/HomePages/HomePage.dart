
import 'package:e_commerce/Banner/BannerScreen.dart';
import 'package:e_commerce/Categories/AddCategoryScreen.dart';
import 'package:e_commerce/Categories/EditCategoryScreen.dart';
import 'package:e_commerce/Product/ProductScreen.dart';
import 'package:e_commerce/Provider.dart';
import 'package:e_commerce/SubCategory/SubCategoryScreen.dart';
import 'package:e_commerce/UsersOrders/User.dart';
import 'package:e_commerce/auth_view/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../AllUsers/userScreen.dart';
import '../Categories/CategoryScreen.dart';




class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // String orderId = UserOrderModel() as String
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit the app?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          ),
    )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          elevation: 10,
          title: const Text(
            "TreandyTresures",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 20,
                      backgroundImage:
                      AssetImage('assets/logo.jpg'),
                    ),
                    SizedBox(height: 10),
                    Text(

                      "Profile",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,

                      ),

                    )
                    // Image.asset("");
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),

              // ListTile(
              // leading: const Icon(Icons.add_box),
              // title: const Text("Orders"),
              //   onTap: _openOrdersScreen,
              // ),

              ListTile(
                leading: const Icon(Icons.nightlight),
                title: const Text("Theme"),
                onTap: () {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleTheme();
                },
              ),
              ListTile(
                leading: const Icon(Icons.exit_to_app),
                title: const Text("Logout"),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                            (route) => false);
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.share),
                title: const Text("Share"),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.rate_review),
                title: const Text("Rate Us"),
                onTap: () {},
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Trendy Treasures Admin',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 1.0,
                  mainAxisSpacing: 20.0,
                  crossAxisSpacing: 20.0,
                  children: List.generate(6, (index) {
                    List<Map<String, dynamic>> cardData = [
                      {
                        "image": "assets/categorylogo.jpg",
                        "text": "Category",
                        "onTap": _CategoryScreen,
                      },
                      {
                        "image": "assets/subcategory.png",
                        "text": "SubCategory",
                        "onTap": _SubCategoryScreen,
                      },
                      {
                        "image": "assets/productslogo.png",
                        "text": "Products",
                        "onTap": _ProductScreen,
                      },
                      {
                        "image": "assets/bannerslogo.jpg",
                        "text": "Banners",
                        "onTap": _BannerScreen,
                      },
                      {
                        "image": "assets/orderlogo.jpg",
                        "text": "Users Orders",
                        "onTap": _openOrdersScreen,
                      },
                      {
                        "image": "assets/allUserslogo.jpg",
                        "text": "All Users",
                          "onTap": _openUsersScreen,
                      },
                    ];
                    return GestureDetector(
                      onTap: cardData[index]["onTap"],
                      child: Card(
                        color: CupertinoColors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              cardData[index]["image"],
                              width: 48.0,
                              height: 48.0,
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              cardData[index]["text"],
                              style: const TextStyle(
                                  fontSize: 17.0, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _CategoryScreen() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => CategoryScreen(),
    ));
  }

  void _SubCategoryScreen() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => SubCategoryScreen(),
    ));
  }

  void _BannerScreen() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const BannerScreen(),
    ));
  }

  void _ProductScreen() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ProductScreen(),
    ));
  }


  void _openUsersScreen() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => UsersScreen(),
    ));
  }
//
//   void _openSliderBannerScreen() {
//     Navigator.of(context).push(MaterialPageRoute(
//       builder: (context) => BannerScreen(),
//     ));
//   }
//
  void _openOrdersScreen() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => OrderListScreenSeller(),
    ));
  }
}

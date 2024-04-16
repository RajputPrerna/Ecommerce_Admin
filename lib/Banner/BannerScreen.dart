// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// import 'AddCategoryScreen.dart';
// import 'CategoryModel.dart';
// import 'EditCategoryScreen.dart';
// //import 'ProductScreen.dart';
//
//
// class CategoryScreen extends StatefulWidget {
//   const CategoryScreen({super.key});
//
//   @override
//   State<CategoryScreen> createState() => _CategoryScreenState();
// }
//
// class _CategoryScreenState extends State<CategoryScreen> {
//
//
//   void _deleteCategory(String categoryID) {
//     FirebaseFirestore.instance
//         .collection('Categories')
//         .doc(categoryID)
//         .delete()
//         .then((value) {
//       // Show a toast message when a category is deleted successfully
//       Fluttertoast.showToast(
//         msg: 'Category deleted successfully',
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         backgroundColor: Colors.green,
//         textColor: Colors.white,
//       );
//     }).catchError((error) {
//       // Show a toast message when there is an error deleting the category
//       Fluttertoast.showToast(
//         msg: 'Failed to delete category',
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//       );
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var buttonBorderColor;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.green,
//         title: const Text('All Categories', style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: Colors.white),),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 children: [
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const AddCategoryScreen()));
//                     },
//                     style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(5),), backgroundColor: Colors.green),
//                     child: const Text('Add Category',
//                         style: TextStyle(fontSize: 13, color: Colors.white)),
//                   ),
//
//
//                 ],
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Container(
//                 width: double.infinity,
//                 height: 40,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   border: Border.all(color: buttonBorderColor),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 10, right: 10, top: 17),
//                   child: TextFormField(
//                     decoration: const InputDecoration(
//                       border: InputBorder.none,
//                       hintText: 'Search Categories',
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               const Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Text(
//                     'Serial No',
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//                   ),
//                   Text(
//                     'Category Name',
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   Text(
//                     'Category Image',
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//                   ),
//                 ],
//               ),
//               CategoryListWidget(deleteCategory: _deleteCategory),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class CategoryListWidget extends StatelessWidget {
//   final Function(String) deleteCategory; // Callback function
//
//   const CategoryListWidget({super.key, required this.deleteCategory});
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance.collection('Categories').snapshots(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return const CircularProgressIndicator();
//         }
//         final categoryDocs = snapshot.data!.docs;
//         List<CategoryModel> categories = [];
//
//         for (var doc in categoryDocs) {
//           final category = CategoryModel.fromSnapshot(doc);
//           categories.add(category);
//         }
//
//         return ListView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: categories.length,
//           itemBuilder: (context, index) {
//             final category = categories[index];
//             var buttonBorderColor;
//             return Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Row(
//                     children: [
//                       Text((index + 1).toString()),
//                       const Spacer(),
//                       Text(category.category),
//                       const Spacer(),
//                       Image.network(category.image, width: 100, height: 30),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Row(
//                     // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Container(
//                           width: 70,
//                           height: 35,
//                           decoration: BoxDecoration(
//                             border: Border.all(color: buttonBorderColor),
//                             borderRadius: BorderRadius.circular(20.0),
//                           ),
//                           child: TextButton(onPressed: () {
//                             Navigator.push(context, MaterialPageRoute(builder: (context) =>   EditCategoryScreen(category: category, image: category.image)));
//                           }, child: const Text('Edit', style: TextStyle(fontSize: 12),),
//
//                           )
//                       ),
//
//                       const SizedBox(width: 100,),
//
//                       Container(
//                         width: 70,
//                         height: 35,
//                         decoration: BoxDecoration(
//                           border: Border.all(color: buttonBorderColor),
//                           borderRadius: BorderRadius.circular(20.0),
//                         ),
//                         child: TextButton(
//                           onPressed: () {
//                             // Show a confirmation dialog
//                             showDialog(
//                               context: context,
//                               builder: (BuildContext context) {
//                                 return AlertDialog(
//                                   title: const Text('Confirm Deletion'),
//                                   content: const Text(
//                                       'Are you sure you want to delete this category?'),
//                                   actions: [
//                                     TextButton(
//                                       onPressed: () {
//                                         // Dismiss the dialog
//                                         Navigator.of(context).pop();
//                                       },
//                                       child: const Text('Cancel'),
//                                     ),
//                                     TextButton(
//                                       onPressed: () {
//                                         // Delete the category and dismiss the dialog
//                                         deleteCategory(category.id);
//                                         Navigator.of(context).pop();
//                                       },
//                                       child: const Text('Yes'),
//                                     ),
//                                   ],
//                                 );
//                               },
//                             );
//                           },
//                           child: const Text('Delete',
//                               style: TextStyle(fontSize: 12)),
//                         ),
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
//



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Banner/AddBannerScreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'BannerModelScreen.dart';
import 'EditBannerScreen.dart';


class BannerScreen extends StatefulWidget {
  const BannerScreen({Key? key}) : super(key: key);

  @override
  State<BannerScreen> createState() => _BannerScreenState();
}

class _BannerScreenState extends State<BannerScreen> {
  late TextEditingController searchController;
  late String searchQuery;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    searchQuery = '';
  }

  void _deleteBanner(String bannerID) {
    FirebaseFirestore.instance
        .collection('Banner')
        .doc(bannerID)
        .delete()
        .then((value) {
      // Show a toast message when a category is deleted successfully
      Fluttertoast.showToast(
        msg: 'banner deleted successfully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    }).catchError((error) {
      // Show a toast message when there is an error deleting the category
      Fluttertoast.showToast(
        msg: 'Failed to delete banner',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'banner',
          style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddBannerScreen(),
                  ),
                );
              },
              backgroundColor: Colors.black,
              tooltip: 'Add banner',
              child: Icon(Icons.add,color: Colors.white,),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.blue),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: searchController,
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search Banner ...',
                    hintStyle: TextStyle(color: Colors.blue),
                    suffixIcon: Icon(Icons.search, color: Colors.blue),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: BannerListWidget(deleteBanner: _deleteBanner, searchQuery: searchQuery),
            ),
          ],
        ),
      ),
    );
  }
}



class BannerListWidget extends StatelessWidget {
  final Function(String) deleteBanner;
  final String searchQuery;

  const BannerListWidget({Key? key, required this.deleteBanner, required this.searchQuery}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Banner').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        final bannerDocs = snapshot.data!.docs;
        List<BannerModel> banners = [];

        for (var doc in bannerDocs) {
          final banner = BannerModel.fromSnapshot(doc);
          banners.add(banner);
        }

        // Filter categories based on the search query
        List<BannerModel> filteredBanners = banners
            .where((banner) => banner.banner.toLowerCase().contains(searchQuery.toLowerCase()))
            .toList();

        return ListView.builder(
          itemCount: filteredBanners.length,
          itemBuilder: (context, index) {
            final banner = filteredBanners[index];
            return BannerCard(
              banner: banner,
              onDelete: () => _showDeleteDialog(context, banner.id),
              onEdit: () => _navigateToEditScreen(context, banner),
            );
          },
        );
      },
    );
  }

  void _showDeleteDialog(BuildContext context, String bannerId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete this category?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                deleteBanner(bannerId);
                Navigator.of(context).pop();
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToEditScreen(BuildContext context, BannerModel banner) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditBannerScreen(banner: banner, image: banner.image),
      ),
    );
  }
}

class BannerCard extends StatelessWidget {
  final BannerModel banner;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const BannerCard({
    Key? key,
    required this.banner,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(banner.banner, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Image.network(banner.image, width: double.infinity, height: 150,),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: onEdit,
                  child: Text('Edit', style: TextStyle(color: Colors.blue)),
                ),
                SizedBox(width: 16),
                TextButton(
                  onPressed: onDelete,
                  child: Text('Delete', style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

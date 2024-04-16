//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// import 'AddSubCategory.dart';
// import 'SubCategoryModel.dart';
//
//
//
// class OpenCategory extends StatefulWidget {
//   const OpenCategory({super.key});
//
//   @override
//   State<OpenCategory> createState() => _OpenCategoryState();
// }
//
// class _OpenCategoryState extends State<OpenCategory> {
//
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
//         backgroundColor: Colors.blue,
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
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
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
//                               builder: (context) => const AddSubCategoryScreen()));
//                     },
//                     style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(5),), backgroundColor: Colors.green),
//                     child: const Text('Add Sub Category',
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
//                   // color: textFormBgColor.withOpacity(.10),
//                   borderRadius: BorderRadius.circular(20),
//                   // border: Border.all(color: buttonBorderColor),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 10, right: 10, top: 17),
//                   child: TextFormField(
//                     decoration: const InputDecoration(
//                       border: InputBorder.none,
//                       hintText: 'Search Sub Categories',
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
//
//                   Text(
//                     ' Sub Category Name',
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
//       stream: FirebaseFirestore.instance.collection('SubCategories').snapshots(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return const CircularProgressIndicator();
//         }
//         final categoryDocs = snapshot.data!.docs;
//         List<SubCategoryModel> categories = [];
//
//         for (var doc in categoryDocs) {
//           final category = SubCategoryModel.fromSnapshot(doc);
//           categories.add(category);
//         }
//
//         return ListView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: categories.length,
//           itemBuilder: (context, index) {
//             final category = categories[index];
//             return Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Row(
//                     children: [
//                       Text((index + 1).toString()),
//                       const Spacer(),
//                       Text(category.subcategory),
//
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
//                             // border: Border.all(color: buttonBorderColor),
//                             borderRadius: BorderRadius.circular(20.0),
//                           ),
//                           child: TextButton(onPressed: ()
//                           {
//
//
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
//                           // border: Border.all(color: buttonBorderColor),
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
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Categories/CategoryModel.dart';
import '../Categories/EditCategoryScreen.dart';
import 'AddSubCategory.dart';
import 'EditCategoryScreen.dart';
import 'SubCategoryModel.dart';


class SubCategoryScreen extends StatefulWidget {
  const SubCategoryScreen({Key? key}) : super(key: key);

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  late TextEditingController searchController;
  late String searchQuery;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    searchQuery = '';
  }

  void _deleteCategory(String categoryID) {
    FirebaseFirestore.instance
        .collection('SubCategories')
        .doc(categoryID)
        .delete()
        .then((value) {
      // Show a toast message when a category is deleted successfully
      Fluttertoast.showToast(
        msg: 'Category deleted successfully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
      );
    }).catchError((error) {
      // Show a toast message when there is an error deleting the category
      Fluttertoast.showToast(
        msg: 'Failed to delete category',
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
          'Sub Category',
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
                    builder: (context) => const AddSubCategoryScreen(),
                  ),
                );
              },
              backgroundColor: Colors.black,
              tooltip: 'Add Sub Category',
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
                color: Colors.grey.withOpacity(.1),
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
                    hintText: 'Search Sub Category ...',
                    hintStyle: TextStyle(color: Colors.blue),
                    suffixIcon: Icon(Icons.search, color: Colors.blue),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: CategoryListWidget(deleteCategory: _deleteCategory, searchQuery: searchQuery),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryListWidget extends StatelessWidget {
  final Function(String) deleteCategory;
  final String searchQuery;

  const CategoryListWidget({Key? key, required this.deleteCategory, required this.searchQuery}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('SubCategories').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        final categoryDocs = snapshot.data!.docs;
        List<SubCategoryModel> categories = [];

        for (var doc in categoryDocs) {
          final category = SubCategoryModel.fromSnapshot(doc);
          categories.add(category);
        }

        // Filter categories based on the search query
        List<SubCategoryModel> filteredCategories = categories
            .where((subCategory) => subCategory.subCategory.toLowerCase().contains(searchQuery.toLowerCase()))
            .toList();

        return ListView.builder(
          itemCount: filteredCategories.length,
          itemBuilder: (context, index) {
            final category = filteredCategories[index];
            return CategoryCard(
              category: category,
              onDelete: () => _showDeleteDialog(context, category.id),
              onEdit: () => _navigateToEditScreen(context, category),
            );
          },
        );
      },
    );
  }

  void _showDeleteDialog(BuildContext context, String categoryId) {
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
                deleteCategory(categoryId);
                Navigator.of(context).pop();
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToEditScreen(BuildContext context, SubCategoryModel subCategory) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditSubCategoryScreen(subCategory: subCategory, image: subCategory.image),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final SubCategoryModel category;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const CategoryCard({
    Key? key,
    required this.category,
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
            Text(category.subCategory, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Image.network(category.image, width: double.infinity, height: 150, fit: BoxFit.cover),
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

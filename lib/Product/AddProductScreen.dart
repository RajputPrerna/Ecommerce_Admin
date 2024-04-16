// // // ignore_for_file: file_names
// //
// // import 'dart:io';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_storage/firebase_storage.dart';
// // import 'package:flutter/material.dart';
// // import 'package:image_picker/image_picker.dart';
// //
// // class AddProductScreen extends StatefulWidget {
// //   const AddProductScreen({Key? key}) : super(key: key);
// //
// //   @override
// //   State<AddProductScreen> createState() => _AddProductScreenState();
// // }
// //
// // class _AddProductScreenState extends State<AddProductScreen> {
// //
// //   TextEditingController categoryName = TextEditingController();
// //   String uniquefilename = DateTime.now().millisecondsSinceEpoch.toString();
// //   String imageUrl = '';
// //   File? selectedImage;
// //   bool isLoading = false;
// //
// //   // Function to check if the category already exists in Firestore
// //   Future<bool> doesCategoryExist(String categoryName) async {
// //     final querySnapshot = await FirebaseFirestore.instance
// //         .collection("Categories")
// //         .where("category", isEqualTo: categoryName)
// //         .get();
// //
// //     return querySnapshot.docs.isNotEmpty;
// //   }
// //
// //   Future<void> addCategoryToFirestore() async {
// //     final category = categoryName.text.trim();
// //     if (category.isEmpty) {
// //       // Show a toast message if the category name is empty
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text("Please enter a category name")),
// //       );
// //       return; // Stop the function execution
// //     }
// //
// //
// //     final doesExist = await doesCategoryExist(category);
// //
// //     if (doesExist) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text("Category already exists")),
// //       );
// //     } else {
// //       setState(() {
// //         isLoading = true;
// //       });
// //
// //       if (selectedImage != null) {
// //         Reference referenceRoot = FirebaseStorage.instance.ref();
// //         Reference referenceDirImages = referenceRoot.child('Category_images');
// //         Reference referenceImageToUpload = referenceDirImages.child(uniquefilename);
// //         try {
// //           await referenceImageToUpload.putFile(selectedImage!);
// //           imageUrl = await referenceImageToUpload.getDownloadURL();
// //           print("Image URL: $imageUrl");
// //
// //           // Add category to Firestore only if an image is selected
// //           FirebaseFirestore.instance.collection("Categories").add({
// //             'category': categoryName.text,
// //             'image': imageUrl,
// //           }).then((value) {
// //             categoryName.clear();
// //             selectedImage = null;
// //             setState(() {
// //               isLoading = false;
// //             });
// //
// //             ScaffoldMessenger.of(context).showSnackBar(
// //               const SnackBar(content: Text("Category Added Successfully")),
// //             );
// //           });
// //         } catch (error) {
// //           print("Error uploading image: $error");
// //         }
// //       } else {
// //         // Display an error message or take appropriate action
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           const SnackBar(content: Text("Please select an image")),
// //         );
// //         setState(() {
// //           isLoading = false;
// //         });
// //       }
// //     }
// //   }
// //
// //
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         // elevation: 10,
// //         backgroundColor: Colors.deepPurpleAccent,
// //         title: const Text('Add Category',style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic, color: Colors.white),),
// //         centerTitle: true,
// //         // automaticallyImplyLeading: false,
// //         // backgroundColor: Colors.blueAccent,
// //       ),
// //       body: SingleChildScrollView(
// //         child: Padding(
// //           padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
// //           child: Column(
// //             children: [
// //               SizedBox(
// //                 width: double.infinity,
// //                 height: 45,
// //                 child: Column(
// //                   children: [
// //                     TextFormField(
// //                       controller: categoryName,
// //                       decoration: InputDecoration(
// //                           border: OutlineInputBorder(
// //                             borderRadius: BorderRadius.circular(3),
// //                           ),
// //                           focusedBorder: const OutlineInputBorder(
// //                             borderSide: BorderSide(color: Colors.blue),
// //                           ),
// //                           // enabledBorder: OutlineInputBorder(
// //                           //   borderSide: BorderSide(color: Colors.deepPurpleAccent)
// //                           // ),
// //                           labelText: "Category Name",
// //                           labelStyle: const TextStyle(color: Colors.blue)
// //                       ),
// //                     ),
// //                     SizedBox(height: 10,),
// //                     TextFormField(
// //                       controller: categoryName,
// //                       decoration: InputDecoration(
// //                           border: OutlineInputBorder(
// //                             borderRadius: BorderRadius.circular(3),
// //                           ),
// //                           focusedBorder: const OutlineInputBorder(
// //                             borderSide: BorderSide(color: Colors.blue),
// //                           ),
// //                           // enabledBorder: OutlineInputBorder(
// //                           //   borderSide: BorderSide(color: Colors.deepPurpleAccent)
// //                           // ),
// //                           labelText: "Category Name",
// //                           labelStyle: const TextStyle(color: Colors.blue)
// //                       ),
// //                     ),
// //                     SizedBox(height: 10,),
// //
// //                   ],
// //                 ),
// //               ),
// //
// //
// //
// //
// //               const SizedBox(height: 30),
// //               selectedImage != null
// //                   ? Image.file(selectedImage!, width: 200, height: 200)
// //                   : Image.asset("assets/images/image5.jpg", width: 200, height: 200),
// //               const SizedBox(height: 30),
// //               SizedBox(
// //                 width: double.infinity,
// //                 child: ElevatedButton(
// //                   onPressed: () async {
// //                     ImagePicker imagePicker = ImagePicker();
// //                     XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
// //                     if (file == null) return;
// //                     selectedImage = File(file.path);
// //                     setState(() {});
// //                   },style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
// //                   child: const Text("Select Image", style: TextStyle(color: Colors.blue),),
// //                 ),
// //               ),
// //               const SizedBox(height: 30),
// //
// //               SizedBox(
// //                 width: double.infinity,
// //                 child: ElevatedButton(
// //                   onPressed: () async {
// //                     addCategoryToFirestore();// Show the progress indicator
// //                   },
// //                   style: ElevatedButton.styleFrom(
// //                     shadowColor: Colors.black,
// //                     backgroundColor: Colors.blue,
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(3),
// //                     ),
// //                   ),
// //
// //
// //                   child: isLoading
// //                       ? const CircularProgressIndicator(color: Colors.white,) // Show the progress indicator
// //                       : const Text(
// //                     "Add Category",
// //                     style: TextStyle(fontSize: 16, color: Colors.white),
// //                   ),
// //                 ),
// //               ),
// //
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import '../Categories/CategoryModel.dart';
//
// class AddProductScreen extends StatefulWidget {
//   const AddProductScreen({Key? key}) : super(key: key);
//
//   @override
//   State<AddProductScreen> createState() => _AddProductScreenState();
// }
//
// class _AddProductScreenState extends State<AddProductScreen> {
//
//   TextEditingController categoryName = TextEditingController();
//   TextEditingController subCategoryName = TextEditingController();
//   TextEditingController productName = TextEditingController();
//   TextEditingController productPrice = TextEditingController();
//   TextEditingController discount = TextEditingController();
//   TextEditingController productNewPrice = TextEditingController();
//   TextEditingController productColour = TextEditingController();
//   TextEditingController productTitle1 = TextEditingController();
//   TextEditingController title1Details = TextEditingController();
//   TextEditingController productTitle2 = TextEditingController();
//   TextEditingController title2Details = TextEditingController();
//   TextEditingController productTitle3 = TextEditingController();
//   TextEditingController title3Details = TextEditingController();
//   TextEditingController productTitle4 = TextEditingController();
//   TextEditingController title4Details = TextEditingController();
//   TextEditingController productDescription = TextEditingController();
//
//   String? selectedCategory;
//   String uniquefilename = DateTime.now().millisecondsSinceEpoch.toString();
//   String imageUrl = '';
//   File? selectedImage;
//   bool isLoading = false;
//   String? subproduct;
//
//
//   Future<bool> doesProductExist(String ProductName) async {
//     final querySnapshot = await FirebaseFirestore.instance
//         .collection("Products")
//         .where("Product", isEqualTo: ProductName)
//         .get();
//
//     return querySnapshot.docs.isNotEmpty;
//   }
//
//   Future<void> addProductToFirestore() async {
//     final category = selectedCategory;
//     final subCategory = subCategoryName .text.trim();
//
//
//     if (category == null || category.isEmpty) {
//       // Show a toast message if the category is not selected
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please select a Category")),
//       );
//       return; // Stop the function execution
//     }
//
//
//     if (subCategory.isEmpty) {
//       // Show a toast message if the subcategory name is empty
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please enter a SubCategory name")),
//       );
//       return; // Stop the function execution
//     }
//
//
//     final doesExist = await doesProductExist(subCategory);
//
//     if (doesExist) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("SubCategory already exists")),
//       );
//     } else {
//       setState(() {
//         isLoading = true;
//       });
//
//       if (selectedImage != null) {
//         Reference referenceRoot = FirebaseStorage.instance.ref();
//         Reference referenceDirImages = referenceRoot.child('SubCategory_images');
//         Reference referenceImageToUpload = referenceDirImages.child(uniquefilename);
//         try {
//           await referenceImageToUpload.putFile(selectedImage!);
//           imageUrl = await referenceImageToUpload.getDownloadURL();
//           print("Image URL: $imageUrl");
//
//           // Add category to Firestore only if an image is selected
//           FirebaseFirestore.instance.collection("Products").add({
//             'category': category,
//             'subCategory': subCategoryName.text,
//             'productName': productName.text,
//             'productPrice': productPrice.text,
//             'discount': discount.text,
//             'productNewPrice': productNewPrice.text,
//             'productColour': productColour.text,
//             'productTitle1': productTitle1.text,
//             'title1Details': title1Details.text,
//
//             'productTitle2': productTitle2.text,
//             'title2Details': title2Details.text,
//
//             'productTitle3': productTitle3.text,
//             'title3Details': title3Details.text,
//
//             'productTitle4': productTitle4.text,
//             'title4Details': title4Details.text,
//             'productDescription': productDescription.text,
//
//
//
//             'image': imageUrl,
//           }).then((value) {
//             subCategoryName.clear();
//             selectedImage = null;
//             setState(() {
//               isLoading = false;
//             });
//
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text("SubCategory Added Successfully")),
//             );
//           });
//         } catch (error) {
//           print("Error uploading image: $error");
//         }
//       } else {
//         // Display an error message or take appropriate action
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Please select an image")),
//         );
//
//
//         setState(() {
//           isLoading = false;
//         });
//       }
//     }
//   }
//
//
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         title: const Text('Add SubCategory',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white ),),
//         elevation: 10,
//         centerTitle: true,
//       ),
//
//       body: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//
//
//               selectedImage != null
//                   ? Image.file(selectedImage!, width: 200, height: 200, fit: BoxFit.cover,)
//                   : Image.asset("assets/images/image5.jpg", width: 200, height: 200),
//
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () async {
//                     ImagePicker imagePicker = ImagePicker();
//                     XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
//                     if (file == null) return;
//                     selectedImage = File(file.path);
//                     setState(() {});
//                   },
//                   style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
//                   child: const Text("Select Image",style: TextStyle(color: Colors.blue),),
//                 ),
//               ),
//               const SizedBox(height: 20,),
//
//               CategoryDropdown(
//                 selectedCategory: selectedCategory,
//                 onChanged: (value) {
//                   setState(() {
//                     selectedCategory = value;
//                   });
//                 },
//               ),
//
//
//               const SizedBox(height: 20,),
//
//
//               Column(
//                 children: [
//                   TextFormField(
//                     controller: subCategoryName,
//                     decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(3),
//                         ),
//                         // focusedBorder: const OutlineInputBorder(
//                         //   borderSide: BorderSide(color:Colors.deepPurpleAccent)
//                         // ),
//                         labelText: "SubCategory Name",
//                         labelStyle: const TextStyle(color: Colors.blue)
//                     ),
//                   ),
//
//                   SizedBox(height: 10,),
//                   TextFormField(
//                     controller: productName,
//                     decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(3),
//                         ),
//                         // focusedBorder: const OutlineInputBorder(
//                         //   borderSide: BorderSide(color:Colors.deepPurpleAccent)
//                         // ),
//                         labelText: "Product Name",
//                         labelStyle: const TextStyle(color: Colors.blue)
//                     ),
//                   ),
//                   SizedBox(height: 10,),
//                   TextFormField(
//                     controller: productPrice,
//                     decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(3),
//                         ),
//                         // focusedBorder: const OutlineInputBorder(
//                         //   borderSide: BorderSide(color:Colors.deepPurpleAccent)
//                         // ),
//                         labelText: "Product Price",
//                         labelStyle: const TextStyle(color: Colors.blue)
//                     ),
//                   ),
//                   SizedBox(height: 10,),
//                   TextFormField(
//                     controller: discount,
//                     decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(3),
//                         ),
//                         // focusedBorder: const OutlineInputBorder(
//                         //   borderSide: BorderSide(color:Colors.deepPurpleAccent)
//                         // ),
//                         labelText: "Product discount",
//                         labelStyle: const TextStyle(color: Colors.blue)
//                     ),
//                   ),
//                   SizedBox(height: 10,),
//                   TextFormField(
//                     controller: productNewPrice,
//                     decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(3),
//                         ),
//                         // focusedBorder: const OutlineInputBorder(
//                         //   borderSide: BorderSide(color:Colors.deepPurpleAccent)
//                         // ),
//                         labelText: "Product New Price",
//                         labelStyle: const TextStyle(color: Colors.blue)
//                     ),
//                   ),
//                   SizedBox(height: 10,),
//                   TextFormField(
//                     controller: productColour,
//                     decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(3),
//                         ),
//                         // focusedBorder: const OutlineInputBorder(
//                         //   borderSide: BorderSide(color:Colors.deepPurpleAccent)
//                         // ),
//                         labelText: "Product Colour",
//                         labelStyle: const TextStyle(color: Colors.blue)
//                     ),
//                   ),
//                   SizedBox(height: 10,),
//                   TextFormField(
//                     controller: productTitle1,
//                     decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(3),
//                         ),
//                         // focusedBorder: const OutlineInputBorder(
//                         //   borderSide: BorderSide(color:Colors.deepPurpleAccent)
//                         // ),
//                         labelText: "Product Title1",
//                         labelStyle: const TextStyle(color: Colors.blue)
//                     ),
//                   ),
//                   SizedBox(height: 10,),
//                   TextFormField(
//                     controller: title1Details,
//                     decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(3),
//                         ),
//                         // focusedBorder: const OutlineInputBorder(
//                         //   borderSide: BorderSide(color:Colors.deepPurpleAccent)
//                         // ),
//                         labelText: "Title1 Details",
//                         labelStyle: const TextStyle(color: Colors.blue)
//                     ),
//                   ),
//                   SizedBox(height: 10,),
//                   TextFormField(
//                     controller: productTitle2,
//                     decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(3),
//                         ),
//                         // focusedBorder: const OutlineInputBorder(
//                         //   borderSide: BorderSide(color:Colors.deepPurpleAccent)
//                         // ),
//                         labelText: "Product Title2",
//                         labelStyle: const TextStyle(color: Colors.blue)
//                     ),
//                   ),
//                   SizedBox(height: 10,),
//                   TextFormField(
//                     controller: title2Details,
//                     decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(3),
//                         ),
//                         // focusedBorder: const OutlineInputBorder(
//                         //   borderSide: BorderSide(color:Colors.deepPurpleAccent)
//                         // ),
//                         labelText: "Title2 Details",
//                         labelStyle: const TextStyle(color: Colors.blue)
//                     ),
//                   ),
//                   SizedBox(height: 10,),
//                   TextFormField(
//                     controller: productTitle3,
//                     decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(3),
//                         ),
//                         // focusedBorder: const OutlineInputBorder(
//                         //   borderSide: BorderSide(color:Colors.deepPurpleAccent)
//                         // ),
//                         labelText: "Product Title3",
//                         labelStyle: const TextStyle(color: Colors.blue)
//                     ),
//                   ),
//                   SizedBox(height: 10,),
//                   TextFormField(
//                     controller: title3Details,
//                     decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(3),
//                         ),
//                         // focusedBorder: const OutlineInputBorder(
//                         //   borderSide: BorderSide(color:Colors.deepPurpleAccent)
//                         // ),
//                         labelText: "Title3 Details",
//                         labelStyle: const TextStyle(color: Colors.blue)
//                     ),
//                   ),
//                   SizedBox(height: 10,),
//                   TextFormField(
//                     controller: productTitle4,
//                     decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(3),
//                         ),
//                         // focusedBorder: const OutlineInputBorder(
//                         //   borderSide: BorderSide(color:Colors.deepPurpleAccent)
//                         // ),
//                         labelText: "Product Title4",
//                         labelStyle: const TextStyle(color: Colors.blue)
//                     ),
//                   ),
//                   SizedBox(height: 10,),
//                   TextFormField(
//                     controller: title4Details,
//                     decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(3),
//                         ),
//                         // focusedBorder: const OutlineInputBorder(
//                         //   borderSide: BorderSide(color:Colors.deepPurpleAccent)
//                         // ),
//                         labelText: "Title4 Details",
//                         labelStyle: const TextStyle(color: Colors.blue)
//                     ),
//                   ),
//                   SizedBox(height: 10,),
//                   TextFormField(
//                     controller: productDescription,
//                     decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(3),
//                         ),
//                         // focusedBorder: const OutlineInputBorder(
//                         //   borderSide: BorderSide(color:Colors.deepPurpleAccent)
//                         // ),
//                         labelText: "Product Discription",
//                         labelStyle: const TextStyle(color: Colors.blue)
//                     ),
//                   ),
//
//
//                 ],
//               ),
//
//               const SizedBox(height: 20,),
//
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () async {
//                     addProductToFirestore();
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(3),
//                     ),
//                   ),
//                   child: isLoading
//                       ? const CircularProgressIndicator(color: Colors.white,) // Show the progress indicator
//                       : const Text(
//                     "Add Product",style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class CategoryDropdown extends StatelessWidget {
//   final String? selectedCategory;
//   final ValueChanged<String?> onChanged;
//
//   const CategoryDropdown({required this.selectedCategory, required this.onChanged, Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: FirebaseFirestore.instance.collection('Categories').snapshots(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return const CircularProgressIndicator();
//         }
//
//         final categoryDocs = snapshot.data!.docs;
//         List<CategoryModel> categories = [];
//
//         for (var doc in categoryDocs) {
//           final category = CategoryModel.fromSnapshot(doc);
//           categories.add(category);
//         }
//
//         return DropdownButtonFormField<String>(
//           value: selectedCategory,
//           onChanged: onChanged,
//           decoration: const InputDecoration(
//             labelText: 'Select Category',
//             labelStyle: TextStyle(color: Colors.deepPurpleAccent),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.all(Radius.circular(3)),
//             ),
//           ),
//           items: categories.map((CategoryModel category) {
//             return DropdownMenuItem<String>(
//               value: category.category,
//               child: Text(
//                 category.category,
//                 style: const TextStyle(color: Colors.black),
//               ),
//             );
//           }).toList(),
//           validator: (value) {
//             if (value == null || value.isEmpty) {
//               return 'Please select a Category';
//             }
//             return null;
//           },
//         );
//
//
//       },
//
//
//     );
//   }
// }

import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Categories/CategoryModel.dart';
import '../SubCategory/SubCategoryModel.dart';

class AddProductsScreen extends StatefulWidget {
  const AddProductsScreen({super.key});

  @override
  State<AddProductsScreen> createState() => _AddProductsScreenState();
}

class _AddProductsScreenState extends State<AddProductsScreen> {
  String? selectedCategory;
  String? selectedSubCategory;
  bool isLoading = false;
  String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
  List<File> selectedImages = [];
  // String? imageUrl;

  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productPriceController = TextEditingController();
  final TextEditingController productDiscountController = TextEditingController();
  final TextEditingController productNewPriceController = TextEditingController();
  final TextEditingController productColorController = TextEditingController();
  final TextEditingController productTitle1Controller = TextEditingController();
  final TextEditingController productTitle1DetailController = TextEditingController();
  final TextEditingController productTitle2Controller = TextEditingController();
  final TextEditingController productTitle2DetailController = TextEditingController();
  final TextEditingController productTitle3Controller = TextEditingController();
  final TextEditingController productTitle3DetailController = TextEditingController();
  final TextEditingController productTitle4Controller = TextEditingController();
  final TextEditingController productTitle4DetailController = TextEditingController();
  final TextEditingController productDescriptionController = TextEditingController();
  final TextEditingController productAllDetailsController = TextEditingController();

  Future<bool> doesProductExist(String productName) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Products')
        .where('productName', isEqualTo: productName)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }

  Future<void> addProductToFirestore() async {
    final category = selectedCategory;
    final subCategory = selectedSubCategory;
    final productName = productNameController.text.trim();
    final productPrice = productPriceController.text.trim();
    final productDiscount = productDiscountController.text.trim();
    final productNewPrice = productNewPriceController.text.trim();
    final productColor = productColorController.text.trim();
    final productTitle1 = productTitle1Controller.text.trim();
    final productTitleDetail1 = productTitle1DetailController.text.trim();
    final productTitle2 = productTitle2Controller.text.trim();
    final productTitleDetail2 = productTitle2DetailController.text.trim();
    final productTitle3 = productTitle3Controller.text.trim();
    final productTitleDetail3 = productTitle3DetailController.text.trim();
    final productTitle4 = productTitle4Controller.text.trim();
    final productTitleDetail4 = productTitle4DetailController.text.trim();
    final productDescription = productDescriptionController.text.trim();
    final productAllDetails = productAllDetailsController.text.trim();

    if (category == null || category.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a category')),
      );
      return;
    }

    if (subCategory == null || subCategory.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a SubCategory")),
      );
      return;
    }

    if (productName.isEmpty ||
        productPrice.isEmpty ||
        productDiscount.isEmpty ||
        productNewPrice.isEmpty ||
        productColor.isEmpty ||
        productTitle1.isEmpty ||
        productTitleDetail1.isEmpty ||
        productTitle2.isEmpty ||
        productTitleDetail2.isEmpty ||
        productTitle3.isEmpty ||
        productTitleDetail3.isEmpty ||
        productTitle4.isEmpty ||
        productTitleDetail4.isEmpty ||
        productAllDetails.isEmpty ||
        productDescription.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please fill in all fields"),
      ));

      return;
    }

    final doesExist = await doesProductExist(productName);

    if (doesExist) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Product Already exist')));
    } else {
      setState(() {
        isLoading = true;
      });
      if (selectedImages.isNotEmpty) {
        Reference referenceRoot = FirebaseStorage.instance.ref();
        Reference referenceDirImages = referenceRoot.child('Product_Images');
        Reference referenceImageToUpload =
            referenceDirImages.child(uniqueFileName);

        try {
          for (var image in selectedImages) {
            await referenceImageToUpload.putFile(image);
          }
          final List<String> imageUrls = await Future.wait(selectedImages.map(
              (image) async => await referenceImageToUpload.getDownloadURL()));

          print('Image Urls:');
          for (var url in imageUrls) {
            log("url...$url");
          }

          FirebaseFirestore.instance.collection("Products").add({
            'category': category,
            'subCategory': subCategory,
            'productName': productName,
            'productPrice': productPrice,
            'productColor': productColor,
            'productDescription': productDescription,
            'productTitle1': productTitle1,
            'productTitle2': productTitle2,
            'productTitle3': productTitle3,
            'productTitle4': productTitle4,
            'productTitleDetail1': productTitleDetail1,
            'productTitleDetail2': productTitleDetail2,
            'productTitleDetail3': productTitleDetail3,
            'productTitleDetail4': productTitleDetail4,
            'productDiscount': productDiscount,
            'productNewPrice': productNewPrice,
            'images': imageUrls,
            'productAllDetails': productAllDetails,
          }).then((value) {
            selectedImages.clear();

            productNameController.clear();
            productPriceController.clear();
            productColorController.clear();
            productDescriptionController.clear();
            productTitle1Controller.clear();
            productTitle1DetailController.clear();
            productTitle2Controller.clear();
            productTitle2DetailController.clear();
            productTitle3Controller.clear();
            productTitle3DetailController.clear();
            productTitle4Controller.clear();
            productTitle4DetailController.clear();
            productDescriptionController.clear();
            productNewPriceController.clear();
            productAllDetailsController.clear();
            selectedCategory = null;
            selectedSubCategory = null;

            setState(() {
              isLoading = false;
            });

            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Product Added Successfully')));
          });
        } catch (error) {
          print("Error uploading images: $error");
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Please select images")));
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Products',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            children: [
              SizedBox(
                  height: 180,
                  width: 200,
                  child: selectedImages.isNotEmpty
                      ? ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: selectedImages.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.file(
                                selectedImages[index],
                                width: 200,
                                height: 100,
                              ),
                            );
                          },
                        )
                      : Image.asset(
                          "assets/blankImage.jpg",
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    ImagePicker imagePicker = ImagePicker();
                    List<XFile>? files = await imagePicker.pickMultiImage();

                    selectedImages =
                        files.map((file) => File(file.path)).toList();
                    setState(() {});
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent,
                  ),
                  child: const Text(
                    'Select Images',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CategoryDropdown(
                selectedCategory: selectedCategory,
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
              ),
              const SizedBox(
                height: 25,
              ),
              SubCategoryDropDown(
                selectedCategory: selectedCategory,
                selectedSubCategory: selectedSubCategory,
                onChanged: (value) {
                  setState(() {
                    selectedSubCategory = value;
                  });
                },
              ),
              const SizedBox(
                height: 25,
              ),
              TextFormField(
                controller: productNameController,
                decoration: InputDecoration(
                  hintText: 'Product Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    // borderSide: BorderSide(color: Colors.cyan),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              TextFormField(
                controller: productPriceController,
                decoration: InputDecoration(
                  hintText: 'Product Price',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    // borderSide: BorderSide(color: Colors.cyan),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              TextFormField(
                controller: productDiscountController,
                decoration: InputDecoration(
                  hintText: 'Discount',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    // borderSide: BorderSide(color: Colors.cyan),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              TextFormField(
                controller: productNewPriceController,
                decoration: InputDecoration(
                  hintText: 'Product New Price',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    // borderSide: BorderSide(color: Colors.cyan),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              TextFormField(
                controller: productColorController,
                decoration: InputDecoration(
                  hintText: 'Product Color',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    // borderSide: BorderSide(color: Colors.cyan),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              TextFormField(
                controller: productTitle1Controller,
                decoration: InputDecoration(
                  hintText: 'Product Title 1',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    // borderSide: BorderSide(color: Colors.cyan),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              TextFormField(
                controller: productTitle1DetailController,
                decoration: InputDecoration(
                  hintText: 'Title 1 detail',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    // borderSide: BorderSide(color: Colors.cyan),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              TextFormField(
                controller: productTitle2Controller,
                decoration: InputDecoration(
                  hintText: 'Product Title 2',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    // borderSide: BorderSide(color: Colors.cyan),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              TextFormField(
                controller: productTitle2DetailController,
                decoration: InputDecoration(
                  hintText: 'Title 2 detail',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    // borderSide: BorderSide(color: Colors.cyan),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              TextFormField(
                controller: productTitle3Controller,
                decoration: InputDecoration(
                  hintText: 'Product Title 3',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    // borderSide: BorderSide(color: Colors.cyan),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              TextFormField(
                controller: productTitle3DetailController,
                decoration: InputDecoration(
                  hintText: 'Title 3 detail',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    // borderSide: BorderSide(color: Colors.cyan),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              TextFormField(
                controller: productTitle4Controller,
                decoration: InputDecoration(
                  hintText: 'Product Title 4',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    // borderSide: BorderSide(color: Colors.cyan),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              TextFormField(
                controller: productTitle4DetailController,
                decoration: InputDecoration(
                  hintText: 'Title 4 detail',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    // borderSide: BorderSide(color: Colors.cyan),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              TextFormField(
                maxLines: 6,
                controller: productDescriptionController,
                decoration: InputDecoration(
                  hintText: 'Product Description',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    // borderSide: BorderSide(color: Colors.cyan),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              TextFormField(
                maxLines: 8,
                controller: productAllDetailsController,
                decoration: InputDecoration(
                  hintText: 'Product Details',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    // borderSide: BorderSide(color: Colors.cyan),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    addProductToFirestore();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurpleAccent),
                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          'Add Product',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryDropdown extends StatelessWidget {
  final String? selectedCategory;
  final ValueChanged<String?> onChanged;

  const CategoryDropdown(
      {required this.selectedCategory, required this.onChanged, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Categories').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          final categoryDocs = snapshot.data!.docs;
          List<CategoryModel> categories = [];

          for (var doc in categoryDocs) {
            final category = CategoryModel.fromSnapshot(doc);
            categories.add(category);
          }

          return DropdownButtonFormField<String>(
            value: selectedCategory,
            onChanged: onChanged,
            decoration: const InputDecoration(
                labelText: 'Select Category',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)))),
            items: categories.map((CategoryModel category) {
              return DropdownMenuItem<String>(
                value: category.category,
                child: Text(
                  category.category,
                  style: const TextStyle(color: Colors.black),
                ),
              );
            }).toList(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a Product';
              }
              return null;
            },
          );
        });
  }
}

class SubCategoryDropDown extends StatelessWidget {
  final String? selectedSubCategory;
  final String? selectedCategory;
  final ValueChanged<String?> onChanged;

  const SubCategoryDropDown(
      {required this.selectedSubCategory,
      required this.onChanged,
      required this.selectedCategory,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('SubCategories').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          final brandDocs = snapshot.data!.docs;
          List<SubCategoryModel> brands = [];

          for (var doc in brandDocs) {
            final brand = SubCategoryModel.fromSnapshot(doc);

            if (brand.category == selectedCategory) {
              brands.add(brand);
            }
          }
          return DropdownButtonFormField<String>(
            value: selectedSubCategory,
            onChanged: onChanged,
            decoration: const InputDecoration(
              labelText: 'Select SubCategory',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
            items: brands.map((SubCategoryModel brand) {
              return DropdownMenuItem<String>(
                value: brand.subCategory,
                child: Text(
                  brand.subCategory,
                  style: const TextStyle(color: Colors.black),
                ),
              );
            }).toList(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a Brand';
              }
              return null;
            },
          );
        });
  }
}

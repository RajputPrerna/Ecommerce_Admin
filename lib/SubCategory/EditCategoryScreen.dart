// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'dart:io';
//
// import 'SubCategoryModel.dart';
//
// class EditSubCategoryScreen extends StatefulWidget {
//   final SubCategoryModel category;
//   final String image;
//
//   EditSubCategoryScreen({Key? key, required this.category, required this.image})
//       : super(key: key);
//
//   @override
//   _EditSubCategoryScreenState createState() => _EditSubCategoryScreenState();
// }
//
// class _EditSubCategoryScreenState extends State<EditSubCategoryScreen> {
//   File? selectedImage;
//   TextEditingController categoryController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     categoryController.text = widget.category.category.trim();
//
//
//
//   }
//
//   Future<void> _updateCategory() async {
//     // Firestore reference to the category document
//     DocumentReference categoryRef =
//     FirebaseFirestore.instance.collection('SubCategories').doc(widget.category.id);
//
//     // Prepare the updated data
//     Map<String, dynamic> updatedData = {
//       'category': categoryController.text,
//     };
//
//
//     // Function to upload an image to Firebase Storage
//     Future<String> uploadImageToStorage(File imageFile) async {
//       Reference storageRef = FirebaseStorage.instance.ref().child('SubCategory_images/${widget.category.id}');
//       await storageRef.putFile(imageFile);
//       return await storageRef.getDownloadURL();
//     }
//
//
//     // Check if a new image has been selected
//     if (selectedImage != null) {
//       // Upload the new image to Firebase Storage
//       String imageUrl = await uploadImageToStorage(selectedImage!);
//       updatedData['image'] = imageUrl; // Update the image URL in Firestore
//     }
//
//     try {
//       // Update the category document in Firestore
//       await categoryRef.update(updatedData);
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Sub Category updated successfully'),
//           backgroundColor: Colors.green,
//         ),
//       );
//       setState(() {
//       });
//     } catch (error) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Failed to update sub category'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // automaticallyImplyLeading: false,
//         backgroundColor: Colors.green,
//         title: const Text('Edit Sub Category'),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
//           child: Column(
//             children: [
//               SizedBox(
//                 width: double.infinity,
//                 height: 45,
//                 child: TextFormField(
//                   controller: categoryController,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(3),
//                     ),
//                     labelText: 'Sub Category Name',
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 30),
//
//               selectedImage != null
//                   ? Image.file(selectedImage!, width: 200, height: 200)
//                   : Image.network(
//                 widget.image, // Display the current image
//                 width: 200,
//                 height: 200,
//               ),
//               const SizedBox(height: 30),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () async {
//                     ImagePicker imagePicker = ImagePicker();
//                     XFile? file = await imagePicker.pickImage(
//                       source: ImageSource.gallery,
//                     );
//
//                     if (file != null) {
//                       selectedImage = File(file.path);
//                       setState(() {
//
//                       });
//                     }
//                   },
//                   child: const Text('Select Image'),
//                 ),
//               ),
//               const SizedBox(height: 30),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () async {
//                     _updateCategory();
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.lightGreen,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(3),
//                     ),
//                   ),
//                   child: const Text(
//                     'Save',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'dart:io';
//
// import 'CategoryModel.dart';
//
// class EditCategoryScreen extends StatefulWidget {
//   final CategoryModel category;
//   final String image;
//   bool isLoading = false;
//
//   EditCategoryScreen({Key? key, required this.category, required this.image})
//       : super(key: key);
//
//   @override
//   _EditCategoryScreenState createState() => _EditCategoryScreenState();
// }
//
// class _EditCategoryScreenState extends State<EditCategoryScreen> {
//   File? selectedImage;
//   TextEditingController categoryController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//
//     categoryController.text = widget.category.category.trim();
//
//
//   }
//
//   Future<void> _updateCategory() async {
//
//     // Firestore reference to the category document
//     DocumentReference categoryRef =
//     FirebaseFirestore.instance.collection('Categories').doc(widget.category.id);
//
//
//     // Prepare the updated data
//     Map<String, dynamic> updatedData = {
//       'category': categoryController.text.trim(),
//
//
//     };
//
//
//
//
//     // Function to upload an image to Firebase Storage
//     Future<String> uploadImageToStorage(File imageFile) async {
//       Reference storageRef = FirebaseStorage.instance.ref().child('Category_images/${widget.category.id}');
//       await storageRef.putFile(imageFile);
//       return await storageRef.getDownloadURL();
//     }
//
//
//     // Check if a new image has been selected
//     if (selectedImage != null) {
//       // Upload the new image to Firebase Storage
//       String imageUrl = await uploadImageToStorage(selectedImage!);
//       updatedData['image'] = imageUrl; // Update the image URL in Firestore
//     }
//
//     try {
//       // Update the category document in Firestore
//       await categoryRef.update(updatedData);
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Category updated successfully'),
//           backgroundColor: Colors.green,
//         ),
//       );
//       setState(() {
//       });
//     } catch (error) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Failed to update category'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // automaticallyImplyLeading: false,
//         backgroundColor: Colors.green,
//         title: const Text('Edit Category'),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
//           child: Column(
//             children: [
//               SizedBox(
//                 width: double.infinity,
//                 height: 45,
//                 child: TextFormField(
//                   controller: categoryController,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(3),
//                     ),
//                     labelText: 'Category Name',
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 30),
//
//               selectedImage != null
//                   ? Image.file(selectedImage!, width: 200, height: 200)
//                   : Image.network(
//                 widget.image, // Display the current image
//                 width: 200,
//                 height: 200,
//               ),
//               const SizedBox(height: 30),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () async {
//                     ImagePicker imagePicker = ImagePicker();
//                     XFile? file = await imagePicker.pickImage(
//                       source: ImageSource.gallery,
//                     );
//
//                     if (file != null) {
//                       selectedImage = File(file.path);
//                       setState(() {
//
//                       });
//                     }
//                   },
//                   child: const Text('Select Image'),
//                 ),
//               ),
//               const SizedBox(height: 30),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () async {
//                     _updateCategory();
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.lightGreen,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(3),
//                     ),
//                   ),
//                   child: const Text(
//                     'Save',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import 'SubCategoryModel.dart';

class EditSubCategoryScreen extends StatefulWidget {
  final SubCategoryModel subCategory;
  final String image;
  bool isLoading = false;

  EditSubCategoryScreen({Key? key, required this.subCategory, required this.image})
      : super(key: key);

  @override
  EditSubCategoryScreenState createState() => EditSubCategoryScreenState();
}

class EditSubCategoryScreenState extends State<EditSubCategoryScreen> {
  File? selectedImage;
  TextEditingController subCategoryController = TextEditingController();

  @override
  void initState() {
    super.initState();

    subCategoryController.text = widget.subCategory.subCategory.trim();
  }

  Future<void> _updateSubCategory() async {
    // Trim leading and trailing whitespace from the category name
    String subCategoryName = subCategoryController.text.trim();

    // Check if the trimmed category name is empty
    if (subCategoryName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(' Sub Category name cannot be empty'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Firestore reference to the category document
    DocumentReference subCategoryRef =
    FirebaseFirestore.instance.collection('SubCategories').doc(widget.subCategory.id);

    // Prepare the updated data
    Map<String, dynamic> updatedData = {
      'subCategory': subCategoryName,
    };

    // Function to upload an image to Firebase Storage
    Future<String> uploadImageToStorage(File imageFile) async {
      Reference storageRef =
      FirebaseStorage.instance.ref().child('subCategory_images/${widget.subCategory.id}');
      await storageRef.putFile(imageFile);
      return await storageRef.getDownloadURL();
    }

    // Check if a new image has been selected
    if (selectedImage != null) {
      // Upload the new image to Firebase Storage
      String imageUrl = await uploadImageToStorage(selectedImage!);
      updatedData['image'] = imageUrl; // Update the image URL in Firestore
    }

    try {
      // Update the category document in Firestore
      await subCategoryRef.update(updatedData);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sub Category updated successfully'),
          backgroundColor: Colors.blue,
        ),
      );
      setState(() {});
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to update Sub category'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Edit Sub Category'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 45,
                child: TextFormField(
                  controller: subCategoryController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                    labelText: 'Sub Category Name',
                  ),
                ),
              ),
              const SizedBox(height: 30),
              selectedImage != null
                  ? Image.file(selectedImage!, width: 200, height: 200)
                  : Image.network(
                widget.image, // Display the current image
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    ImagePicker imagePicker = ImagePicker();
                    XFile? file = await imagePicker.pickImage(
                      source: ImageSource.gallery,
                    );

                    if (file != null) {
                      selectedImage = File(file.path);
                      setState(() {});
                    }
                  },
                  child: const Text('Select Image'),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    _updateSubCategory();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

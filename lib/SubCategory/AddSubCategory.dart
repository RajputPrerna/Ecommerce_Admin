import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../Categories/CategoryModel.dart';

class AddSubCategoryScreen extends StatefulWidget {
  const AddSubCategoryScreen({Key? key}) : super(key: key);

  @override
  State<AddSubCategoryScreen> createState() => _AddSubCategoryScreenState();
}

class _AddSubCategoryScreenState extends State<AddSubCategoryScreen> {

  TextEditingController categoryName = TextEditingController();
  TextEditingController subCategoryName = TextEditingController();
  String? selectedCategory;
  String uniquefilename = DateTime.now().millisecondsSinceEpoch.toString();
  String imageUrl = '';
  File? selectedImage;
  bool isLoading = false;
  String? subcategory;


  Future<bool> doesSubCategoryExist(String subCategoryName) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection("Categories")
        .where("Category", isEqualTo: subCategoryName)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }

  Future<void> addSubCategoryToFirestore() async {
    final category = selectedCategory;
    final subCategory = subCategoryName .text.trim();

    if (category == null || category.isEmpty) {
      // Show a toast message if the category is not selected
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a Category")),
      );
      return; // Stop the function execution
    }


    if (subCategory.isEmpty) {
      // Show a toast message if the subcategory name is empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a SubCategory name")),
      );
      return; // Stop the function execution
    }


    final doesExist = await doesSubCategoryExist(subCategory);

    if (doesExist) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("SubCategory already exists")),
      );
    } else {
      setState(() {
        isLoading = true;
      });

      if (selectedImage != null) {
        Reference referenceRoot = FirebaseStorage.instance.ref();
        Reference referenceDirImages = referenceRoot.child('SubCategory_images');
        Reference referenceImageToUpload = referenceDirImages.child(uniquefilename);
        try {
          await referenceImageToUpload.putFile(selectedImage!);
          imageUrl = await referenceImageToUpload.getDownloadURL();
          print("Image URL: $imageUrl");

          // Add category to Firestore only if an image is selected
          FirebaseFirestore.instance.collection("SubCategories").add({
            'category': category,
            'subCategory': subCategoryName.text,
            'image': imageUrl,
          }).then((value) {
            subCategoryName.clear();
            selectedImage = null;
            selectedCategory = null;
            setState(() {
              isLoading = false;
            });

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("SubCategory Added Successfully")),
            );
          });
        } catch (error) {
          print("Error uploading image: $error");
        }
      } else {
        // Display an error message or take appropriate action
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select an image")),
        );
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
        backgroundColor: Colors.blue,
        title: const Text('Add SubCategory',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white ),),
        elevation: 10,
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            children: [

              selectedImage != null
                  ? Image.file(selectedImage!, width: 200, height: 200, fit: BoxFit.cover,)
                  : Image.asset("assets/blankImage.jpg", width: 200, height: 200),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    ImagePicker imagePicker = ImagePicker();
                    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
                    if (file == null) return;
                    selectedImage = File(file.path);
                    setState(() {});
                  },
                  style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                  child: const Text("Select Image",style: TextStyle(color: Colors.blue),),
                ),
              ),
              const SizedBox(height: 20,),

              CategoryDropdown(
                selectedCategory: selectedCategory,
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
              ),


              const SizedBox(height: 20,),


              SizedBox(
                width: double.infinity,
                height: 45,
                child: TextFormField(
                  controller: subCategoryName,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                      // focusedBorder: const OutlineInputBorder(
                      //   borderSide: BorderSide(color:Colors.deepPurpleAccent)
                      // ),
                      labelText: "SubCategory Name",
                      labelStyle: const TextStyle(color: Colors.blue)
                  ),
                ),
              ),

              const SizedBox(height: 20,),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    addSubCategoryToFirestore();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white,) // Show the progress indicator
                      : const Text(
                    "Add SubCategory",style: TextStyle(color: Colors.white),
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

class CategoryDropdown extends StatelessWidget {
  final String? selectedCategory;
  final ValueChanged<String?> onChanged;

  const CategoryDropdown({required this.selectedCategory, required this.onChanged, Key? key}) : super(key: key);

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
            labelStyle: TextStyle(color: Colors.deepPurpleAccent),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(3)),
            ),
          ),
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
              return 'Please select a Category';
            }
            return null;
          },
        );
      },
    );
  }
}
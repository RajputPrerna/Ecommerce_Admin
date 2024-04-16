// ignore_for_file: file_names

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddBannerScreen extends StatefulWidget {
  const AddBannerScreen({Key? key}) : super(key: key);

  @override
  State<AddBannerScreen> createState() => _AddBannerScreenState();
}

class _AddBannerScreenState extends State<AddBannerScreen> {

  TextEditingController BannerName = TextEditingController();
  String uniquefilename = DateTime.now().millisecondsSinceEpoch.toString();
  String imageUrl = '';
  File? selectedImage;
  bool isLoading = false;

  // Function to check if the category already exists in Firestore
  Future<bool> doesBannerExist(String BannerName) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection("Banners")
        .where("Banner", isEqualTo: BannerName)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }

  Future<void> addBannerToFirestore() async {
    final banner = BannerName.text.trim();
    if (banner.isEmpty) {
      // Show a toast message if the category name is empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a Banner name")),
      );
      return; // Stop the function execution
    }


    final doesExist = await doesBannerExist(banner);

    if (doesExist) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Banner already exists")),
      );
    } else {
      setState(() {
        isLoading = true;
      });

      if (selectedImage != null) {
        Reference referenceRoot = FirebaseStorage.instance.ref();
        Reference referenceDirImages = referenceRoot.child('Banner_images');
        Reference referenceImageToUpload = referenceDirImages.child(uniquefilename);
        try {
          await referenceImageToUpload.putFile(selectedImage!);
          imageUrl = await referenceImageToUpload.getDownloadURL();
          print("Image URL: $imageUrl");

          // Add category to Firestore only if an image is selected
          FirebaseFirestore.instance.collection("Banner").add({
            'banner': BannerName.text,
            'image': imageUrl,
          }).then((value) {
            BannerName.clear();
            selectedImage = null;
            setState(() {
              isLoading = false;
            });

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Banner Added Successfully")),
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
        // elevation: 10,
        backgroundColor: Colors.blue,
        title: const Text('Add Banner',style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic, color: Colors.white),),
        centerTitle: true,
        // automaticallyImplyLeading: false,
        // backgroundColor: Colors.blueAccent,
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
                  controller: BannerName,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      // enabledBorder: OutlineInputBorder(
                      //   borderSide: BorderSide(color: Colors.deepPurpleAccent)
                      // ),
                      labelText: "Banner Name",
                      labelStyle: const TextStyle(color: Colors.blue)
                  ),
                ),
              ),




              const SizedBox(height: 30),
              selectedImage != null
                  ? Image.file(selectedImage!, width: 200, height: 200)
                  : Image.asset("assets/blankImage.jpg", width: 200, height: 200),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    ImagePicker imagePicker = ImagePicker();
                    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
                    if (file == null) return;
                    selectedImage = File(file.path);
                    setState(() {});
                  },style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                  child: const Text("Select Image", style: TextStyle(color: Colors.blue),),
                ),
              ),
              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    addBannerToFirestore();// Show the progress indicator
                  },
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.black,
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),


                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white,) // Show the progress indicator
                      : const Text(
                    "Add Banner",
                    style: TextStyle(fontSize: 16, color: Colors.white),
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


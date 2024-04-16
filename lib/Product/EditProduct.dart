// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'dart:io';
//
// import 'ProductModel.dart';
//
// class EditProductScreen extends StatefulWidget {
//   final ProductModel product;
//   final String images;
//
//   EditProductScreen({Key? key, required this.product, required this.images})
//       : super(key: key);
//
//   @override
//   _EditProductScreenState createState() => _EditProductScreenState();
// }
//
// class _EditProductScreenState extends State<EditProductScreen> {
//   File? selectedImage;
//   TextEditingController productController = TextEditingController();
//    TextEditingController productNameController = TextEditingController();
//    TextEditingController productPriceController = TextEditingController();
//    TextEditingController productDiscountController = TextEditingController();
//    TextEditingController productNewPriceController = TextEditingController();
//    TextEditingController productColorController = TextEditingController();
//    TextEditingController productTitle1Controller = TextEditingController();
//    TextEditingController productTitle1DetailController = TextEditingController();
//    TextEditingController productTitle2Controller = TextEditingController();
//    TextEditingController productTitle2DetailController = TextEditingController();
//    TextEditingController productTitle3Controller = TextEditingController();
//    TextEditingController productTitle3DetailController = TextEditingController();
//    TextEditingController productTitle4Controller = TextEditingController();
//    TextEditingController productDescriptionController = TextEditingController();
//    TextEditingController productAllDetailsController = TextEditingController();
//   TextEditingController productDetailsController = TextEditingController();
//
//
//   @override
//   void initState() {
//     super.initState();
//     productController.text = widget.product.productName;
//     productController.text = widget.product.productPrice;
//     productController.text = widget.product.discount;
//     productController.text = widget.product.newPrice;
//     productController.text = widget.product.product1;
//     productController.text = widget.product.title1;
//     productController.text = widget.product.product2;
//     productController.text = widget.product.title2;
//     productController.text = widget.product.product3;
//     productController.text = widget.product.title3;
//     productController.text = widget.product.product4;
//     productController.text = widget.product.title4;
//     productController.text = widget.product.productDescription;
//     productController.text = widget.product.color;
//     productController.text = widget.product.productDetails;
//     //productController.text = widget.product.productNe;
//
//
//
//
//   }
//
//   Future<void> _updateProduct() async {
//     // Firestore reference to the category document
//     DocumentReference productRef =
//     FirebaseFirestore.instance.collection('Products').doc(widget.product.id);
//
//     // Prepare the updated data
//     Map<String, dynamic> updatedData = {
//       'productName': productController.text.trim(),
//       'productPrice': productPriceController.text.trim(),
//       'discount': productDiscountController.text.trim(),
//       'newPrice': productNewPriceController.text.trim(),
//       'product1': productTitle1Controller.text.trim(),
//       'product1': productTitle1DetailController.text.trim(),
//
//       'product2': productTitle2Controller.text.trim(),
//       'product2': productTitle2DetailController.text.trim(),
//
//       'product3': productTitle3Controller.text.trim(),
//       'product3': productTitle3DetailController.text.trim(),
//
//       'product4': productTitle4Controller.text.trim(),
//       'product4': productAllDetailsController.text.trim(),
//
//       'color': productColorController.text.trim(),
//
//       'productDescription': productDescriptionController.text.trim(),
//       //'productDetails': productDetailsController.text.trim(),
//
//
//
//
//
//
//       //'productDiscount': productController.text.trim(),
//     };
//
//
//     // Function to upload an image to Firebase Storage
//     Future<String> uploadImageToStorage(File imageFile) async {
//       Reference storageRef = FirebaseStorage.instance.ref().child('Product_images/${widget.product.id}');
//       await storageRef.putFile(imageFile);
//       return await storageRef.getDownloadURL();
//     }
//
//
//     // Check if a new image has been selected
//     if (selectedImage != null) {
//       // Upload the new image to Firebase Storage
//       String imageUrl = await uploadImageToStorage(selectedImage!);
//       updatedData['images'] = imageUrl; // Update the image URL in Firestore
//     }
//
//     try {
//       // Update the category document in Firestore
//       await productRef.update(updatedData);
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Product updated successfully'),
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
//         title: const Text('Edit Product'),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
//           child: Column(
//             children: [
//               Column(
//                 children: [
//                   SizedBox(
//                     width: double.infinity,
//                     height: 45,
//                     child: TextFormField(
//                       controller: productController,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(3),
//                         ),
//                         labelText: 'Product Name',
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 15,
//                     width: 15,
//                   ),
//                   SizedBox(
//                     width: double.infinity,
//                     height: 45,
//                     child: TextFormField(
//                       controller: productPriceController,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(3),
//                         ),
//                         labelText: 'Product Price',
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 15,
//                     width: 15,
//                   ),
//                   SizedBox(
//                     width: double.infinity,
//                     height: 45,
//                     child: TextFormField(
//                       controller: productDiscountController,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(3),
//                         ),
//                         labelText: 'Product Discount',
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 15,
//                     width: 15,
//                   ),
//                   SizedBox(
//                     width: double.infinity,
//                     height: 45,
//                     child: TextFormField(
//                       controller: productNewPriceController,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(3),
//                         ),
//                         labelText: 'Product New Price',
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 15,
//                     width: 15,
//                   ),
//                   SizedBox(
//                     width: double.infinity,
//                     height: 45,
//                     child: TextFormField(
//                       controller: productColorController,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(3),
//                         ),
//                         labelText: 'Product Color',
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 15,
//                     width: 15,
//                   ),
//                   SizedBox(
//                     width: double.infinity,
//                     height: 45,
//                     child: TextFormField(
//                       controller: productTitle1Controller,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(3),
//                         ),
//                         labelText: 'Product Title1',
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 15,
//                     width: 15,
//                   ),
//                   SizedBox(
//                     width: double.infinity,
//                     height: 45,
//                     child: TextFormField(
//                       controller: productTitle1DetailController,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(3),
//                         ),
//                         labelText: 'Title 1 Detail',
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 15,
//                     width: 15,
//                   ),
//                   SizedBox(
//                     width: double.infinity,
//                     height: 45,
//                     child: TextFormField(
//                       controller: productTitle2Controller,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(3),
//                         ),
//                         labelText: 'Product Title2',
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 15,
//                     width: 15,
//                   ),
//                   SizedBox(
//                     width: double.infinity,
//                     height: 45,
//                     child: TextFormField(
//                       controller: productTitle2DetailController,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(3),
//                         ),
//                         labelText: 'Title2 Detail',
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 15,
//                     width: 15,
//                   ),
//                   SizedBox(
//                     width: double.infinity,
//                     height: 45,
//                     child: TextFormField(
//                       controller: productTitle3Controller,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(3),
//                         ),
//                         labelText: 'Product Title3',
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 15,
//                     width: 15,
//                   ),
//                   SizedBox(
//                     width: double.infinity,
//                     height: 45,
//                     child: TextFormField(
//                       controller: productTitle3DetailController,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(3),
//                         ),
//                         labelText: 'Title 3 Detail',
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 15,
//                     width: 15,
//                   ),
//                   SizedBox(
//                     width: double.infinity,
//                     height: 45,
//                     child: TextFormField(
//                       controller: productTitle4Controller,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(3),
//                         ),
//                         labelText: 'Product Title4',
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 15,
//                     width: 15,
//                   ),
//                   SizedBox(
//                     width: double.infinity,
//                     height: 45,
//                     child: TextFormField(
//                       controller: productAllDetailsController,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(3),
//                         ),
//                         labelText: 'Title 4 Detail',
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 15,
//                     width: 15,
//                   ),
//                   SizedBox(
//                     width: double.infinity,
//                     height: 45,
//                     child: TextFormField(
//                       controller: productDescriptionController,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(3),
//                         ),
//                         labelText: 'Product Descriptions',
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 15,
//                     width: 15,
//                   ),
//                   SizedBox(
//                     width: double.infinity,
//                     height: 45,
//                     child: TextFormField(
//                       controller: productDetailsController,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(3),
//                         ),
//                         labelText: 'Product Details',
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 15,
//                     width: 15,
//                   ),
//
//                 ],
//               ),
//               const SizedBox(height: 30),
//
//               selectedImage != null
//                   ? Image.file(selectedImage!, width: 200, height: 200)
//                   : Image.network(
//                 widget.images, // Display the current image
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
//                     _updateProduct();
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
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'ProductModel.dart';

class EditProduct extends StatefulWidget {
  final ProductModel product;
  final String images;
  EditProduct({
    Key? key,
    required this.product,
    required this.images,
  }) : super(key: key);

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  String? selectCategory;
  String? selectedSubCategory;
  String? selectedCategory;
  List<File>? selectedImage;
  String? selectedBrand;
  TextEditingController categoryController = TextEditingController();
  TextEditingController subCategoryController = TextEditingController();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  final TextEditingController title1Controller = TextEditingController();
  final TextEditingController product1Controller = TextEditingController();
  final TextEditingController title2Controller = TextEditingController();
  final TextEditingController product2Controller = TextEditingController();
  final TextEditingController title3Controller = TextEditingController();
  final TextEditingController product3Controller = TextEditingController();
  final TextEditingController title4Controller = TextEditingController();
  final TextEditingController product4Controller = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController newpriceController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    selectCategory = widget.product.category.toString();
    selectedSubCategory = widget.product.subCategory.toString();
    productNameController.text = widget.product.productName.toString();
    priceController.text = widget.product.productPrice.toString();
    colorController.text = widget.product.color.toString();
    title1Controller.text = widget.product.title1.toString();
    product1Controller.text = widget.product.product1.toString();
    title2Controller.text = widget.product.title2.toString();
    product2Controller.text = widget.product.product2.toString();
    title3Controller.text = widget.product.title3.toString();
    product3Controller.text = widget.product.product3.toString();
    title4Controller.text = widget.product.title4.toString();
    product4Controller.text = widget.product.product4.toString();
    descriptionController.text = widget.product.productDescription.toString();
    newpriceController.text = widget.product.newPrice.toString();
    discountController.text = widget.product.productDiscount.toString();
    final color = colorController.text.trim();
  }

  Future<void> _updateProduct() async {
    setState(() {
      isLoading = true;
    });

    DocumentReference productRef = FirebaseFirestore.instance
        .collection('Products')
        .doc(widget.product.id);

    List<String> imageUrls = [];

    if (selectedImage != null) {
      for (File imageFile in selectedImage!) {
        String imageUrl = await uploadImageToStorage(imageFile);
        imageUrls.add(imageUrl);
      }
    }

    Map<String, dynamic> updatedData = {
      'productName': productNameController.text,
      'price': priceController.text,
      'discount': discountController.text,
      'productNewPrice': newpriceController.text,
      'productColor': colorController.text,
      'productTitleDetail1': title1Controller.text,
      'productTitleDetail2': title2Controller.text,
      'productTitleDetail3': title3Controller.text,
      'productTitleDetail4': title4Controller.text,
      'productTitle1': product1Controller.text,
      'productTitle2': product2Controller.text,
      'productTitle3': product3Controller.text,
      'productTitle4': product4Controller.text,
      'productDescription': descriptionController.text,
      if (imageUrls.isNotEmpty) 'images': imageUrls,
    };

    try {
      await productRef.update(updatedData);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Product Edited Successfully'),
          backgroundColor: Colors.cyan,
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to update product'),
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<String> uploadImageToStorage(File imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageRef =
    FirebaseStorage.instance.ref().child('Product_images/$fileName');
    UploadTask uploadTask = storageRef.putFile(imageFile);
    TaskSnapshot storageSnapshot = await uploadTask.whenComplete(() => null);
    String downloadUrl = await storageSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Product',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              if (selectedImage != null && selectedImage!.isNotEmpty)
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: selectedImage!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 200, // Set a fixed width for each image
                          child: Image.file(selectedImage![index],
                              height: 200, width: 200),
                        ),
                      );
                    },
                  ),
                )
              else
                Image.network(
                  widget.images,
                  width: 200,
                  height: 200,
                ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    ImagePicker imagepicker = ImagePicker();
                    List<XFile>? files = await imagepicker.pickMultiImage();
                    if (files == null) return;
                    selectedImage =
                        files.map((file) => File(file.path)).toList();
                    setState(() {});
                  },
                  child: const Text(
                    'Select Images',
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: productNameController,
                decoration: InputDecoration(
                  labelText: 'Product Name',
                  labelStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.cyan),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: priceController,
                decoration: InputDecoration(
                  labelText: 'Price',
                  labelStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.cyan),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: discountController,
                decoration: InputDecoration(
                  labelText: 'Discount',
                  labelStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.cyan),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: newpriceController,
                decoration: InputDecoration(
                  labelText: 'New Price',
                  labelStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.cyan),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: colorController,
                decoration: InputDecoration(
                  labelText: 'Edit Color',
                  labelStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.cyan),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: title1Controller,
                decoration: InputDecoration(
                  labelText: 'Title 1',
                  labelStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.cyan),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: product1Controller,
                decoration: InputDecoration(
                  labelText: 'Product 1',
                  labelStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.cyan),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: title2Controller,
                decoration: InputDecoration(
                  labelText: 'Title 2',
                  labelStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.cyan),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: product2Controller,
                decoration: InputDecoration(
                  labelText: 'Product 2',
                  labelStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.cyan),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: title3Controller,
                decoration: InputDecoration(
                  labelText: 'Title 3',
                  labelStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.cyan),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: product3Controller,
                decoration: InputDecoration(
                  labelText: 'Product 3',
                  labelStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.cyan),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: title4Controller,
                decoration: InputDecoration(
                  labelText: 'Title 4',
                  labelStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.cyan),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: product4Controller,
                decoration: InputDecoration(
                  labelText: 'Product 4',
                  labelStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.cyan),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Edit Description',
                  labelStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.cyan),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    await _updateProduct();
                    setState(() {
                      isLoading = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
                  child: isLoading
                      ? const CircularProgressIndicator(
                    valueColor:
                    AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                      : const Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
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

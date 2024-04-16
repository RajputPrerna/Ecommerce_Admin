
import 'package:cloud_firestore/cloud_firestore.dart';

class SubCategoryModel {
  final String id; // Add the id field
  final String image;
  final String category;
  final String subCategory;

  SubCategoryModel(
      {required this.id, required this.category, required this.image,required this.subCategory});

  factory SubCategoryModel.fromSnapshot(DocumentSnapshot snapshot) {
    return SubCategoryModel(
      id: snapshot.id, // Assign the document ID to the id field
      category: snapshot['category'],
      image: snapshot['image'],
      subCategory: snapshot['subCategory'],
    );
  }
}


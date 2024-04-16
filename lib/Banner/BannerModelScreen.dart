// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class BannerModel {
  final String id; // Add the id field
  final String image;
  final String banner;

  BannerModel(
      {required this.id, required this.banner, required this.image});

  factory BannerModel.fromSnapshot(DocumentSnapshot snapshot) {
    return BannerModel(
      id: snapshot.id, // Assign the document ID to the id field
      banner: snapshot['banner'],
      image: snapshot['image'],
    );
  }
}


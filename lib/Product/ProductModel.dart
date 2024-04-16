// // ignore_for_file: file_names
//
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class ProductModel {
//   final String id; // Add the id field
//   List<String>? images;
//   final String category;
//   final String subCategory;
//
//   final String productName;
//   final String productPrice;
//   final String productDiscount;
//   final String productNewPrice;
//
//   final String productColor;
//   final String productTitle1;
//   final String productTitle1Detail1;
//
//   final String productTitle2;
//   final String productTitle1Detail2;
//
//   final String productTitle3;
//   final String productTitle1Detail3;
//
//   final String productTitle4;
//   final String productTitle1Detail4;
//
//   final String productDescription;
//   final String productAllDetails;
//
//   ProductModel(
//       {required this.id,
//       required this.category,
//       required this.subCategory,
//       required this.images,
//       required this.productName,
//       required this.productPrice,
//       required this.productNewPrice,
//       required this.productDiscount,
//       required this.productColor,
//       required this.productTitle1,
//       required this.productTitle1Detail1,
//       required this.productTitle2,
//       required this.productTitle1Detail2,
//       required this.productTitle3,
//       required this.productTitle1Detail3,
//       required this.productTitle4,
//       required this.productTitle1Detail4,
//       required this.productDescription,
//       required this.productAllDetails});
//
//   factory ProductModel.fromSnapshot(DocumentSnapshot snapshot) {
//     return ProductModel(
//       id: snapshot.id, // Assign the document ID to the id field
//       category: snapshot['category'],
//       subCategory: snapshot['subCategory'],
//
//       productName: snapshot['productName'],
//
//       images: snapshot['images'],
//
//       productPrice: snapshot['productPrice'],
//       productDiscount: snapshot['productDiscount'],
//       productNewPrice: snapshot['productNewPrice'],
//       productColor: snapshot['productColor'],
//       productTitle1: snapshot['productTitle1'],
//       productTitle1Detail1: snapshot['productTitle1Detail1'],
//
//       productTitle2: snapshot['productTitle2'],
//       productTitle1Detail2: snapshot['productTitle1Detail2'],
//
//       productTitle3: snapshot['productTitle3'],
//       productTitle1Detail3: snapshot['productTitle1Detail3'],
//
//       productTitle4: snapshot['productTitle4'],
//       productTitle1Detail4: snapshot['productTitle1Detail4'],
//
//       productDescription: snapshot['productDescription'],
//       productAllDetails: snapshot['productAllDetails'],
//     );
//   }
// }
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String id;
  List<String>? images;
  final String category;
  final String subCategory;
  final String productName;
  final String productPrice;
  final String color;
  final String productDescription;
  final String product1;
  final String product2;
  final String product3;
  final String product4;
  final String title1;
  final String title2;
  final String title3;
  final String title4;
  final String productDiscount;
  final String newPrice;
  final String productDetails;



  ProductModel({
    required this.id,
    required this.images,
    required this.category,
    required this.subCategory,
    required this.productName,
    required this.productPrice,
    required this.color,
    required this.productDescription,
    required this.product1,
    required this.product2,
    required this.product3,
    required this.product4,
    required this.title1,
    required this.title2,
    required this.title3,
    required this.title4,
    required this.productDiscount,
    required this.newPrice,
    required this.productDetails,

  });

  factory ProductModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return ProductModel(
      id: snapshot.id,
      category: data['category'] ?? '',
      subCategory: data['subCategory'] ?? '',
      images: List<String>.from(data['images'] ?? []),
      productName: data['productName'] ?? '',
      productPrice: data['productPrice'] ?? '',
      color: data['productColor'] ?? '',
      productDescription: data['productDescription'] ?? '',
      product1: data['productTitleDetail1'] ?? '',
      product2: data['productTitleDetail2'] ?? '',
      product3: data['productTitleDetail3'] ?? '',
      product4: data['productTitleDetail4'] ?? '',
      title1: data['productTitle1'] ?? '',
      title2: data['productTitle2'] ?? '',
      title3: data['productTitle3'] ?? '',
      title4: data['productTitle4'] ?? '',
      productDiscount: data['productDiscount'] ?? '',
      newPrice: data['productNewPrice'] ?? '',
      productDetails: data['productDetails'] ?? '',
    );
  }
}




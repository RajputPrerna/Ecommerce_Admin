// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';
// // import 'package:fluttertoast/fluttertoast.dart';
// //
// // import 'AddCategoryScreen.dart';
// // import 'CategoryModel.dart';
// // import 'EditCategoryScreen.dart';
// // //import 'ProductScreen.dart';
// //
// //
// // class CategoryScreen extends StatefulWidget {
// //   const CategoryScreen({super.key});
// //
// //   @override
// //   State<CategoryScreen> createState() => _CategoryScreenState();
// // }
// //
// // class _CategoryScreenState extends State<CategoryScreen> {
// //
// //
// //   void _deleteCategory(String categoryID) {
// //     FirebaseFirestore.instance
// //         .collection('Categories')
// //         .doc(categoryID)
// //         .delete()
// //         .then((value) {
// //       // Show a toast message when a category is deleted successfully
// //       Fluttertoast.showToast(
// //         msg: 'Category deleted successfully',
// //         toastLength: Toast.LENGTH_SHORT,
// //         gravity: ToastGravity.BOTTOM,
// //         backgroundColor: Colors.green,
// //         textColor: Colors.white,
// //       );
// //     }).catchError((error) {
// //       // Show a toast message when there is an error deleting the category
// //       Fluttertoast.showToast(
// //         msg: 'Failed to delete category',
// //         toastLength: Toast.LENGTH_SHORT,
// //         gravity: ToastGravity.BOTTOM,
// //         backgroundColor: Colors.red,
// //         textColor: Colors.white,
// //       );
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     var buttonBorderColor;
// //     return Scaffold(
// //       appBar: AppBar(
// //         backgroundColor: Colors.green,
// //         title: const Text('All Categories', style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: Colors.white),),
// //         centerTitle: true,
// //       ),
// //       body: SingleChildScrollView(
// //         child: Padding(
// //           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               const SizedBox(
// //                 height: 10,
// //               ),
// //               Row(
// //                 children: [
// //                   ElevatedButton(
// //                     onPressed: () {
// //                       Navigator.push(
// //                           context,
// //                           MaterialPageRoute(
// //                               builder: (context) => const AddCategoryScreen()));
// //                     },
// //                     style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(5),), backgroundColor: Colors.green),
// //                     child: const Text('Add Category',
// //                         style: TextStyle(fontSize: 13, color: Colors.white)),
// //                   ),
// //
// //
// //                 ],
// //               ),
// //               const SizedBox(
// //                 height: 10,
// //               ),
// //               Container(
// //                 width: double.infinity,
// //                 height: 40,
// //                 decoration: BoxDecoration(
// //                   borderRadius: BorderRadius.circular(20),
// //                   border: Border.all(color: buttonBorderColor),
// //                 ),
// //                 child: Padding(
// //                   padding: const EdgeInsets.only(left: 10, right: 10, top: 17),
// //                   child: TextFormField(
// //                     decoration: const InputDecoration(
// //                       border: InputBorder.none,
// //                       hintText: 'Search Categories',
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //               const SizedBox(
// //                 height: 10,
// //               ),
// //               const Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                 children: [
// //                   Text(
// //                     'Serial No',
// //                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
// //                   ),
// //                   Text(
// //                     'Category Name',
// //                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
// //                   ),
// //                   SizedBox(
// //                     width: 10,
// //                   ),
// //                   Text(
// //                     'Category Image',
// //                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
// //                   ),
// //                 ],
// //               ),
// //               CategoryListWidget(deleteCategory: _deleteCategory),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // class CategoryListWidget extends StatelessWidget {
// //   final Function(String) deleteCategory; // Callback function
// //
// //   const CategoryListWidget({super.key, required this.deleteCategory});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return StreamBuilder<QuerySnapshot>(
// //       stream: FirebaseFirestore.instance.collection('Categories').snapshots(),
// //       builder: (context, snapshot) {
// //         if (!snapshot.hasData) {
// //           return const CircularProgressIndicator();
// //         }
// //         final categoryDocs = snapshot.data!.docs;
// //         List<CategoryModel> categories = [];
// //
// //         for (var doc in categoryDocs) {
// //           final category = CategoryModel.fromSnapshot(doc);
// //           categories.add(category);
// //         }
// //
// //         return ListView.builder(
// //           shrinkWrap: true,
// //           physics: const NeverScrollableScrollPhysics(),
// //           itemCount: categories.length,
// //           itemBuilder: (context, index) {
// //             final category = categories[index];
// //             var buttonBorderColor;
// //             return Padding(
// //               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: <Widget>[
// //                   Row(
// //                     children: [
// //                       Text((index + 1).toString()),
// //                       const Spacer(),
// //                       Text(category.category),
// //                       const Spacer(),
// //                       Image.network(category.image, width: 100, height: 30),
// //                     ],
// //                   ),
// //                   const SizedBox(
// //                     height: 10,
// //                   ),
// //                   Row(
// //                     // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                     mainAxisAlignment: MainAxisAlignment.end,
// //                     children: [
// //                       Container(
// //                           width: 70,
// //                           height: 35,
// //                           decoration: BoxDecoration(
// //                             border: Border.all(color: buttonBorderColor),
// //                             borderRadius: BorderRadius.circular(20.0),
// //                           ),
// //                           child: TextButton(onPressed: () {
// //                             Navigator.push(context, MaterialPageRoute(builder: (context) =>   EditCategoryScreen(category: category, image: category.image)));
// //                           }, child: const Text('Edit', style: TextStyle(fontSize: 12),),
// //
// //                           )
// //                       ),
// //
// //                       const SizedBox(width: 100,),
// //
// //                       Container(
// //                         width: 70,
// //                         height: 35,
// //                         decoration: BoxDecoration(
// //                           border: Border.all(color: buttonBorderColor),
// //                           borderRadius: BorderRadius.circular(20.0),
// //                         ),
// //                         child: TextButton(
// //                           onPressed: () {
// //                             // Show a confirmation dialog
// //                             showDialog(
// //                               context: context,
// //                               builder: (BuildContext context) {
// //                                 return AlertDialog(
// //                                   title: const Text('Confirm Deletion'),
// //                                   content: const Text(
// //                                       'Are you sure you want to delete this category?'),
// //                                   actions: [
// //                                     TextButton(
// //                                       onPressed: () {
// //                                         // Dismiss the dialog
// //                                         Navigator.of(context).pop();
// //                                       },
// //                                       child: const Text('Cancel'),
// //                                     ),
// //                                     TextButton(
// //                                       onPressed: () {
// //                                         // Delete the category and dismiss the dialog
// //                                         deleteCategory(category.id);
// //                                         Navigator.of(context).pop();
// //                                       },
// //                                       child: const Text('Yes'),
// //                                     ),
// //                                   ],
// //                                 );
// //                               },
// //                             );
// //                           },
// //                           child: const Text('Delete',
// //                               style: TextStyle(fontSize: 12)),
// //                         ),
// //                       )
// //                     ],
// //                   ),
// //                 ],
// //               ),
// //             );
// //           },
// //         );
// //       },
// //     );
// //   }
// // }
// //
//
//
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// import 'AddProductScreen.dart';
// import 'EditProductScreen.dart';
// import 'ProductModel.dart';
//
// class ProductScreen extends StatefulWidget {
//   const ProductScreen({Key? key}) : super(key: key);
//
//   @override
//   State<ProductScreen> createState() => _ProductScreenState();
// }
//
// class _ProductScreenState extends State<ProductScreen> {
//   late TextEditingController searchController;
//   late String searchQuery;
//
//   @override
//   void initState() {
//     super.initState();
//     searchController = TextEditingController();
//     searchQuery = '';
//   }
//
//   void _deleteProduct(String productID) {
//     FirebaseFirestore.instance
//         .collection('Products')
//         .doc(productID)
//         .delete()
//         .then((value) {
//       // Show a toast message when a category is deleted successfully
//       Fluttertoast.showToast(
//         msg: 'Product deleted successfully',
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         backgroundColor: Colors.green,
//         textColor: Colors.white,
//       );
//     }).catchError((error) {
//       // Show a toast message when there is an error deleting the category
//       Fluttertoast.showToast(
//         msg: 'Failed to delete Product',
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
//     SingleChildScrollView();
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         title: Text(
//           'Product',
//           style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, color: Colors.white),
//         ),
//
//         centerTitle: true,
//         actions: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: FloatingActionButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const AddProductsScreen(),
//                   ),
//                 );
//               },
//               backgroundColor: Colors.black,
//               tooltip: 'Add Product',
//               child: Icon(Icons.add,color: Colors.white,),
//             ),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 10),
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 border: Border.all(color: Colors.blue),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: TextFormField(
//                   controller: searchController,
//                   onChanged: (value) {
//                     setState(() {
//                       searchQuery = value;
//                     });
//                   },
//                   decoration: InputDecoration(
//                     border: InputBorder.none,
//                     hintText: 'Search Products ...',
//                     hintStyle: TextStyle(color: Colors.blue),
//                     suffixIcon: Icon(Icons.search, color: Colors.blue),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             Expanded(
//               child: ProductListWidget(deleteProduct: _deleteProduct, searchQuery: searchQuery),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
// class ProductListWidget extends StatelessWidget {
//   final Function(String) deleteProduct;
//   final String searchQuery;
//
//   const ProductListWidget({Key? key, required this.deleteProduct, required this.searchQuery}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance.collection('Products').snapshots(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return Center(child: CircularProgressIndicator());
//         }
//         final productDocs = snapshot.data!.docs;
//         List<ProductModel> products = [];
//
//         for (var doc in productDocs) {
//           final product = ProductModel.fromSnapshot(doc);
//           products.add(product);
//         }
//
//         // Filter categories based on the search query
//         List<ProductModel> filteredProducts = products
//             .where((product) => product.productName.toLowerCase().contains(searchQuery.toLowerCase()))
//             .toList();
//
//         return ListView.builder(
//           itemCount: filteredProducts.length,
//           itemBuilder: (context, index) {
//             final product = filteredProducts[index];
//             return ProductCard(
//               product: product,
//               onDelete: () => _showDeleteDialog(context, product.id),
//               onEdit: () => _navigateToEditScreen(context, product),
//             );
//           },
//         );
//       },
//     );
//   }
//
//   void _showDeleteDialog(BuildContext context, String productId) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Confirm Deletion'),
//           content: Text('Are you sure you want to delete this product?'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 deleteProduct(productId);
//                 Navigator.of(context).pop();
//               },
//               child: Text('Yes'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   void _navigateToEditScreen(BuildContext context, ProductModel product) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => EditProductScreen(product: product, image: product.images),
//       ),
//     );
//   }
// }
//
// class ProductCard extends StatelessWidget {
//   final ProductModel product;
//   final VoidCallback onDelete;
//   final VoidCallback onEdit;
//
//   const ProductCard({
//     Key? key,
//     required this.product,
//     required this.onDelete,
//     required this.onEdit,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 2,
//       margin: EdgeInsets.symmetric(vertical: 8),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(product.productName, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             SizedBox(height: 8),
//             Image.network(product.images, width: double.infinity, height: 150,),
//             SizedBox(height: 8),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 TextButton(
//                   onPressed: onEdit,
//                   child: Text('Edit', style: TextStyle(color: Colors.blue)),
//                 ),
//                 SizedBox(width: 16),
//                 TextButton(
//                   onPressed: onDelete,
//                   child: Text('Delete', style: TextStyle(color: Colors.red)),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'AddProductScreen.dart';
import 'EditProduct.dart';
import 'ProductModel.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late TextEditingController searchController;
  late String searchQuery;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    searchQuery = '';
  }

  void _deleteProduct(String productID) {
    FirebaseFirestore.instance
        .collection('Products')
        .doc(productID)
        .delete()
        .then((value) {
      Fluttertoast.showToast(
        msg: 'Product deleted successfully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    }).catchError((error) {
      Fluttertoast.showToast(
        msg: 'Failed to delete Product',
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
        title: const Text(
          'Product',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddProductsScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
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
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search Product ...',
                    hintStyle: TextStyle(color: Colors.blue),
                    suffixIcon: Icon(
                      Icons.search,
                      color: Colors.blue
                      ,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ProductListWidget(
                deleteProduct: _deleteProduct,
                searchQuery: searchQuery,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductListWidget extends StatelessWidget {
  final Function(String) deleteProduct;
  final String searchQuery;

  const ProductListWidget({
    Key? key,
    required this.deleteProduct,
    required this.searchQuery,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Products').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final productDocs = snapshot.data!.docs;
        List<ProductModel> products = [];

        for (var doc in productDocs) {
          final product = ProductModel.fromSnapshot(doc);
          products.add(product);
        }

        List<ProductModel> filteredProducts = products
            .where((product) =>
            product.productName.toLowerCase().contains(
              searchQuery.toLowerCase(),
            ))
            .toList();

        return ListView.builder(
          itemCount: filteredProducts.length,
          itemBuilder: (context, index) {
            final ProductModel product = filteredProducts[index];
            String imageUrl =
            product.images!.isNotEmpty ? product.images![0] : '';

            return Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: InkWell(
                onTap: () {
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          imageUrl,
                          width: 80,
                          height: 80,
                          // fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.productName,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Index: ${(index + 1).toString()}',
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> EditProduct(product: product, images: imageUrl)));
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              _showDeleteDialog(context, product);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showDeleteDialog(BuildContext context, ProductModel product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text(
            'Are you sure you want to delete this product?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                deleteProduct(product.id);
                Navigator.of(context).pop();
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}


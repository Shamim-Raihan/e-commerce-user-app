import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';
import '../providers/product_provider.dart';
import '../utils/constants.dart';
import '../utils/helper_functions.dart';

class ProductDetailsPage extends StatelessWidget {
  static const String routeName = '/product_details';

  const ProductDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pid = ModalRoute.of(context)!.settings.arguments as String;
    final provider = Provider.of<ProductProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: provider.getProductById(pid),
        builder: (context, snapshot) {
          print('new snapshot');
          if (snapshot.hasData) {
            final product = ProductModel.fromMap(snapshot.data!.data()!);
            return ListView(
              children: [
                FadeInImage.assetNetwork(
                  placeholder: 'images/placeholder.jpg',
                  image: product.imageUrl!,
                  fadeInCurve: Curves.bounceInOut,
                  fadeInDuration: const Duration(seconds: 3),
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
                ListTile(
                  title: Text(product.name!),
                ),
                ListTile(
                  title: Text('$currencySymbol${product.salesPrice}'),
                ),
                ListTile(
                  title: const Text('Product Description'),
                  subtitle: Text(product.description ?? 'Not Available'),

                ),
              ],
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('Failed'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),

    );
  }
}

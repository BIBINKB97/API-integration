import 'package:api/model/product_model.dart';
import 'package:api/model/user_model.dart';
import 'package:api/services/product_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final UserModel? user;
  const HomePage({super.key, this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ProductService _productService = ProductService();

  @override
  void initState() {
    _productService.getAllProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Hi ${widget.user!.username}"),
        ),
        body: FutureBuilder(
            future: _productService.getAllProducts(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final ProductModel productmodel = snapshot.data!;
                final products = productmodel.products;

                return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemCount: products!.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return Card(
                          child: Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(product.images![0]),
                            ),
                            title: Text("${product.title}"),
                            subtitle: Text("${product.rating}"),
                          ),
                          Text(product.description!)
                        ],
                      ));
                    });
              }
              return Center(child: CircularProgressIndicator());
            }));
  }
}

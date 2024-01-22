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

                return ListView.separated(
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        endIndent: 10,
                        indent: 10,
                      );
                    },
                    itemCount: products!.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ListTile(
                        leading: Container(
                          width: 90,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(product.images![0]))),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.brand!,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            ),
                            Text(
                              product.title!,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              product.description!,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        trailing: Padding(
                          padding: EdgeInsets.only(bottom: 35.0),
                          child: Icon(Icons.favorite),
                        ),
                      );
                    });
              }
              return Center(child: CircularProgressIndicator());
            }));
  }
}

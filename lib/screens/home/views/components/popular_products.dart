import 'package:flutter/material.dart';

import '../../../../components/product/product_card.dart';
import '../../../../constants.dart';
import '../../../../data_models/product.dart';
import '../../../../models/product_model.dart';
import '../../../../route/route_constants.dart';
import '../../../../services/product-service.dart';


class PopularProducts extends StatefulWidget {

  const PopularProducts({super.key});

  @override
  _PopularProductsState createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {

  final ProductService productService = ProductService();
  late Future<List<Product>> productFuture;

  @override
  void initState() {
    super.initState();
    productFuture = productService.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
        future: productFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No products found'));
          }

          List<Product> products = snapshot.data!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: defaultPadding / 2),
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Text(
                  "Popular products",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              // While loading use 👇
              // const ProductsSkelton(),
              SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(
                      left: defaultPadding,
                      right: index == products.length - 1
                          ? defaultPadding
                          : 0,
                    ),
                    child: ProductCard(
                      image: products[index].image,
                      brandName: products[index].category,
                      title: products[index].title,
                      price: products[index].price,
                      priceAfetDiscount: products[index].price,
                      dicountPercent: 75,
                      press: () {
                        Navigator.pushNamed(context, productDetailsScreenRoute, arguments: {'productId': products[index].id});
                      },
                    ),
                  ),
                ),
              )
            ],
          );
        }
    );
  }
}
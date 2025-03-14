import 'package:flutter/material.dart';
import 'package:shop/services/product-service.dart';

import '../../../components/Banner/S/banner_s_style_1.dart';
import '../../../components/Banner/S/banner_s_style_5.dart';
import '../../../constants.dart';
import '../../../data_models/product.dart';
import '../../../route/route_constants.dart';
import 'components/best_sellers.dart';
import 'components/flash_sale.dart';
import 'components/most_popular.dart';
import 'components/offer_carousel_and_categories.dart';
import 'components/popular_products.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

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

          return Scaffold(
            body: SafeArea(
              child: CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                      child: OffersCarouselAndCategories()),
                  const SliverToBoxAdapter(child: PopularProducts()),
                  const SliverPadding(
                    padding: EdgeInsets.symmetric(
                        vertical: defaultPadding * 1.5),
                    sliver: SliverToBoxAdapter(child: FlashSale()),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        // While loading use 👇
                        // const BannerMSkelton(),‚
                        BannerSStyle1(
                          title: "New \narrival",
                          subtitle: "SPECIAL OFFER",
                          discountParcent: 50,
                          press: () {
                            Navigator.pushNamed(context, onSaleScreenRoute);
                          },
                        ),
                        const SizedBox(height: defaultPadding / 4),
                        // We have 4 banner styles, all in the pro version
                      ],
                    ),
                  ),
                  const SliverToBoxAdapter(child: MostPopular()),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        const SizedBox(height: defaultPadding * 1.5),

                        const SizedBox(height: defaultPadding / 4),
                        // While loading use 👇
                        // const BannerSSkelton(),
                        BannerSStyle5(
                          title: "Black \nfriday",
                          subtitle: "50% Off",
                          bottomText: "Collection".toUpperCase(),
                          press: () {
                            Navigator.pushNamed(context, onSaleScreenRoute);
                          },
                        ),
                        const SizedBox(height: defaultPadding / 4),
                      ],
                    ),
                  ),
                  const SliverToBoxAdapter(child: BestSellers()),
                ],
              ),
            ),
          );
        }
    );
  }
}
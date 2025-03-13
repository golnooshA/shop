import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../components/cart_button.dart';
import '../../../components/custom_modal_bottom_sheet.dart';
import '../../../constants.dart';
import '../../../data_models/product.dart';
import '../../../services/product-service.dart';
import 'components/product_images.dart';
import 'components/product_info.dart';
import 'components/product_list_tile.dart';
import '../../../components/review_card.dart';
import 'product_buy_now_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int productId;

  const ProductDetailsScreen({super.key, required this.productId});

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ProductService productService = ProductService();
  late Future<Product> productFuture;

  @override
  void initState() {
    super.initState();
    productFuture = productService.getProduct(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<Product>(
          future: productFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData) {
              return Center(child: Text("Product not found"));
            }

            Product product = snapshot.data!;

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  floating: true,
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        "assets/icons/Bookmark.svg",
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                      ),
                    ),
                  ],
                ),
                ProductImages(images: [product.image]), // Display product image
                ProductInfo(
                  brand: product.category, // Using category as brand placeholder
                  title: product.title,
                  isAvailable: true,
                  description: product.description,
                  rating: product.rating.rate,
                  numOfReviews: product.rating.count,
                ),
                ProductListTile(
                  svgSrc: "assets/icons/Product.svg",
                  title: "Product Details",
                  press: () {
                    customModalBottomSheet(
                      context,
                      height: MediaQuery.of(context).size.height * 0.92,
                      child: const Text("Product Details Screen"),
                    );
                  },
                ),
                ProductListTile(
                  svgSrc: "assets/icons/Delivery.svg",
                  title: "Shipping Information",
                  press: () {
                    customModalBottomSheet(
                      context,
                      height: MediaQuery.of(context).size.height * 0.92,
                      child: const Text("Shipping Information Screen"),
                    );
                  },
                ),
                ProductListTile(
                  svgSrc: "assets/icons/Return.svg",
                  title: "Returns",
                  isShowBottomBorder: true,
                  press: () {
                    customModalBottomSheet(
                      context,
                      height: MediaQuery.of(context).size.height * 0.92,
                      child: const Text("Return Policy Screen"),
                    );
                  },
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: ReviewCard(
                      rating: product.rating.rate,
                      numOfReviews: product.rating.count,
                      numOfFiveStar: (product.rating.count * 0.6).toInt(),
                      numOfFourStar: (product.rating.count * 0.3).toInt(),
                      numOfThreeStar: (product.rating.count * 0.05).toInt(),
                      numOfTwoStar: (product.rating.count * 0.03).toInt(),
                      numOfOneStar: (product.rating.count * 0.02).toInt(),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: CartButton(
        price: 140,
        press: () {
          customModalBottomSheet(
            context,
            height: MediaQuery.of(context).size.height * 0.92,
            child: const ProductBuyNowScreen(),
          );
        },
      ),
    );
  }
}

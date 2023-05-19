import 'package:clippy_flutter/arc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/views/widgets/product_details_widgets/increase_decrease_item.dart';
import 'package:shop_app/views/widgets/product_details_widgets/show_product_attributes.dart';
import '../../../providers/cart_provider.dart';
import '../../../providers/products_provider.dart';
import '../../widgets/home_widgets/item_app_bar.dart';
import '../../widgets/product_details_widgets/item_botton_nav_bar.dart';

class ProductDetailScreen extends StatefulWidget {
  static const routeName = '/product-detail';

  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  List<Color> colors = [
    Colors.brown,
    Colors.black,
    Colors.grey,
  ];

  final List<String> productAttribute = [
    'Type',
    'Gender',
    'Store',
    'Border',
    'Shape',
  ];

  var countOfProduct = 0;
  final _showAttributes = false;

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments!;
    final loadedProduct = Provider.of<Products>(context, listen: false)
        .findById(productId as String);
    
    final cart = Provider.of<Cart>(context, listen: false);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: ListView(
        children: [
          const ItemAppBar(),
          Padding(
            padding: const EdgeInsets.all(
              10,
            ),
            child: ImageSlideshow(
              width: double.infinity,
              height: 200,
              initialPage: 0,
              indicatorColor: Theme.of(context).colorScheme.primary,
              indicatorBackgroundColor: Colors.grey,
              onPageChanged: (value) {
                //print('Page changed: $value');
              },
              autoPlayInterval: 3000,
              isLoop: true,
              children: [
                for (int i = 0; i < 4; i++) ...[
                  Image.network(
                    loadedProduct.imageUrls![i],
                    fit: BoxFit.cover,
                  ),
                ],
              ],
            ),
          ),
          Arc(
            edge: Edge.TOP,
            arcType: ArcType.CONVEY,
            height: 30,
            child: Container(
              width: double.infinity,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 50,
                          ),
                          child: Text(
                            '\$${loadedProduct.price.toString()}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        bottom: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            loadedProduct.brand!.name!,
                            style: TextStyle(
                              fontSize: 28,
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          loadedProduct.model!,
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                for (int i = 0; i < colors.length; i++) ...[
                                  Container(
                                    height: 30,
                                    width: 30,
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: colors[i],
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 8,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ]),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RatingBar.builder(
                                itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                initialRating: 4,
                                minRating: 1,
                                direction: Axis.horizontal,
                                itemCount: 5,
                                itemSize: 20,
                                itemPadding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                onRatingUpdate: (index) {}),
                            const IncreaseDecreaseItem(),
                          ]),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const ShowProductAttributes(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const ItemBottomNavBar(),
    );
  }
}


/*
Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(loadedProduct.brand!),
              background: Hero(
                tag: loadedProduct.id!,
                child: Image.network(
                  loadedProduct.imageUrls![0],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(
                height: 10,
              ),
              Text(
                '\$${loadedProduct.price}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                child: Text(
                  '${loadedProduct.model}',
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),
            ]),
          ),
        ],
      ),
    );
*/
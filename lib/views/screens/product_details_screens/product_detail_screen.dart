import 'package:clippy_flutter/arc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/views/widgets/product_details_widgets/increase_decrease_item.dart';
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
  var countOfProduct = 0;
  bool _showAttributes = false;
  double productRating = 0;

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments!;
    final loadedProduct = Provider.of<Products>(context, listen: false)
        .findById(productId as int);
    return Consumer<Products>(builder: (ctx, prods, _) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        body: ListView(
          children: [
            const ItemAppBar(),
            Padding(
              padding: const EdgeInsets.all(
                10,
              ),
              child: imageSlider(),
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
                              '\$${prods.findById(productId as int).price.toString()}',
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
                              prods.findById(productId as int).brand!.name!,
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
                        child: productColor(),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Consumer<Products>(
                        builder: (ctx, prods, _) {
                          return Row(children: [
                            Text(
                                "Quantity in inventory: ${prods.inventoryQuantity}")
                          ]);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ratingStars(),
                            const IncreaseDecreaseItem(),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      showProductAttribute(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: const ItemBottomNavBar(),
      );
    });
  }

  Widget imageSlider() {
    final productId = ModalRoute.of(context)!.settings.arguments!;
    final loadedProduct = Provider.of<Products>(context, listen: false)
        .findById(productId as int);
    return ImageSlideshow(
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
        for (int i = 0; i < 1; i++) ...[
          Image.network(
            loadedProduct.imageUrls![i],
            fit: BoxFit.cover,
          ),
        ],
      ],
    );
  }

  Widget productColor() {
    Map<String, Color> mapColors = {
      'Brown': Colors.brown,
      'Black': Colors.black,
      'Red': Colors.red,
      'Grey': Colors.grey,
      'Blue': Colors.blue
    };

    final productId = ModalRoute.of(context)!.settings.arguments!;
    final loadedProduct = Provider.of<Products>(context, listen: false)
        .findById(productId as int);
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Row(
        children: [
          Container(
            height: 30,
            width: 30,
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(
              horizontal: 5,
            ),
            decoration: BoxDecoration(
              color: mapColors[loadedProduct.color],
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
      ),
    ]);
  }

  Widget ratingStars() {
    final productId = ModalRoute.of(context)!.settings.arguments!;
    final loadedProduct = Provider.of<Products>(context, listen: false)
        .findById(productId as int);
    return RatingBar.builder(
        itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
        initialRating: loadedProduct.rating!,
        minRating: 0,
        direction: Axis.horizontal,
        itemCount: 5,
        itemSize: 20,
        itemPadding: const EdgeInsets.symmetric(
          horizontal: 4,
        ),
        onRatingUpdate: (index) {
          Provider.of<Products>(context, listen: false)
              .updateRating(index.toInt(), productId);
        });
  }

  Widget showProductAttribute() {
    final productId = ModalRoute.of(context)!.settings.arguments!;
    final loadedProduct = Provider.of<Products>(context, listen: false)
        .findById(productId as int);
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  _showAttributes = !_showAttributes;
                });
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'DETAILS',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    size: 40,
                  ),
                ],
              ),
            ),
            Visibility(
              visible: _showAttributes,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 7,
                  vertical: 15,
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Type: ${loadedProduct.type}'),
                          Text('Gender: ${loadedProduct.gender}'),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Store: ${loadedProduct.store!.name}'),
                          Text('Border: ${loadedProduct.border}'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Shape: ${loadedProduct.shape}'),
                        ],
                      ),
                    ]),
              ),
            ),
          ],
        ),
        !_showAttributes
            ? const SizedBox(
                height: 100,
              )
            : const SizedBox(),
      ],
    );
  }
}

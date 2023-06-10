import 'package:flutter/material.dart';

class HelpingCenter extends StatelessWidget {
  const HelpingCenter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textStyle = const TextStyle(
        fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Help Center',
          style: textStyle,
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Text(
            'Introduction:',
            style: textStyle,
          ),
          const Text(
              'Welcome to the help center for our e-commerce website, which sells eye-glasses and includes a try-on feature. We understand that shopping online can be a new and unfamiliar experience for some customers, which is why we have created this documentation to help you with any questions or concerns you may have.'),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Getting Started:',
            style: textStyle,
          ),
          const Text(
              'Before using our e-commerce website, we recommend creating an account to ensure a smooth shopping experience. To create an account, simply click on the "sign up" button on the top right corner of the homepage and follow the prompts to provide your personal information. Once you have created an account, you will be able to browse and purchase products, save your favorite products, and access your order history.'),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Product Selection:',
            style: textStyle,
          ),
          const Text(
              'Our website offers a wide range of eyeglasses for men, women, and children. You can browse our products by gender, shape, color, and brand. To select a product, simply click on the product image and you will be directed to the product page. On the product page, you can view the product description, specifications, and price. You can also use the "try-on" feature to see how the glasses will look on your face.'),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Try-On Feature:',
            style: textStyle,
          ),
          const Text(
              'Our real-time try-on feature allows you to virtually try on our eyeglasses in real-time using your computer camera or mobile device. To use the try-on feature, simply click on the "try-on" button on the product page and follow the prompts to enable your camera. You can then adjust the glasses to fit your face and see how they look from different angles, all in real-time. This feature gives you a realistic preview of how the glasses will look on your face, so you can make an informed decision before making a purchase'),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Ordering:',
            style: textStyle,
          ),
          const Text(
              'To place an order, simply add the product to your cart and proceed to checkout. You will be asked to provide your shipping address, payment information, and any special instructions. Once your order is confirmed, you will receive an email with your order details and tracking information.'),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Shipping and Returns:',
            style: textStyle,
          ),
          const Text(
              'We offer free shipping on all orders within the United States. Your order will be processed within 2-3 business days and will arrive within 5-7 business days. We also offer a 30-day return policy for any products that are damaged or defective. To initiate a return, simply contact our customer service team and provide your order details.'),
        ]),
      ),
    );
  }
}

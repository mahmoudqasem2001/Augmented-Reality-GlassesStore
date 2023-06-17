import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/cache/cacheHelper.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/providers/stores_provider.dart';
import 'package:shop_app/views/screens/helping_center_screens/helping_center_screen.dart';
import 'package:shop_app/views/screens/account_screens/store_account_screen.dart';
import 'package:shop_app/views/screens/account_screens/customer_account_screen.dart';

import '../../../shared/constants/constants.dart';

class ProfileOptions extends StatelessWidget {
  const ProfileOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<Auth>(context, listen: false);
    final productsProvider = Provider.of<Products>(context, listen: false);
    final storesProvider = Provider.of<Stores>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(children: [
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            ),
          ),
          onPressed: () {
            if (userType == 'customer') {
              authProvider.fetchCustomerAccountInfo();
              Navigator.of(context).pushNamed(CustomerAccountScreen.routeName);
            } else if (userType == 'store') {
              authProvider.fetchStoreAccountInfo();
              productsProvider.getProductsByStoreId(authProvider.store.id!);
              storesProvider.getAllBrands();
              Navigator.of(context).pushNamed(StoreAccountScreen.routeName,
                  arguments: authProvider.store.id);
            }
          },
          child: const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Icon(
                  Icons.person,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Text(
                'My Account',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            ),
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HelpingCenter()));
          },
          child: const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Icon(
                  Icons.question_mark_outlined,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Text(
                'Help Center',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            ),
          ),
          onPressed: () async {
            Provider.of<Auth>(context, listen: false)
                .setLoadingIndicator(false);
            Provider.of<Auth>(context, listen: false).setAuthentucated(false);
            token = '';
            await CacheData.deleteItem(key: 'token');
          },
          child: const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Icon(
                  Icons.logout,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Text(
                'Log Out',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ]),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intro_screen_onboarding_flutter/introduction.dart';
import 'package:intro_screen_onboarding_flutter/introscreenonboarding.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/views/screens/auth_screen.dart';

import '../providers/auth_provider.dart';
import 'screens/home_screens/product_overview_screen.dart';
import 'splash_screen.dart';

class IntroScreen extends StatelessWidget {
  final List<Introduction> list = [
    Introduction(
      title: 'Buy & Sell',
      subTitle: 'Browse the menu and order directly from the application',
      imageUrl: 'assets/images/onboarding1.png',
    ),
    Introduction(
      title: 'Delivery',
      subTitle: 'Your order will be immediately collected and',
      imageUrl: 'assets/images/onboarding2.png',
    ),
    Introduction(
      title: 'Receive Money',
      subTitle: 'Pick up delivery at your door and enjoy groceries',
      imageUrl: 'assets/images/onboarding3.png',
    ),
  ];

  IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (ctx, auth, _) => auth.isAuth
          ? const ProductOverViewScreen()
          : FutureBuilder(
              future: auth.tryAutoLogin(),
              builder: (context, auhtSnapshot) =>
                  auhtSnapshot.connectionState == ConnectionState.waiting
                      ?const SplashScreen()
                      : IntroScreenOnboarding(
                          introductionList: list,
                          onTapSkipButton: () {
                            MaterialPageRoute(
                              builder: (context) => const AuthScreen(),
                            );
                          },
                          // foregroundColor: Colors.red,
                        ),
            ),
    );
  }
}

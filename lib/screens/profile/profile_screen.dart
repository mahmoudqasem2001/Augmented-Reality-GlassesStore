import 'package:flutter/material.dart';
import 'package:shop_app/widgets/auth/auth_dialog.dart';
import 'package:shop_app/widgets/profile/profile_options.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  static String routeName = '/profile';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/profile_mask.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Center(
              child: Column(
                children: [
                  const Text(
                    'Profile',
                    style: TextStyle(fontSize: 30),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const SizedBox(
                    height: 115,
                    width: 115,
                    child: CircleAvatar(
                      backgroundImage: AssetImage(
                        'assets/images/profile.png',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ProfileOptions(),
                ],
              ),
            ),
          ),
          AuthDialog(),
        ],
      ),
    );
  }
}

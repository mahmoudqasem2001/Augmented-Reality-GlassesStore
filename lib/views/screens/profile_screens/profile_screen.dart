import 'package:flutter/material.dart';
import 'package:shop_app/views/widgets/profile_widgets/profile_options.dart';

import '../../widgets/auth_common_widgets/auth_dialog.dart';

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
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/profile_mask.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Center(
              child: Column(
                children: [
                  Text(
                    'Profile',
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    height: 115,
                    width: 115,
                    child: CircleAvatar(
                      backgroundImage: AssetImage(
                        'assets/images/profile.png',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ProfileOptions(),
                ],
              ),
            ),
          ),
          const AuthDialog(),
        ],
      ),
    );
  }
}

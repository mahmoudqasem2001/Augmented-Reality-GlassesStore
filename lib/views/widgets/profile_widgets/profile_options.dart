import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/views/screens/helping_center_screens/helping_center_screen.dart';
import 'package:shop_app/views/screens/profile_screens/my_account_screen.dart';

class ProfileOptions extends StatelessWidget {
  const ProfileOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            Provider.of<Auth>(context, listen: false).fetchAccountInfo();
            Navigator.of(context).pushNamed(MyAccountScreen.routeName);
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
          onPressed: () {
            Provider.of<Auth>(context, listen: false).setAuthentucated(false);
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

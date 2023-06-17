import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth.dart';

class CustomerAccountScreen extends StatefulWidget {
  static const routeName = '/customer-account';

  const CustomerAccountScreen({Key? key}) : super(key: key);

  @override
  _CustomerAccountScreenState createState() => _CustomerAccountScreenState();
}

class _CustomerAccountScreenState extends State<CustomerAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('My Account'),
      ),
      body: Consumer<Auth>(builder: (context, auth, _) {
        final customerResponseData = auth.customer;
        if (customerResponseData.name == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Column(children: [
                      Text(
                        'Profile',
                        style: TextStyle(fontSize: 30),
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
                    ]),
                  ),
                  _buildAccountInfo('Name:', customerResponseData.name),
                  _buildAccountInfo(
                      'Phone Number:', customerResponseData.phoneNumber),
                  _buildAccountInfo('Gender:', customerResponseData.gender),
                  _buildAccountInfo(
                      'Country:', customerResponseData.address?.country),
                  _buildAccountInfo('City:', customerResponseData.address?.city),
                  _buildAccountInfo(
                      'City:', customerResponseData.address?.street),
                  _buildAccountInfo('ZIP:', customerResponseData.address?.zip),
                ],
              ),
            ),
          );
        }
      }),
    );
  }

  Widget _buildAccountInfo(String label, String? value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          width: double.infinity,
          padding: EdgeInsets.all(16.0),
          margin: EdgeInsets.only(bottom: 8.0),
          child: value == null
              ? Text('none')
              : Text(
                  value,
                  style: TextStyle(fontSize: 16),
                ),
        ),
      ],
    );
  }
}

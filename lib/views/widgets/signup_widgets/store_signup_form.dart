import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth.dart';
import '../../screens/home_screens/home_screen.dart';
import '../auth_common_widgets/form_error.dart';

class StoreSignUpForm extends StatefulWidget {
  const StoreSignUpForm({Key? key}) : super(key: key);

  @override
  _StoreSignUpFormState createState() => _StoreSignUpFormState();
}

class _StoreSignUpFormState extends State<StoreSignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final conformPassword = TextEditingController();
  final phoneNumber = TextEditingController();
  final country = TextEditingController();
  final city = TextEditingController();
  final street = TextEditingController();
  final zip = TextEditingController();

  final List<String?> errors = [];

  var selectedItem;

  _submit(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      Provider.of<Auth>(context, listen: false).setLoadingIndicator(false);
      return;
    }
    FocusScope.of(context).unfocus();
    _formKey.currentState!.save();

    final authProvider = Provider.of<Auth>(context, listen: false);

    authProvider.setLoadingIndicator(true);
    String message = " ";
    await Provider.of<Auth>(context, listen: false)
        .storeRegister(
            storeName: name.text,
            phoneNumber: '0' + phoneNumber.text,
            country: country.text,
            city: city.text,
            street: street.text,
            zip: zip.text,
            email: email.text,
            password: password.text)
        .then((value) => message = value);

    if (message != "success") {
      _showErrorDialog(message);
    }
  }

  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.redAccent,
        title: const Text('An Error Occurred!'),
        content: Text(errorMessage),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('okey!')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const String policyTerms =
        'By signing in, you agree to Store Terms of Service \nand acknowledge that your personal information will be\n processed in accordance with Store Privacy Policy.';
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildNameFormField(),
          const SizedBox(
            height: 30,
          ),
          buildEmailFormField(),
          const SizedBox(height: 30),
          buildPasswordFormField(),
          const SizedBox(height: 30),
          buildConformPassFormField(),
          const SizedBox(height: 30),
          buildPhoneNumberFormField(),
          const SizedBox(height: 20),
          // buildCountryFormField(),
          // const SizedBox(height: 30),
          // buildCityFormField(),
          // const SizedBox(height: 30),
          // buildStreetFormField(),
          // const SizedBox(height: 30),
          // buildZipFormField(),
          // const SizedBox(height: 20),
          FormError(errors: errors),
          const SizedBox(height: 40),
          const Text(
            policyTerms,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(
            height: 30,
          ),
          submitSignUpButton(),
        ],
      ),
    );
  }

  TextFormField buildNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      controller: name,
      validator: (value) {
        if (value!.isEmpty) {
          return "Your name must not be empty";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Name",
        hintText: "Enter Store's name",
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: Colors.black),
          gapPadding: 5,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          gapPadding: 5,
          borderSide: const BorderSide(color: Colors.black),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const Icon(Icons.person),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: email,
      validator: (value) {
        if (value!.isEmpty) {
          return "Email must not be empty";
        } else if (!value.contains('@')) {
          return "Please enter a valid email";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: Colors.black),
          gapPadding: 5,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          gapPadding: 5,
          borderSide: const BorderSide(color: Colors.black),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const Icon(Icons.email),
      ),
    );
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: true,
      controller: conformPassword,
      validator: (value) {
        if (value!.isEmpty) {
          return "password must not be empty";
        } else if (conformPassword.text != password.text) {
          return "Paswords does not matched";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Confirm Password",
        hintText: "Re-enter your password",
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: Colors.black),
          gapPadding: 5,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          gapPadding: 5,
          borderSide: const BorderSide(color: Colors.black),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const Icon(
          Icons.key,
        ),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      controller: password,
      validator: (value) {
        if (value!.isEmpty) {
          return "Password must not be empty";
        } else if (value.length < 8) {
          return "Password must be more than 7 charactars";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: Colors.black),
          gapPadding: 5,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          gapPadding: 5,
          borderSide: const BorderSide(color: Colors.black),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const Icon(
          Icons.key,
        ),
      ),
    );
  }

  Widget buildPhoneNumberFormField() {
    return IntlPhoneField(
      decoration: InputDecoration(
        suffixIcon: const Icon(Icons.phone),
        labelText: 'Phone Number',
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          gapPadding: 5,
          borderSide: const BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          gapPadding: 5,
          borderSide: const BorderSide(color: Colors.black),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      initialCountryCode: 'PS',
      keyboardType: TextInputType.phone,
      controller: phoneNumber,
      validator: (value) {
        if (value!.toString().isEmpty) {
          return "PhoneNumber must not be empty";
        }
        return null;
      },
    );
  }

  Widget buildCountryFormField() {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () {
            showCountryPicker(
                context: context,
                countryListTheme: CountryListThemeData(
                  flagSize: 25,
                  backgroundColor: Colors.white,
                  textStyle: TextStyle(fontSize: 16, color: Colors.blueGrey),
                  bottomSheetHeight: 500, // Optional. Country list modal height
                  inputDecoration: InputDecoration(
                    labelText: 'Search',
                    hintText: 'Start typing to search',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: const Color(0xFF8C98A8).withOpacity(0.2),
                      ),
                    ),
                  ),
                ),
                onSelect: (Country selectedCountry) {
                  country.text = selectedCountry.displayName.split(" ").first;
                  Provider.of<Auth>(context, listen: false)
                      .setCountry(country.text);
                });
          },
          child: Consumer<Auth>(
            builder: (_, auth, ch) {
              return Row(
                children: [
                  auth.country.isEmpty
                      ? Text("Select Country")
                      : Text(country.text),
                  Icon(Icons.arrow_drop_down),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  TextFormField buildCityFormField() {
    return TextFormField(
      controller: city,
      validator: (value) {
        if (value!.isEmpty) {
          return "City must not be empty";
        }
        return null;
      },
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "City",
        hintText: "Enter your City",
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: Colors.black),
          gapPadding: 5,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          gapPadding: 5,
          borderSide: const BorderSide(color: Colors.black),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const Icon(Icons.location_on),
      ),
    );
  }

  TextFormField buildStreetFormField() {
    return TextFormField(
      controller: street,
      validator: (value) {
        if (value!.isEmpty) {
          return "Street must not be empty";
        }
        return null;
      },
      keyboardType: TextInputType.streetAddress,
      decoration: InputDecoration(
        labelText: "Street",
        hintText: "Enter your Street",
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: Colors.black),
          gapPadding: 5,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          gapPadding: 5,
          borderSide: const BorderSide(color: Colors.black),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const Icon(Icons.location_on),
      ),
    );
  }

  TextFormField buildZipFormField() {
    return TextFormField(
      controller: zip,
      validator: (value) {
        if (value!.isEmpty) {
          return "Zip must not be empty";
        }
        return null;
      },
      keyboardType: TextInputType.streetAddress,
      decoration: InputDecoration(
        labelText: "Zip",
        hintText: "Enter your Zip",
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: Colors.black),
          gapPadding: 5,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          gapPadding: 5,
          borderSide: const BorderSide(color: Colors.black),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const Icon(Icons.location_on),
      ),
    );
  }

  Widget submitSignUpButton() {
    return Consumer<Auth>(builder: (ctx, auth, _) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: MaterialButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
              }
              await _submit(context);
              if (auth.authenticated == true) {
                auth.setLoadingIndicator(false);
                auth
                    .fetchStoreAccountInfo()
                    .then((value) => auth.setAuthentucated(value));
                Navigator.of(context)
                    .pushReplacementNamed(HomeScreen.routeName);
              } else {
                print('something wrong');
              }
            },
            minWidth: 200,
            height: 50,
            color: Colors.black,
            child: Consumer<Auth>(
              builder: (_, auth, child) {
                return auth.isLoading
                    ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        'Continue',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      );
              },
            ),
          ),
        ),
      );
    });
  }
}

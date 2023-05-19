import 'package:flutter/material.dart';
class ShowProductAttributes extends StatefulWidget {
  const ShowProductAttributes({Key? key}) : super(key: key);

  @override
  State<ShowProductAttributes> createState() => _ShowProductAttributesState();
}

class _ShowProductAttributesState extends State<ShowProductAttributes> {
  final List<String> productAttribute = [
    'Type',
    'Gender',
    'Store',
    'Border',
    'Shape',
  ];
  bool _showAttributes = false;
  @override
  Widget build(BuildContext context) {

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
                          Text('Type: ${productAttribute[0]}'),
                          Text('Gender: ${productAttribute[1]}'),
                          Text('Store: ${productAttribute[2]}'),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Border: ${productAttribute[3]}'),
                          Text('Shape: ${productAttribute[4]}'),
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

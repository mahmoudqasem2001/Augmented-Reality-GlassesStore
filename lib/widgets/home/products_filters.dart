import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';

import '../../providers/product.dart';
import '../../providers/product_filter.dart';

class ProductFilterWidget extends StatefulWidget {
  @override
  _ProductFilterWidgetState createState() => _ProductFilterWidgetState();
}

class _ProductFilterWidgetState extends State<ProductFilterWidget> {
  bool _maleChecked = false;
  bool _femaleChecked = false;
  double _minPrice = 0;
  double _maxPrice = 0;

  @override
  Widget build(BuildContext context) {
    final productFilter = Provider.of<ProductFilter>(context);
    final prods = Provider.of<Products>(context, listen: false);
    final textStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
    return  SizedBox(
        height: 1200,
        child: ListView(
          padding: EdgeInsets.all(16),
          scrollDirection: Axis.vertical,
          
            children: [
              // Widgets for selecting genders
              Text('Gender', style: textStyle),
              CheckboxListTile(
                title: Text('Male'),
                value: _maleChecked,
                onChanged: (value) => setState(() => _maleChecked = value!),
              ),
              CheckboxListTile(
                title: Text('Female'),
                value: _femaleChecked,
                onChanged: (value) => setState(() => _femaleChecked = value!),
              ),
            
        //brand filters
              Text(
                'Brand',
                style: textStyle,
              ),
              CheckboxListTile(
                title: Text('Royal'),
                value: false,
                onChanged: (value) {},
              ),
              CheckboxListTile(
                title: Text('Tami'),
                value: false,
                onChanged: (value) {},
              ),
              CheckboxListTile(
                title: Text('Mavi'),
                value:false,
                onChanged: (value) {},
              ),
                   //glasses type filter
              Text(
                'Type',
                style: textStyle,
              ),
              CheckboxListTile(
                title: Text('Sun glasses'),
                value: false,
                onChanged: (value) {},
              ),
              CheckboxListTile(
                title: Text('Potection glasses'),
                value: false,
                onChanged: (value) {},
              ),
              CheckboxListTile(
                title: Text('Prescription glasses'),
                value: false,
                onChanged: (value) {},
              ),


 

              // Widgets for selecting a price range
              TextFormField(
                decoration: InputDecoration(labelText: 'Min price'),
                keyboardType: TextInputType.number,
                onChanged: (value) =>
                    setState(() => _minPrice = double.tryParse(value)!),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Max price'),
                keyboardType: TextInputType.number,
                onChanged: (value) =>
                    setState(() => _maxPrice = double.tryParse(value)!),
              ),
              SizedBox(height: 16),

              // Buttons for applying or clearing the filter
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    child: Text('Apply'),
                    onPressed: () {
                      final selectedGenders = [
                        if (_maleChecked) 'Male',
                        if (_femaleChecked) 'Female',
                      ];
                      productFilter.applyFilter(
                          selectedGenders, _minPrice, _maxPrice);
                      List<Product> products = prods.items;
                      List<Product> newFilteredproducts = [];
        
                      Navigator.pop(context);
                    },
                  ),
                  ElevatedButton(
                    child: Text('Clear'),
                    onPressed: () {
                      productFilter.clearFilter();
                      _maleChecked = false;
                      _femaleChecked = false;
                    },
                  ),
                ],
              ),
            ],
          ),
      
      
    );
  }
}

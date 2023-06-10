import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';

class ProductFilterWidget extends StatelessWidget {
  const ProductFilterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productFilter = Provider.of<Products>(context, listen: false);
    String? genderFilter;
    String? brandNameFilter;
    String? typeFilter;
    String? borderFilter;
    String? shapeFilter;
    final themeColor = Theme.of(context).colorScheme.secondary;
    return SizedBox(
      height: 1200,
      child: ListView(
        padding: const EdgeInsets.all(16),
        scrollDirection: Axis.vertical,
        children: [
          // Gender filter
          DropdownButtonFormField<String>(
            value: productFilter.currentFilter.gender,
            onChanged: (value) {
              // final newFilter =
              //     productFilter.currentFilter.copyWith(gender: value);
              // productFilter.updateFilter(newFilter);
              genderFilter = value;
            },
            items:const [
              DropdownMenuItem(value: 'Male', child: Text('Male')),
              DropdownMenuItem(value: 'Female', child: Text('Female')),
            ],
            decoration: InputDecoration(
              labelText: 'Gender',
            ),
            dropdownColor: themeColor,
          ),
          // Brand filter
          DropdownButtonFormField<String>(
            value: productFilter.currentFilter.brand?.name,
            onChanged: (value) {
              // final newFilter =
              //     productFilter.currentFilter.copyWith(brand: value);
              // productFilter.updateFilter(newFilter);
              brandNameFilter = value;
            },
            items: [
              DropdownMenuItem(
                  value: 'ALESSIO SUNGLASSES',
                  child: Text('ALESSIO SUNGLASSES')),
              DropdownMenuItem(value: 'BYALLY SUNGLASSES', child: Text('BYALLY SUNGLASSES')),
            ],
            decoration: InputDecoration(
              labelText: 'Brand',
            ),
            dropdownColor: themeColor,
          ),
          // Type filter
          DropdownButtonFormField<String>(
            value: productFilter.currentFilter.type,
            onChanged: (value) {
              // final newFilter =
              //     productFilter.currentFilter.copyWith(type: value);
              // productFilter.updateFilter(newFilter);
              typeFilter = value;
            },
            items: [
              DropdownMenuItem(value: 'SunGlasses', child: Text('SunGlasses')),
              DropdownMenuItem(value: 'ProtectionGlasses', child: Text('ProtectionGlasses')),
            ],
            decoration: InputDecoration(
              labelText: 'Type',
            ),
            dropdownColor: themeColor,
          ),
          DropdownButtonFormField<String>(
            value: productFilter.currentFilter.gender,
            onChanged: (value) {
              // final newFilter =
              //     productFilter.currentFilter.copyWith(gender: value);
              // productFilter.updateFilter(newFilter);
              borderFilter = value;
            },
            items: [
              DropdownMenuItem(value: 'thin', child: Text('thin')),
              DropdownMenuItem(value: 'bold', child: Text('bold')),
            ],
            decoration: InputDecoration(
              labelText: 'Border',
            ),
            dropdownColor: themeColor,
          ),
          DropdownButtonFormField<String>(
            value: productFilter.currentFilter.gender,
            onChanged: (value) {
              // final newFilter =
              //     productFilter.currentFilter.copyWith(gender: value);
              // productFilter.updateFilter(newFilter);
              shapeFilter = value;
            },
            items: [
              DropdownMenuItem(value: 'Square', child: Text('Square')),
              DropdownMenuItem(value: 'Circular', child: Text('Circular')),
            ],
            decoration: InputDecoration(
              labelText: 'Shape',
            ),
            dropdownColor: themeColor,
          ),
          // Apply filter button
          ElevatedButton(
            onPressed: () {
              productFilter.updateFilter(genderFilter, brandNameFilter,
                  typeFilter, borderFilter, shapeFilter);
            },
            child:const Text('Apply Filter'),
          ),
          ElevatedButton(
            onPressed: () {
              genderFilter = null;
              brandNameFilter = null;
              typeFilter = null;
              borderFilter = null;
              shapeFilter = null;
              productFilter.clearFilters();
            },
            child:const Text('Clear Filters'),
          ),
        ],
      ),
    );
  }
}

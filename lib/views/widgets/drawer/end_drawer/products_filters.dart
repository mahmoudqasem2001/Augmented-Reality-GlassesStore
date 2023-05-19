import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';
import '../../../../models/glasses_filter.dart';

class ProductFilterWidget extends StatelessWidget {
  const ProductFilterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productFilter = Provider.of<Products>(context, listen: false);
    String? genderFilter;
    String? brandFilter;
    String? typeFilter;
    String? borderFilter;
    String? shapeFilter;

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
            items: [
              DropdownMenuItem(value: 'Men', child: Text('Men')),
              DropdownMenuItem(value: 'Women', child: Text('Women')),
            ],
            decoration: InputDecoration(
              labelText: 'Gender',
            ),
          ),

          // Brand filter
          DropdownButtonFormField<String>(
            value: productFilter.currentFilter.brand,
            onChanged: (value) {
              // final newFilter =
              //     productFilter.currentFilter.copyWith(brand: value);
              // productFilter.updateFilter(newFilter);
              brandFilter = value;
            },
            items: [
              DropdownMenuItem(value: 'Brand 1', child: Text('Brand 1')),
              DropdownMenuItem(value: 'Brand 2', child: Text('Brand 2')),
            ],
            decoration: InputDecoration(
              labelText: 'Brand',
            ),
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
              DropdownMenuItem(value: 'Type 1', child: Text('Type 1')),
              DropdownMenuItem(value: 'Type 2', child: Text('Type 2')),
            ],
            decoration: InputDecoration(
              labelText: 'Type',
            ),
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
              DropdownMenuItem(value: 'Thin', child: Text('Thin')),
              DropdownMenuItem(value: 'bold', child: Text('bold')),
            ],
            decoration: InputDecoration(
              labelText: 'Border',
            ),
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
          ),
          // Apply filter button
          ElevatedButton(
            onPressed: () {
              GlassesFilter updatedFilter = GlassesFilter(
                gender: genderFilter,
                brand: brandFilter,
                type: typeFilter,
                border: borderFilter,
                shape: shapeFilter,
              );
              productFilter.updateFilter(updatedFilter);
            },
            child: Text('Apply Filter'),
          ),
        ],
      ),
    );
  }
}

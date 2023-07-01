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
              genderFilter = value;
            },
            items: const [
              DropdownMenuItem(value: 'MALE', child: Text('MALE')),
              DropdownMenuItem(value: 'FEMALE', child: Text('FEMALE')),
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
              brandNameFilter = value;
            },
            items: [
              DropdownMenuItem(
                  value: 'Prada',
                  child: Text('Prada')),
              DropdownMenuItem(
                  value: 'Ray-Ban', child: Text('Ray-Ban')),
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
              typeFilter = value;
            },
            items: [
              DropdownMenuItem(value: 'Sunglasses', child: Text('Sunglasses')),
              DropdownMenuItem(
                  value: 'ProtectionGlasses', child: Text('ProtectionGlasses')),
                  DropdownMenuItem(
                  value: 'Modern', child: Text('Modern')),
                  DropdownMenuItem(
                  value: 'Old', child: Text('Old')),
            ],
            decoration: InputDecoration(
              labelText: 'Type',
            ),
            dropdownColor: themeColor,
          ),
          DropdownButtonFormField<String>(
            value: productFilter.currentFilter.border,
            onChanged: (value) {
              borderFilter = value;
            },
            items: [
              DropdownMenuItem(value: 'Thin', child: Text('Thin')),
              DropdownMenuItem(value: 'Bold', child: Text('Bold')),
            ],
            decoration: InputDecoration(
              labelText: 'Border',
            ),
            dropdownColor: themeColor,
          ),
          DropdownButtonFormField<String>(
            value: productFilter.currentFilter.shape,
            onChanged: (value) {
              shapeFilter = value;
            },
            items: const [
              DropdownMenuItem(value: 'Square', child: Text('Square')),
              DropdownMenuItem(value: 'Rounded', child: Text('Rounded')),
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
            child: const Text('Apply Filter'),
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
            child: const Text('Clear Filters'),
          ),
        ],
      ),
    );
  }
}

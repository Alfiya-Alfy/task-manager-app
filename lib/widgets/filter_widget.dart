import 'package:flutter/material.dart';

class FilterWidget extends StatelessWidget {
  final String selectedFilter;
  final Function(String) onFilterChanged;

  const FilterWidget({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    final filters = [
      'All',
      'Completed',
      'Pending'
    ];

    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceEvenly,
      children: filters.map((filter) {
        return ChoiceChip(
          label: Text(filter),
          selected:
              selectedFilter == filter,
          onSelected: (_) =>
              onFilterChanged(filter),
        );
      }).toList(),
    );
  }
}
import 'package:flutter/material.dart';

class FilterDropdown<T> extends StatelessWidget {
  const FilterDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.itemTextBuilder,
  });

  final String label;
  final T? value;
  final List<T> items;
  final ValueChanged<T?> onChanged;
  final String Function(T)? itemTextBuilder;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        suffixIcon: value != null
            ? IconButton(
                icon: const Icon(Icons.clear, size: 20),
                onPressed: () => onChanged(null),
              )
            : null,
      ),
      items: items.map<DropdownMenuItem<T>>((T item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(itemTextBuilder != null
              ? itemTextBuilder!(item)
              : item.toString()),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}

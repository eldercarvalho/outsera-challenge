import 'package:flutter/material.dart';

class YearsDropdown extends StatefulWidget {
  const YearsDropdown({
    super.key,
    this.value = 0,
    required this.onChanged,
  });

  final int value;
  final void Function(int) onChanged;

  @override
  State<YearsDropdown> createState() => _YearsDropdownState();
}

class _YearsDropdownState extends State<YearsDropdown> {
  int _selectedYear = 0;
  final List<int> _years = [];

  @override
  void initState() {
    int currentYear = DateTime.now().year;
    for (int year = 1900; year <= currentYear; year++) {
      _years.add(year);
    }

    _years.add(0);

    if (widget.value != 0) {
      _selectedYear = widget.value;
    } else {
      _selectedYear = _years.last;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      items: _years.reversed.map<DropdownMenuItem<int>>((int year) {
        return DropdownMenuItem<int>(
          value: year,
          child:
              year == 0 ? const Text('Select a year') : Text(year.toString()),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() => _selectedYear = newValue!);
        widget.onChanged(newValue!);
      },
      value: _selectedYear,
      isExpanded: true,
      itemHeight: null,
      menuMaxHeight: 300,
    );
  }
}

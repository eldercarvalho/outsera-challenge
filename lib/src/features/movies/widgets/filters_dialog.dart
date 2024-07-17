import 'package:flutter/material.dart';
import 'package:outsera_challenge/src/shared/extensions/extensions.dart';

class Filters {
  final int year;
  final bool winnersOnly;

  bool get hasFilters => year != 0 || winnersOnly;
  bool get hasYear => year != 0;

  const Filters({
    this.year = 0,
    this.winnersOnly = false,
  });

  Filters copyWith({
    int? year,
    bool? winnersOnly,
  }) {
    return Filters(
      year: year ?? this.year,
      winnersOnly: winnersOnly ?? this.winnersOnly,
    );
  }
}

class FiltersDialog extends StatefulWidget {
  const FiltersDialog({super.key, this.filters});

  final Filters? filters;

  @override
  State<FiltersDialog> createState() => _FiltersDialogState();
}

class _FiltersDialogState extends State<FiltersDialog> {
  int _selectedYear = 0;
  bool _winnersOnly = false;
  final List<int> _years = [];

  @override
  void initState() {
    int currentYear = DateTime.now().year;
    for (int year = 1900; year <= currentYear; year++) {
      _years.add(year);
    }

    _years.add(0);

    if (widget.filters != null) {
      _selectedYear = widget.filters!.year;
      _winnersOnly = widget.filters!.winnersOnly;
    } else {
      _selectedYear = _years.last;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Filters',
        style: context.textTheme.titleLarge,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Year',
            style: context.textTheme.labelMedium,
          ),
          DropdownButton<int>(
            items: _years.reversed.map<DropdownMenuItem<int>>((int year) {
              return DropdownMenuItem<int>(
                value: year,
                child: year == 0
                    ? const Text('Selecione o ano')
                    : Text(year.toString()),
              );
            }).toList(),
            onChanged: (newValue) => setState(() => _selectedYear = newValue!),
            value: _selectedYear,
            // underline: const SizedBox.shrink(),
            isExpanded: true,
          ),
          16.height,
          Row(
            children: [
              Expanded(
                child: Text(
                  'Winners Only',
                  style: context.textTheme.labelMedium,
                ),
              ),
              12.width,
              Switch(
                value: _winnersOnly,
                onChanged: (value) => setState(() => _winnersOnly = value),
              ),
            ],
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(Filters(
              year: _selectedYear,
              winnersOnly: _winnersOnly,
            ));
          },
          child: const Text('Apply'),
        ),
      ],
      backgroundColor: context.colorScheme.surfaceContainerHighest,
    );
  }
}

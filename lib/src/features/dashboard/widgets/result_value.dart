import 'package:flutter/widgets.dart';
import 'package:outsera_challenge/src/shared/shared.dart';

class ResultValue extends StatelessWidget {
  const ResultValue({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: context.textTheme.bodyLarge,
        ),
        6.width,
        Text(
          value,
          style: context.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

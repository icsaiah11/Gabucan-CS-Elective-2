import 'package:flutter/material.dart';

class StateMessage extends StatelessWidget {
  const StateMessage({required this.icon, required this.title, this.action, super.key});

  final IconData icon;
  final String title;
  final VoidCallback? action;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 52, color: Colors.grey.shade600),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
          if (action != null) ...[
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: action,
              icon: const Icon(Icons.refresh),
              label: const Text('Try again'),
            ),
          ],
        ],
      ),
    );
  }
}

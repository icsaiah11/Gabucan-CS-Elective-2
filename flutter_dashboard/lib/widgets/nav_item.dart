import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// A single sidebar navigation entry, rendered natively for whichever
/// platform style (Material or Cupertino) is active.
class NavItem extends StatelessWidget {
  final int index;
  final String label;
  final IconData icon;
  final bool isCupertino;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const NavItem({
    super.key,
    required this.index,
    required this.label,
    required this.icon,
    required this.isCupertino,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedIndex == index;

    if (isCupertino) {
      return GestureDetector(
        onTap: () => onSelected(index),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? CupertinoColors.systemBlue.withOpacity(0.15) : null,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(icon, size: 20, color: isSelected ? CupertinoColors.systemBlue : CupertinoColors.systemGrey),
              const SizedBox(width: 10),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? CupertinoColors.systemBlue : CupertinoColors.black,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      child: Material(
        color: isSelected ? Theme.of(context).colorScheme.primary.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: ListTile(
          leading: Icon(
            icon,
            size: 20,
            color: isSelected ? Theme.of(context).colorScheme.primary : Colors.grey[600],
          ),
          title: Text(
            label,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected ? Theme.of(context).colorScheme.primary : Colors.black87,
            ),
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          onTap: () => onSelected(index),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class Paddle {
  const Paddle({
    required this.id,
    required this.brand,
    required this.name,
    required this.price,
    required this.badge,
    required this.background,
    required this.description,
    required this.imagePath,
  });

  final String id;
  final String brand;
  final String name;
  final double price;
  final String badge;
  final Color background;
  final String description;
  final String imagePath;
}

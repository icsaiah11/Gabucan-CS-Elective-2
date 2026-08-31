import 'package:flutter/material.dart';

class DashboardCardData {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const DashboardCardData({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });
}

const List<DashboardCardData> dashboardCards = [
  DashboardCardData(
      title: 'Users', value: '1,234', icon: Icons.people, color: Colors.blue),
  DashboardCardData(
      title: 'Revenue',
      value: '\$45.2K',
      icon: Icons.trending_up,
      color: Colors.green),
  DashboardCardData(
      title: 'Orders',
      value: '892',
      icon: Icons.shopping_cart,
      color: Colors.orange),
  DashboardCardData(
      title: 'Growth',
      value: '+12.5%',
      icon: Icons.trending_up,
      color: Colors.purple),
  DashboardCardData(
      title: 'Sessions',
      value: '3.5K',
      icon: Icons.schedule,
      color: Colors.red),
  DashboardCardData(
      title: 'Conversion',
      value: '3.2%',
      icon: Icons.percent,
      color: Colors.teal),
];

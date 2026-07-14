import 'package:flutter/material.dart';

class CategoryModel {
  final String id;
  final String name;
  final IconData icon;
  final Color color;
  final int courseCount;

  CategoryModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    this.courseCount = 0,
  });
}

// Sample categories
class SampleCategories {
  static List<CategoryModel> get categories => [
        CategoryModel(
          id: '1',
          name: 'Development',
          icon: Icons.code,
          color: const Color(0xFF6C63FF),
          courseCount: 150,
        ),
        CategoryModel(
          id: '2',
          name: 'Business',
          icon: Icons.business,
          color: const Color(0xFFFF6584),
          courseCount: 120,
        ),
        CategoryModel(
          id: '3',
          name: 'Design',
          icon: Icons.design_services,
          color: const Color(0xFF10B981),
          courseCount: 85,
        ),
        CategoryModel(
          id: '4',
          name: 'Marketing',
          icon: Icons.campaign,
          color: const Color(0xFFF59E0B),
          courseCount: 95,
        ),
        CategoryModel(
          id: '5',
          name: 'Photography',
          icon: Icons.camera_alt,
          color: const Color(0xFF3B82F6),
          courseCount: 60,
        ),
        CategoryModel(
          id: '6',
          name: 'Music',
          icon: Icons.music_note,
          color: const Color(0xFFEF4444),
          courseCount: 45,
        ),
      ];
}

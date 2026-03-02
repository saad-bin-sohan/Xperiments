import 'package:flutter/material.dart';

class LabIconOption {
  const LabIconOption({
    required this.id,
    required this.label,
    required this.icon,
  });

  final String id;
  final String label;
  final IconData icon;
}

const List<LabIconOption> kLabIconOptions = <LabIconOption>[
  LabIconOption(id: 'lab_flask', label: 'Lab', icon: Icons.science_outlined),
  LabIconOption(id: 'health', label: 'Health', icon: Icons.favorite_outline),
  LabIconOption(id: 'fitness', label: 'Fitness', icon: Icons.fitness_center),
  LabIconOption(id: 'mind', label: 'Mind', icon: Icons.psychology_outlined),
  LabIconOption(id: 'sleep', label: 'Sleep', icon: Icons.bedtime_outlined),
  LabIconOption(id: 'food', label: 'Nutrition', icon: Icons.restaurant_menu),
  LabIconOption(id: 'finance', label: 'Finance', icon: Icons.savings_outlined),
  LabIconOption(id: 'work', label: 'Work', icon: Icons.work_outline),
  LabIconOption(id: 'learning', label: 'Learning', icon: Icons.school_outlined),
  LabIconOption(
    id: 'reading',
    label: 'Reading',
    icon: Icons.menu_book_outlined,
  ),
  LabIconOption(id: 'writing', label: 'Writing', icon: Icons.edit_note),
  LabIconOption(
    id: 'creativity',
    label: 'Creativity',
    icon: Icons.brush_outlined,
  ),
  LabIconOption(id: 'music', label: 'Music', icon: Icons.music_note_outlined),
  LabIconOption(
    id: 'relationships',
    label: 'Relationships',
    icon: Icons.people_outline,
  ),
  LabIconOption(
    id: 'family',
    label: 'Family',
    icon: Icons.family_restroom_outlined,
  ),
  LabIconOption(id: 'social', label: 'Social', icon: Icons.forum_outlined),
  LabIconOption(
    id: 'minimalism',
    label: 'Minimalism',
    icon: Icons.grid_3x3_outlined,
  ),
  LabIconOption(id: 'focus', label: 'Focus', icon: Icons.center_focus_strong),
  LabIconOption(
    id: 'spiritual',
    label: 'Spiritual',
    icon: Icons.self_improvement_outlined,
  ),
  LabIconOption(id: 'custom', label: 'Custom', icon: Icons.tune),
];

const List<String> kLabColorPalette = <String>[
  '#8E8E93',
  '#6E6E73',
  '#3A3A3C',
  '#7D7A75',
  '#6B7A8F',
  '#5D737E',
  '#607D8B',
  '#7C6F64',
  '#6D6875',
  '#7B6D8D',
  '#6A7F7B',
  '#556B5D',
];

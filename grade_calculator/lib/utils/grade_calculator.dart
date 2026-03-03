import 'package:flutter/material.dart';

/// Returns the letter grade for a given score (0–100).
String getGrade(int score) {
  if (score >= 90) return 'A';
  if (score >= 80) return 'B';
  if (score >= 70) return 'C';
  if (score >= 60) return 'D';
  return 'F';
}

/// Returns the accent colour used for each grade band.
Color gradeAccentColor(String grade) {
  switch (grade) {
    case 'A':
      return const Color(0xFF2E7D32); // green
    case 'B':
      return const Color(0xFF00796B); // teal
    case 'C':
      return const Color(0xFFF57F17); // amber
    case 'D':
      return const Color(0xFFE65100); // deep orange
    case 'F':
      return const Color(0xFFC62828); // red
    default:
      return const Color(0xFF9E9E9E); // grey (no score)
  }
}

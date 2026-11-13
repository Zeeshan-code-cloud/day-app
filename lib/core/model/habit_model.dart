import 'dart:convert';

class HabitModel {
  final String id;
  final String title;
  final String category;

  /// Color value e.g. Color(0xFF6C63FF).value
  final int colorValue;

  final bool reminderEnabled;
  final String reminderTime;

  /// Total completed days
  final int completedCount;

  /// Current streak
  final int streak;

  /// Creation date
  final DateTime createdAt;

  /// Dates when habit completed
  final List<String> completedDates;

  HabitModel({
    required this.id,
    required this.title,
    required this.category,
    required this.colorValue,
    required this.reminderEnabled,
    required this.reminderTime,
    required this.completedCount,
    required this.streak,
    required this.createdAt,
    required this.completedDates,
  });

  HabitModel copyWith({
    String? id,
    String? title,
    String? category,
    int? colorValue,
    bool? reminderEnabled,
    String? reminderTime,
    int? completedCount,
    int? streak,
    DateTime? createdAt,
    List<String>? completedDates,
  }) {
    return HabitModel(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      colorValue: colorValue ?? this.colorValue,
      reminderEnabled:
      reminderEnabled ?? this.reminderEnabled,
      reminderTime:
      reminderTime ?? this.reminderTime,
      completedCount:
      completedCount ?? this.completedCount,
      streak: streak ?? this.streak,
      createdAt: createdAt ?? this.createdAt,
      completedDates:
      completedDates ?? this.completedDates,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'colorValue': colorValue,
      'reminderEnabled': reminderEnabled,
      'reminderTime': reminderTime,
      'completedCount': completedCount,
      'streak': streak,
      'createdAt': createdAt.toIso8601String(),
      'completedDates': completedDates,
    };
  }

  factory HabitModel.fromMap(
      Map<String, dynamic> map) {
    return HabitModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      category: map['category'] ?? '',
      colorValue: map['colorValue'] ?? 0,
      reminderEnabled:
      map['reminderEnabled'] ?? false,
      reminderTime:
      map['reminderTime'] ?? '',
      completedCount:
      map['completedCount'] ?? 0,
      streak: map['streak'] ?? 0,
      createdAt: DateTime.parse(
        map['createdAt'],
      ),
      completedDates:
      List<String>.from(
        map['completedDates'] ?? [],
      ),
    );
  }

  String toJson() =>
      jsonEncode(toMap());

  factory HabitModel.fromJson(String source,) =>
      HabitModel.fromMap(
        jsonDecode(source),
      );

}
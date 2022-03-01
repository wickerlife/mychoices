import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:enum_to_string/enum_to_string.dart';

enum categories {
  relationship,
  personal,
  family,
  friends,
  life,
  hobbies,
  goals,
  education,
  finances,
  work,
  others
}

enum relevanceEnum { low, medium, high }

var categoriesMap = {
  categories.relationship:
      const Category(name: 'Relationship', icon: Icons.people),
  categories.personal: const Category(
      name: 'Relationship', icon: Icons.sentiment_very_satisfied),
  categories.family:
      const Category(name: 'Family', icon: Icons.family_restroom),
  categories.friends:
      const Category(name: 'Friends', icon: Icons.sports_kabaddi),
  categories.life: const Category(
      name: 'Life & Entertainment', icon: Icons.sports_basketball),
  categories.hobbies: const Category(name: 'Hobbies', icon: Icons.brush),
  categories.goals: const Category(name: 'Goals', icon: Icons.emoji_events),
  categories.education: const Category(name: 'Education', icon: Icons.school),
  categories.work: const Category(name: 'Work', icon: Icons.work),
  categories.finances: const Category(name: 'Finances', icon: Icons.payments),
  categories.others: const Category(name: 'Others', icon: Icons.category)
};

class Category {
  final String name;
  final IconData icon;

  const Category({required this.name, required this.icon});
}

class Tag {
  String? name;

  Tag(String name) {
    this.name = name.toLowerCase();
  }

  @override
  int get hashCode => Object.hash(name, name);

  @override
  bool operator ==(dynamic other) {
    return other is Tag && other.name == name;
  }
}

class Choice extends Equatable {
  final String title;
  final String? description;
  final String choice;
  final List<String>? options;
  final Category category;
  final List<Tag>? tags;
  final DateTime date;
  final relevanceEnum relevance;
  final bool random;

  const Choice({
    required this.title,
    this.description,
    required this.choice,
    this.options,
    required this.category,
    this.tags,
    required this.date,
    required this.relevance,
    required this.random,
  });

  Choice copyWith({
    String? title,
    String? description,
    String? choice,
    List<String>? options,
    Category? category,
    List<Tag>? tags,
    DateTime? date,
    relevanceEnum? relevance,
    bool? random,
  }) =>
      Choice(
        title: title ?? this.title,
        description: description ?? this.description,
        choice: choice ?? this.choice,
        options: options ?? this.options,
        category: category ?? this.category,
        tags: tags ?? this.tags,
        date: date ?? this.date,
        relevance: relevance ?? this.relevance,
        random: random ?? this.random,
      );

  factory Choice.fromJson(Map<String, dynamic> json) => Choice(
        title: json['title'],
        description: json['description'],
        choice: json['choice'],
        options: json['options'],
        category: json['category'],
        tags: json['tags'],
        date: DateTime.parse(json['date']),
        relevance:
            EnumToString.fromString(relevanceEnum.values, json['relevance'])!,
        random: json['random'],
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'choice': choice,
        'options': options,
        'category': category,
        'tags': tags?.map((tag) => tag.name).toList(),
        'date': date.toIso8601String(),
        'relevance': EnumToString.convertToString(relevance),
        'random': random
      };

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

import 'package:flutter/material.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:uuid/uuid.dart';

enum Categories { relationship, personal, family, friends, life, hobbies, goals, education, finances, work, others }

enum RelevanceEnum { none, low, medium, high }

class ChoicePackage {
  Choice? choice;
  bool success;
  bool edited;
  bool deleted;

  ChoicePackage({
    this.choice,
    required this.success,
    this.edited = false,
    this.deleted = false,
  });
}

var categoriesMap = {
  Categories.personal: const Category(name: 'Personal', icon: Icons.sentiment_very_satisfied),
  Categories.relationship: const Category(name: 'Relationship', icon: Icons.people),
  Categories.family: const Category(name: 'Family', icon: Icons.family_restroom),
  Categories.friends: const Category(name: 'Friends', icon: Icons.sports_kabaddi),
  Categories.life: const Category(name: 'Life & Entertainment', icon: Icons.sports_basketball),
  Categories.hobbies: const Category(name: 'Hobbies', icon: Icons.brush),
  Categories.goals: const Category(name: 'Goals', icon: Icons.emoji_events),
  Categories.education: const Category(name: 'Education', icon: Icons.school),
  Categories.work: const Category(name: 'Work', icon: Icons.work),
  Categories.finances: const Category(name: 'Finances', icon: Icons.payments),
  Categories.others: const Category(name: 'Others', icon: Icons.category)
};

class Category {
  final String name;
  final IconData icon;

  const Category({required this.name, required this.icon});

  @override
  int get hashCode => Object.hash(name, icon);

  @override
  bool operator ==(dynamic other) {
    return other is Category && other.name == name;
  }
}

class Tag {
  final String name;

  const Tag({
    required this.name,
  });

  @override
  int get hashCode => Object.hash(name, name);

  @override
  bool operator ==(dynamic other) {
    return other is Tag && other.name == name;
  }
}

class ChoiceValue {
  String value;
  bool toInitialize;
  bool changed;

  ChoiceValue({
    this.value = '',
    this.toInitialize = false,
    this.changed = false,
  });

  Map<String, dynamic> toJson() => {
        'value': value,
        'toInitialize': toInitialize,
        'changed': changed,
      };

  factory ChoiceValue.fromJson(Map<String, dynamic> json) => ChoiceValue(
        value: json['value'],
        toInitialize: json['toInitialize'],
        changed: json['changed'],
      );
}

class Choice {
  final String? id;
  String title;
  String? description;
  ChoiceValue choice;
  List<String>? options;
  Category category;
  List<dynamic>? tags;
  DateTime date;
  RelevanceEnum relevance;
  bool random;

  Choice({
    required this.title,
    this.description,
    required this.choice,
    this.options,
    required this.category,
    this.tags,
    required this.date,
    required this.relevance,
    required this.random,
  }) : id = const Uuid().v1();

  Choice.withId({
    required this.title,
    this.description,
    required this.choice,
    this.options,
    required this.category,
    this.tags,
    required this.date,
    required this.relevance,
    required this.random,
    required this.id,
  });

  Choice copyWith({
    String? title,
    String? description,
    ChoiceValue? choice,
    List<String>? options,
    Category? category,
    List<Tag>? tags,
    DateTime? date,
    RelevanceEnum? relevance,
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

  factory Choice.fromJson(Map<String, dynamic> json) => Choice.withId(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        choice: ChoiceValue.fromJson(json['choice']),
        options: List<String>.from(json['options']),
        category: categoriesMap.entries.where((element) => element.value.name == json['category']).map((e) => categoriesMap[e.key]).toList()[0]!,
        tags: (json['tags'] == null || List<String>.from(json['tags']).isEmpty) ? null : json['tags'].map((name) => Tag(name: name)).toList(),
        date: DateTime.parse(json['date']),
        relevance: EnumToString.fromString(RelevanceEnum.values, json['relevance'])!,
        random: json['random'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'choice': choice.toJson(),
        'options': options,
        'category': category.name,
        'tags': tags?.map((tag) => tag.name).toList(),
        'date': date.toIso8601String(),
        'relevance': EnumToString.convertToString(relevance),
        'random': random
      };

  bool compareDate(DateTime other) {
    if (other.year == date.year && other.month == date.month && other.day == date.day) {
      return true;
    }
    return false;
  }

  void update(Choice other) {
    title = other.title;
    description = other.description;
    choice = other.choice;
    category = other.category;
    tags = other.tags;
    date = other.date;
    relevance = other.relevance;
    random = other.random;
  }

  @override
  int get hashCode => Object.hash(id, id);

  @override
  bool operator ==(dynamic other) {
    return other is Choice && other.id == id;
  }
}

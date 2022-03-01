import '../data/models/user.dart';
import '../data/models/choice.dart';

final modelUser = User(
  name: 'David',
  firstDay: DateTime(2022, 2, 16, 6, 30),
  profileImage: 'assets/pictures/profile.jpg',
);

final modelChoice = Choice(
  title: 'Date',
  choice: 'Wednesday',
  category: categoriesMap[categories.relationship]!,
  date: DateTime(2022, 2, 26, 6, 30),
  relevance: relevanceEnum.high,
  random: false,
);

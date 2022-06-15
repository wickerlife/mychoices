import '../data/models/user.dart';
import '../data/models/choice.dart';

final modelUser = User(
  name: 'David',
  firstDay: DateTime(2022, 2, 16, 6, 30),
  profileImage: 'assets/pictures/profile.jpg',
);

final modelChoice = Choice(
    title: 'Date',
    choice: ChoiceValue(value: 'Wednesday'),
    category: categoriesMap[Categories.relationship]!,
    date: DateTime(2022, 2, 26, 6, 30),
    relevance: RelevanceEnum.high,
    random: true,
    tags: const [
      Tag(name: 'hashtag'),
      Tag(name: 'nisha'),
      Tag(name: 'hello'),
    ]);

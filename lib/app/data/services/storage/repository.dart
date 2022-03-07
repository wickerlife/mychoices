import 'package:mychoices/app/data/models/choice.dart';
import 'package:mychoices/app/data/provider/choice/provider.dart';

class ChoiceRepository {
  ChoiceProvider choiceProvider;
  ChoiceRepository({required this.choiceProvider});

  List<Choice> readChoices() => choiceProvider.readChoices();

  List<Choice> readTodaysChoices() => choiceProvider.readTodaysChoices();

  void writeChoices(List<Choice> choices) =>
      choiceProvider.writeChoices(choices);
}

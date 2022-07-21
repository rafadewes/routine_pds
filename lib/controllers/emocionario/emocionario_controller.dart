import 'package:mobx/mobx.dart';
import '../../models/result_message.dart';
import '../../models/user.dart';
import '../../repositories/emocionario_repository.dart';
part 'emocionario_controller.g.dart';

class EmocionarioController = EmocionarioControllerBase
    with _$EmocionarioController;

abstract class EmocionarioControllerBase with Store {
  EmocionarioRepository emocionarioRepository = EmocionarioRepository();

  @observable
  DateTime? selectedDate;

  @observable
  DateTime calendarSelectDate = DateTime.now();

  @action
  setSelectedDate(DateTime newDate) {
    selectedDate = newDate;
  }

  @action
  resetSelectedDate() => selectedDate = null;

  @action
  setCalendarSelectDate(DateTime newDate) {
    selectedDate = newDate;
  }

  @action
  resetCalendarSelectDate() => selectedDate = DateTime.now();

  @action
  Future<ResultMessage> newEmotion(Emocionario emocionario) async {
    ResultMessage result = await emocionarioRepository.addEmotion(emocionario);

    return result;
  }

  @action
  Future<void> removeEmotion(Emocionario emocionario) async {
    await emocionarioRepository.removeEmotion(emocionario);
  }
}

import 'package:mobx/mobx.dart';

import '../../models/user.dart';
import '../../repositories/emocionario_repository.dart';

part 'home_controller.g.dart';

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store {
  EmocionarioRepository emocionarioRepository = EmocionarioRepository();

  @action
  listEmotions() {
    List<Emocionario> emotions = [];

    var result = emocionarioRepository.listEmotions();

    var ret = result!.elementAt(0).asStream();

    return ret;
  }
}

import 'dart:math';

import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import '../../models/notification_service.dart';
import '../../models/result_message.dart';
import '../../models/user.dart';
import '../../repositories/habito_repository.dart';
import '../../routes/app_router.dart';
part 'habito_controller.g.dart';

class HabitoController = _HabitoControllerBase with _$HabitoController;

abstract class _HabitoControllerBase with Store {
  HabitoRepository habitoRepository = HabitoRepository();

  @observable
  bool notification = false;

  @observable
  bool diario = true;

  @observable
  var values = List.filled(7, true);

  @observable
  ObservableList<String> horarios = ObservableList<String>();

  @action
  setHorarios(List<String> oldHours) {
    for (var element in oldHours) {
      horarios.add(element);
    }
  }

  @action
  setNotification(bool value) => notification = value;

  @action
  setDiario(bool value) => diario = value;

  @action
  setValues(List<bool> newList) => values = newList;

  @action
  setValuesIndex(bool value, int index) {
    values[index] = value;
  }

  @action
  addHorario(String horario) => horarios.add(horario);

  @action
  removerHorario(int index) => horarios.removeAt(index);

  @action
  resetElements() {
    notification = false;
    diario = true;
    values = List.filled(7, true);
    horarios = ObservableList<String>();
  }

  @action
  Future<ResultMessage> addHabito(String text) async {
    var id = Random().nextInt(1000);
    var habito = Habitos(
      horarios: horarios,
      lembrete: notification,
      nomeHabito: text,
      idHabitos: id.toString(),
      dias: values,
      notificationId: [],
    );

    if (habito.lembrete == true) {
      if (habito.dias!.every((element) => element == true)) {
        for (var element in habito.horarios!) {
          var notificarionId = Random().nextInt(10000);
          habito.notificationId!.add(notificarionId);
          await Provider.of<NotificationService>(
            Routes.navigatorKey.currentContext!,
            listen: false,
          ).scheduleDailyNotification(
            CustomNotification(
              notificarionId,
              'Olá usuário!',
              habito.nomeHabito,
              'habitos',
            ),
            element,
          );
        }
      } else {
        for (var x = 0; x < values.length; x++) {
          print(x);
          if (values[x]) {
            for (var elementHour in habito.horarios!) {
              var notificarionId = Random().nextInt(10000);
              habito.notificationId!.add(notificarionId);
              print(notificarionId);
              await Provider.of<NotificationService>(
                Routes.navigatorKey.currentContext!,
                listen: false,
              ).scheduleWeeklyNotification(
                CustomNotification(
                  notificarionId,
                  'Olá usuário!',
                  habito.nomeHabito,
                  'habitos',
                ),
                elementHour,
                x == 0 ? 7 : x,
              );
            }
          }
        }
      }
    }

    final result = await habitoRepository.addHabito(habito);

    if (result.type == 'success') {
      return result;
    } else {
      for (var element in habito.notificationId!) {
        await Provider.of<NotificationService>(
          Routes.navigatorKey.currentContext!,
          listen: false,
        ).removeNotification(element);
      }
      return result;
    }
  }

  @action
  Future<void> removeHabito(Habitos habitos) async {
    for (var element in habitos.notificationId!) {
      await Provider.of<NotificationService>(
        Routes.navigatorKey.currentContext!,
        listen: false,
      ).removeNotification(element);
    }

    await habitoRepository.removeHabito(habitos);
  }

  @action
  Future<ResultMessage> updateHabito(Habitos habito, String text) async {
    for (var element in habito.notificationId!) {
      await Provider.of<NotificationService>(
        Routes.navigatorKey.currentContext!,
        listen: false,
      ).removeNotification(element);
    }

    if (notification) {
      habito.dias = values;
      habito.horarios = horarios;
      habito.lembrete = notification;
      habito.nomeHabito = text;
      habito.notificationId = [];
    } else {
      habito.dias = [];
      habito.horarios = [];
      habito.lembrete = notification;
      habito.nomeHabito = text;
      habito.notificationId = [];
    }

    if (habito.lembrete == true) {
      if (habito.dias!.every((element) => element == true)) {
        for (var element in habito.horarios!) {
          var notificarionId = Random().nextInt(10000);
          habito.notificationId!.add(notificarionId);
          await Provider.of<NotificationService>(
            Routes.navigatorKey.currentContext!,
            listen: false,
          ).scheduleDailyNotification(
            CustomNotification(
              notificarionId,
              'Olá usuário!',
              habito.nomeHabito,
              'habitos',
            ),
            element,
          );
        }
      } else {
        for (var x = 0; x < values.length; x++) {
          print(x);
          if (values[x]) {
            for (var elementHour in habito.horarios!) {
              var notificarionId = Random().nextInt(10000);
              habito.notificationId!.add(notificarionId);
              print(notificarionId);
              await Provider.of<NotificationService>(
                Routes.navigatorKey.currentContext!,
                listen: false,
              ).scheduleWeeklyNotification(
                CustomNotification(
                  notificarionId,
                  'Olá usuário!',
                  habito.nomeHabito,
                  'habitos',
                ),
                elementHour,
                x == 0 ? 7 : x,
              );
            }
          }
        }
      }
    }

    final result = await habitoRepository.updateHabito(habito);

    return result;
  }
}

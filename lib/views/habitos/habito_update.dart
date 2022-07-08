import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/date_symbols.dart';
import 'package:time_picker_sheet/widget/sheet.dart';
import 'package:time_picker_sheet/widget/time_picker.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:weekday_selector/weekday_selector.dart';

import '../../controllers/habito/habito_controller.dart';
import '../../models/result_message.dart';
import '../../models/user.dart';

class HabitoUpdate extends StatefulWidget {
  final Habitos habito;
  const HabitoUpdate({Key? key, required this.habito}) : super(key: key);

  @override
  State<HabitoUpdate> createState() => _HabitoUpdateState();
}

class _HabitoUpdateState extends State<HabitoUpdate> {
  TextEditingController textEditingController = TextEditingController();
  HabitoController habitoController = HabitoController();

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (widget.habito.horarios!.isNotEmpty) {
      habitoController.setHorarios(widget.habito.horarios!);
    }
    if (widget.habito.dias!.isNotEmpty) {
      habitoController
          .setDiario(widget.habito.dias!.every((element) => element == true));
    }
    if (widget.habito.dias!.isNotEmpty) {
      habitoController.setValues(widget.habito.dias!);
    }

    habitoController.setNotification(widget.habito.lembrete!);
    textEditingController.text = widget.habito.nomeHabito!;
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final DateSymbols dateSymbols = dateTimeSymbolMap()['$locale'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff23212C),
        title: Text(
          'Editar Hábito',
          style: GoogleFonts.urbanist(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            habitoController.resetElements();
            textEditingController.text = '';

            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Observer(builder: (context) {
          return Container(
            color: const Color(0xff23212C),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: SizedBox(
                    height: 50,
                    child: TextField(
                      controller: textEditingController,
                      maxLines: 1,
                      style: GoogleFonts.urbanist(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                      textAlignVertical: TextAlignVertical.center,
                      cursorColor: const Color(0xffEC008C),
                      decoration: InputDecoration(
                        filled: true,
                        prefixIcon: const Icon(
                          Icons.new_label,
                          color: Colors.white,
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        fillColor: const Color(0xff373645),
                        contentPadding: EdgeInsets.zero,
                        hintText: 'Nome do novo hábito',
                        hintStyle: GoogleFonts.urbanist(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Lembrete',
                        style: GoogleFonts.urbanist(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Switch.adaptive(
                        activeColor: const Color(0xffEC008C),
                        value: habitoController.notification,
                        onChanged: (value) {
                          habitoController.setNotification(
                            !habitoController.notification,
                          );
                        },
                      )
                    ],
                  ),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: habitoController.notification ? 1.0 : 0.0,
                  child: habitoController.notification
                      ? Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Repetir diariamente',
                                style: GoogleFonts.urbanist(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Switch.adaptive(
                                activeColor: const Color(0xffEC008C),
                                value: habitoController.diario,
                                onChanged: (value) {
                                  if (habitoController.values !=
                                      [
                                        true,
                                        true,
                                        true,
                                        true,
                                        true,
                                        true,
                                        true
                                      ]) {
                                    habitoController.setDiario(value);
                                    habitoController
                                        .setValues(List.filled(7, true));
                                  }
                                },
                              )
                            ],
                          ),
                        )
                      : Container(),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: habitoController.notification ? 1.0 : 0.0,
                  child: habitoController.notification
                      ? Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: WeekdaySelectorTheme(
                            data: WeekdaySelectorThemeData(
                              selectedFillColor: const Color(0xffEC008C),
                            ),
                            child: WeekdaySelector(
                              onChanged: (int day) {
                                setState(() {
                                  final index = day % 7;
                                  habitoController.setValuesIndex(
                                      !habitoController.values[index], index);
                                  if (habitoController.values
                                      .every((element) => element == true)) {
                                    habitoController.setDiario(true);
                                  } else {
                                    habitoController.setDiario(false);
                                  }
                                });
                              },
                              firstDayOfWeek: dateSymbols.FIRSTDAYOFWEEK + 1,
                              shortWeekdays:
                                  dateSymbols.STANDALONENARROWWEEKDAYS,
                              weekdays: dateSymbols.STANDALONEWEEKDAYS,
                              values: habitoController.values,
                            ),
                          ),
                        )
                      : Container(),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: habitoController.notification ? 1.0 : 0.0,
                  child: habitoController.notification
                      ? Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Adicionar horarios',
                                    style: GoogleFonts.urbanist(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      TimePicker.show(
                                        context: context,
                                        sheet: TimePickerSheet(
                                          sheetTitle: 'Escolha um horario',
                                          hourTitle: 'Hora',
                                          minuteTitle: 'Minutos',
                                          saveButtonText: 'Salvar',
                                          minuteInterval: 1,
                                          saveButtonColor:
                                              const Color(0xffEC008C),
                                          sheetCloseIconColor:
                                              const Color(0xffEC008C),
                                          sheetTitleStyle: GoogleFonts.urbanist(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                          hourTitleStyle: GoogleFonts.urbanist(
                                            color: const Color(0xffEC008C),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          minuteTitleStyle:
                                              GoogleFonts.urbanist(
                                            color: const Color(0xffEC008C),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          wheelNumberSelectedStyle:
                                              GoogleFonts.urbanist(
                                            color: const Color(0xffEC008C),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ).then((value) {
                                        if (value == null) {
                                          return;
                                        }

                                        habitoController.addHorario(
                                          value.toString().substring(11, 16),
                                        );
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 200,
                                width: double.infinity,
                                child: Observer(builder: (_) {
                                  return ListView.builder(
                                    itemCount: habitoController.horarios.length,
                                    itemBuilder: (context, index) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 20,
                                                  width: 20,
                                                  decoration:
                                                      const BoxDecoration(
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                        'assets/clock.png',
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Text(
                                                  habitoController
                                                      .horarios[index],
                                                  style: GoogleFonts.urbanist(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              habitoController
                                                  .removerHorario(index);
                                            },
                                            icon: const Icon(
                                              Icons.remove,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 200, right: 18),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xff373645),
                    ),
                    onPressed: () {
                      if (textEditingController.text.isEmpty) {
                        showTopSnackBar(
                          context,
                          CustomSnackBar.info(
                            backgroundColor: Colors.orange,
                            message: 'Você deve adicionar uma nome ao hábito',
                            textStyle:
                                GoogleFonts.urbanist(color: Colors.white),
                          ),
                        );
                      } else {
                        habitoController
                            .updateHabito(
                                widget.habito, textEditingController.text)
                            .then(
                          (value) {
                            showResponse(value, context);
                            if (value.type == 'success') {
                              habitoController.resetElements();
                              textEditingController.text = '';

                              Navigator.pop(context);
                            }
                          },
                        );
                      }
                    },
                    child: Text(
                      'Salvar',
                      style: GoogleFonts.urbanist(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  showResponse(ResultMessage message, BuildContext context) {
    switch (message.type) {
      case 'error':
        showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: message.message,
            textStyle: GoogleFonts.urbanist(color: Colors.white),
          ),
        );
        break;
      case 'success':
        showTopSnackBar(
          context,
          CustomSnackBar.success(
            message: message.message,
            textStyle: GoogleFonts.urbanist(color: Colors.white),
          ),
        );
        break;
      case 'info':
        showTopSnackBar(
          context,
          CustomSnackBar.info(
            backgroundColor: Colors.orange,
            message: message.message,
            textStyle: GoogleFonts.urbanist(color: Colors.white),
          ),
        );
        break;
      default:
        print('erro');
    }
  }
}

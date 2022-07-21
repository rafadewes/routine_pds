import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../controllers/emocionario/emocionario_controller.dart';
import 'emojis_button.dart';

class CustomFABEmocionarioWidget extends StatefulWidget {
  const CustomFABEmocionarioWidget({Key? key}) : super(key: key);

  @override
  State<CustomFABEmocionarioWidget> createState() => _CustomFABWidgetState();
}

class _CustomFABWidgetState extends State<CustomFABEmocionarioWidget> {
  EmocionarioController emocionarioController = EmocionarioController();

  @override
  void dispose() {
    emocionarioController.resetCalendarSelectDate();
    emocionarioController.resetSelectedDate();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedColor: Colors.transparent,
      closedShape: const CircleBorder(),
      transitionType: ContainerTransitionType.fadeThrough,
      transitionDuration: const Duration(seconds: 1),
      closedBuilder: (context, openContainer) => Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: 2,
            color: const Color(0xffEC008C),
          ),
        ),
        height: 56,
        width: 56,
        child: const Icon(Icons.add, color: Color(0xffEC008C)),
      ),
      openBuilder: (context, _) => Observer(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xff23212C),
              title: Text(
                'Emocionário',
                style: GoogleFonts.urbanist(
                  color: Colors.white,
                ),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  if (emocionarioController.selectedDate != null) {
                    emocionarioController.resetCalendarSelectDate();
                    emocionarioController.resetSelectedDate();
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
            ),
            body: SafeArea(
              child: emocionarioController.selectedDate == null
                  ? bodyCalendar()
                  : bodyEmojis(),
            ),
          );
        },
      ),
    );
  }

  Container bodyEmojis() {
    return Container(
      color: const Color(0xff23212C),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              alignment: Alignment.center,
              width: 300,
              height: 300,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Como você está\n se sentindo?",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.urbanist(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  EmojiButton(
                    image: 'assets/emojis/smile.png',
                    emocao: 'Feliz',
                    a: 1,
                    b: 0,
                    emocionarioController: emocionarioController,
                  ),
                  EmojiButton(
                    image: 'assets/emojis/crying.png',
                    emocao: 'Triste',
                    a: -0.7,
                    b: -0.7,
                    emocionarioController: emocionarioController,
                  ),
                  EmojiButton(
                    image: 'assets/emojis/love.png',
                    emocao: 'Apaixonado',
                    a: -0,
                    b: -1,
                    emocionarioController: emocionarioController,
                  ),
                  EmojiButton(
                    image: 'assets/emojis/sick.png',
                    emocao: 'Chateado',
                    a: 0.7,
                    b: -0.7,
                    emocionarioController: emocionarioController,
                  ),
                  EmojiButton(
                    image: 'assets/emojis/sleep.png',
                    emocao: 'Cansado',
                    a: -1,
                    b: 0,
                    emocionarioController: emocionarioController,
                  ),
                  EmojiButton(
                    image: 'assets/emojis/cute.png',
                    emocao: 'Animado',
                    a: -0.7,
                    b: 0.6,
                    emocionarioController: emocionarioController,
                  ),
                  EmojiButton(
                    image: 'assets/emojis/angry.png',
                    emocao: 'Irritado',
                    a: 0,
                    b: 1,
                    emocionarioController: emocionarioController,
                  ),
                  EmojiButton(
                    image: 'assets/emojis/neutral.png',
                    emocao: 'Normal',
                    a: 0.7,
                    b: 0.6,
                    emocionarioController: emocionarioController,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bodyCalendar() {
    return Container(
      color: const Color(0xff23212C),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          TableCalendar(
            locale: 'pt_BR',
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleTextStyle: GoogleFonts.urbanist(
                color: Colors.white,
              ),
              rightChevronIcon: const Icon(
                Icons.chevron_right,
                color: Colors.white,
              ),
              leftChevronIcon: const Icon(
                Icons.chevron_left,
                color: Colors.white,
              ),
              titleCentered: true,
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: GoogleFonts.urbanist(
                color: Colors.white,
              ),
            ),
            calendarStyle: CalendarStyle(
              defaultTextStyle: GoogleFonts.urbanist(
                color: Colors.white,
              ),
            ),
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: emocionarioController.calendarSelectDate,
            selectedDayPredicate: (day) {
              return isSameDay(emocionarioController.selectedDate, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              emocionarioController.setCalendarSelectDate(selectedDay);
              emocionarioController.setSelectedDate(selectedDay);
            },
          ),
        ],
      ),
    );
  }
}

import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ooadproject/doctor/patient%20list/patient_profile.dart';
import 'package:ooadproject/welcome.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class AppointmentWithoutWeekends extends StatefulWidget {
  AppointmentWithoutWeekends({super.key, required this.doc});
  Doctor doc;
  @override
  CalendarAppointment createState() => CalendarAppointment();
}

class CalendarAppointment extends State<AppointmentWithoutWeekends> {
  final CalendarDataSource _dataSource = _DataSource(<Appointment>[]);
  final List<Color> _colorCollection = <Color>[];
  List<TimeRegion> _specialTimeRegion = <TimeRegion>[];
  final CalendarController _calendarController = CalendarController();

  @override
  void initState() {
    _getColorCollection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Doctor giveDoctor() {
      return widget.doc;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Appointment Schedule"),
        // Theme.of(context).scaffoldBackgroundColor,
        elevation: 3,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back,
        //       color: Color.fromARGB(255, 255, 255, 255)),
        //   onPressed: () => Navigator.of(
        //     context,
        //     rootNavigator: true,
        //   ).pop(
        //     context,
        //   ),
        // ),
      ),
      body: SafeArea(
        child: SfCalendar(
          dataSource: _dataSource,
          view: CalendarView.week,
          allowedViews: const [
            CalendarView.day,
            CalendarView.week,
            CalendarView.month,
          ],
          onViewChanged: viewChanged,
          specialRegions: _specialTimeRegion,
        ),
      ),
    );
  }

  void viewChanged(ViewChangedDetails viewChangedDetails) {
    Doctor doc = widget.doc;
    List<DateTime> visibleDates = viewChangedDetails.visibleDates;
    List<TimeRegion> timeRegion = <TimeRegion>[];
    List<Appointment> appointments = <Appointment>[];
    _dataSource.appointments!.clear();

    for (int i = 0; i < visibleDates.length; i++) {
      if (visibleDates[i].weekday == 6 || visibleDates[i].weekday == 7) {
        continue;
      }
      timeRegion.add(
        TimeRegion(
            startTime: DateTime(visibleDates[i].year, visibleDates[i].month,
                visibleDates[i].day, 13, 0, 0),
            endTime: DateTime(visibleDates[i].year, visibleDates[i].month,
                visibleDates[i].day, 14, 0, 0),
            text: 'Break',
            enablePointerInteraction: true),
      );

      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {
          _specialTimeRegion = timeRegion;
        });
      });
    }
    for (int i = 0; i < doc.MyAppointments.length; i++) {
      DateTime endTime = doc.MyAppointments[i].endTime;
      bool doGrey = ((endTime.year < DateTime.now().year) ||
          (endTime.year == DateTime.now().year &&
              endTime.month < DateTime.now().month) ||
          (endTime.year == DateTime.now().year &&
              endTime.month == DateTime.now().month &&
              endTime.day < DateTime.now().day) ||
          (endTime.year == DateTime.now().year &&
              endTime.month == DateTime.now().month &&
              endTime.day == DateTime.now().day &&
              endTime.hour < DateTime.now().hour) ||
          ((endTime.year == DateTime.now().year &&
              endTime.month == DateTime.now().month &&
              endTime.day == DateTime.now().day &&
              endTime.hour == DateTime.now().hour &&
              endTime.minute < DateTime.now().minute)));
      Random random = Random();
      appointments.add(Appointment(
          startTime: doc.MyAppointments[i].startTime,
          endTime: doc.MyAppointments[i].endTime,
          subject: doc.MyAppointments[i].patient.name,
          color: (doGrey)
              ? (Colors.grey)
              : (_colorCollection[random.nextInt(9)])));
    }
    for (int i = 0; i < appointments.length; i++) {
      _dataSource.appointments!.add(appointments[i]);
    }
    _dataSource.notifyListeners(
        CalendarDataSourceAction.reset, _dataSource.appointments!);
  }

  

  void _getColorCollection() {
    _colorCollection.add(const Color(0xFF0F8644));
    _colorCollection.add(const Color(0xFF8B1FA9));
    _colorCollection.add(const Color(0xFFD20100));
    _colorCollection.add(const Color(0xFFFC571D));
    _colorCollection.add(const Color(0xFF36B37B));
    _colorCollection.add(const Color(0xFF01A1EF));
    _colorCollection.add(const Color(0xFF3D4FB5));
    _colorCollection.add(const Color(0xFFE47C73));
    _colorCollection.add(const Color(0xFF636363));
    _colorCollection.add(const Color(0xFF0A8043));
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments = source;
  }
}

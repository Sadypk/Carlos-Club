import 'package:flutter/material.dart';
import 'package:flutter_app/utils/sizeConfig.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderView extends StatelessWidget {
  final GetSizeConfig sizeConfig = Get.find();

  final CalendarController controller = CalendarController();

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      calendarController: controller,
      onDaySelected: (date,event,c){
        Get.dialog(Dialog(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${DateFormat('dd MMM').format(date)}',
                  style: TextStyle(
                      fontSize: sizeConfig.getSize(22)
                  ),
                ),
                SizedBox(height: sizeConfig.height * 20,),
                Text(
                  'Checked In at ${event[0]}',
                  style: TextStyle(
                    fontSize: sizeConfig.getSize(20)
                  ),
                ),
              ],
            ),
          ),
        ));
      },
      calendarStyle: CalendarStyle(
        markersColor: Colors.green,
      ),
      initialCalendarFormat: CalendarFormat.month,
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonVisible: false
      ),
      builders: CalendarBuilders(
        markersBuilder: marker,
      ),
      events: {
        DateTime(2020, 11, 1): ['06:12'],
        DateTime(2020, 11, 2): ['07:32'],
        DateTime(2020, 11, 6): ['07:10'],
        DateTime(2020, 11, 14): ['06:45'],
        DateTime(2020, 11, 21): ['09:10'],
        DateTime(2020, 11, 22): ['08:45'],
      },
    );
  }

  List<Widget> marker(BuildContext context, DateTime date, List<dynamic> events, List<dynamic> holidays) {
    return events.map((e) => Container(
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.green
      ),
      height: sizeConfig.height * 15,
    )).toList();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_app/main_app/resources/size_config.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class CalenderView extends StatelessWidget {
  final GetSizeConfig sizeConfig = Get.find();
  final List<Timestamp> checkInData;
  final CalendarController controller = CalendarController();

  CalenderView({this.checkInData});

  @override
  Widget build(BuildContext context) {

    Map<DateTime, List<dynamic>> events = {};


    checkInData.forEach((element) {
      events.putIfAbsent(element.toDate(), () => [DateFormat().add_jm().format(element.toDate())]);
    });

    bool traveller = Get.arguments ?? false;

    return TableCalendar(
        calendarController: controller,
        onDaySelected: (date,event,c){
          if(traveller){
            if(event.length == 0){
              if(Get.isSnackbarOpen){
                Get.back();
                Get.back(result: date);
              }else{
                Get.back(result: date);

              }
            }else{
              Get.snackbar('Error', 'Check In Exists');
            }
          }else{
            if(event.length > 0){
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
            }

          }
        },
      endDay: DateTime.now(),
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
        events: events,
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
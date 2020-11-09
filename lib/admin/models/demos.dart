import 'package:flutter/cupertino.dart';

class DemoGroupCheckIn{
  String date;
  int present;
  int absent;
  DemoGroupCheckIn({
   @required this.date,
   @required this.present,
   @required this.absent
});
}
final List<DemoGroupCheckIn> demoGroupCheckInData = [
  DemoGroupCheckIn(date: '12/02/2020', present: 22, absent: 5),
  DemoGroupCheckIn(date: '13/02/2020', present: 21, absent: 4),
  DemoGroupCheckIn(date: '14/02/2020', present: 17, absent: 5),
  DemoGroupCheckIn(date: '15/02/2020', present: 11, absent: 12),
  DemoGroupCheckIn(date: '16/02/2020', present: 15, absent: 7),
  DemoGroupCheckIn(date: '17/02/2020', present: 22, absent: 8),
  DemoGroupCheckIn(date: '18/02/2020', present: 20, absent: 9),
  DemoGroupCheckIn(date: '19/02/2020', present: 28, absent: 6),
  DemoGroupCheckIn(date: '20/02/2020', present: 30, absent: 3),
  DemoGroupCheckIn(date: '21/02/2020', present: 22, absent: 4),
  DemoGroupCheckIn(date: '22/02/2020', present: 11, absent: 13),
];
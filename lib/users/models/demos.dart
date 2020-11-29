import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


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



class DemoCheckInModel{
  String time;
  String date;
  DemoCheckInModel({
    @required this.date,
    @required this.time
  });
}

final List<DemoCheckInModel> demoCheckInData = [
  DemoCheckInModel(date: '12-02-2020', time: '06:03'),
  DemoCheckInModel(date: '12-02-2020', time: '06:03'),
  DemoCheckInModel(date: '12-02-2020', time: '06:03'),
  DemoCheckInModel(date: '12-02-2020', time: '06:03'),
  DemoCheckInModel(date: '12-02-2020', time: '06:03'),
  DemoCheckInModel(date: '12-02-2020', time: '06:03'),
  DemoCheckInModel(date: '12-02-2020', time: '06:03'),
  DemoCheckInModel(date: '12-02-2020', time: '06:03'),
  DemoCheckInModel(date: '12-02-2020', time: '06:03'),
  DemoCheckInModel(date: '12-02-2020', time: '06:03'),
  DemoCheckInModel(date: '12-02-2020', time: '06:03'),
  DemoCheckInModel(date: '12-02-2020', time: '06:03'),
  DemoCheckInModel(date: '12-02-2020', time: '06:03'),
  DemoCheckInModel(date: '12-02-2020', time: '06:03'),
  DemoCheckInModel(date: '12-02-2020', time: '06:03'),
  DemoCheckInModel(date: '12-02-2020', time: '06:03'),
  DemoCheckInModel(date: '12-02-2020', time: '06:03'),
  DemoCheckInModel(date: '12-02-2020', time: '06:03'),
];

class DemoUsersModel{
  String image;
  String fName;
  String lName;
  bool admin;
  DemoUsersModel({
    this.image,
    this.fName,
    this.lName,
    this.admin = false
  });
}

final List<DemoUsersModel> demoGroupMembers = [
  DemoUsersModel(fName: 'Andrew',lName: 'Garfield', image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTAREpxUjgMdzWJZXXsJwiZNShvRGIdLC_jBA&usqp=CAU'),
  DemoUsersModel(fName: 'Brian',lName: 'Summer', image: 'https://i.ibb.co/6ZYm1h7/cd4576b9bb4b9d051d2ce9bd8cf3074f.jpg'),
  DemoUsersModel(admin: true, fName: 'Cinna' , lName: 'Winter', image: 'https://i.ibb.co/nQKjHg2/images-q-tbn-ANd9-Gc-T3ci1s1-De-Pfm-B-Y78-Spdd-WFK31ocv-Ncnzgqg-usqp-CAU.jpg'),
  DemoUsersModel(fName: 'Isha', lName: 'Talwar', image: 'https://i.ibb.co/4S5jDGt/images-q-tbn-ANd9-Gc-Tr-ETBr-Mye-UTj-G0f-JHVKAAomp7-Xv-Hr2-EYVyg-usqp-CAU.jpg'),
  DemoUsersModel(fName: 'Anna', lName: 'Kendrick', image: 'https://i.ibb.co/RhgNmTx/zj0t895.jpg'),
  DemoUsersModel(fName: 'Natalie', lName: 'Dormer', image: 'https://i.ibb.co/kx21J22/65be0dc3437c65b7e72a6d9d6c04a335.jpg'),
  DemoUsersModel(fName: 'Andrew',lName: 'Garfield', image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTAREpxUjgMdzWJZXXsJwiZNShvRGIdLC_jBA&usqp=CAU'),
  DemoUsersModel(fName: 'Brian',lName: 'Summer', image: 'https://i.ibb.co/6ZYm1h7/cd4576b9bb4b9d051d2ce9bd8cf3074f.jpg'),
  DemoUsersModel(fName: 'Cinna' , lName: 'Winter', image: 'https://i.ibb.co/nQKjHg2/images-q-tbn-ANd9-Gc-T3ci1s1-De-Pfm-B-Y78-Spdd-WFK31ocv-Ncnzgqg-usqp-CAU.jpg'),
  DemoUsersModel(fName: 'Isha', lName: 'Talwar', image: 'https://i.ibb.co/4S5jDGt/images-q-tbn-ANd9-Gc-Tr-ETBr-Mye-UTj-G0f-JHVKAAomp7-Xv-Hr2-EYVyg-usqp-CAU.jpg'),
  DemoUsersModel(fName: 'Anna', lName: 'Kendrick', image: 'https://i.ibb.co/RhgNmTx/zj0t895.jpg'),
  DemoUsersModel(fName: 'Natalie', lName: 'Dormer', image: 'https://i.ibb.co/kx21J22/65be0dc3437c65b7e72a6d9d6c04a335.jpg'),
  DemoUsersModel(fName: 'Andrew',lName: 'Garfield', image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTAREpxUjgMdzWJZXXsJwiZNShvRGIdLC_jBA&usqp=CAU'),
  DemoUsersModel(fName: 'Brian',lName: 'Summer', image: 'https://i.ibb.co/6ZYm1h7/cd4576b9bb4b9d051d2ce9bd8cf3074f.jpg'),
  DemoUsersModel(fName: 'Cinna' , lName: 'Winter', image: 'https://i.ibb.co/nQKjHg2/images-q-tbn-ANd9-Gc-T3ci1s1-De-Pfm-B-Y78-Spdd-WFK31ocv-Ncnzgqg-usqp-CAU.jpg'),
  DemoUsersModel(fName: 'Isha', lName: 'Talwar', image: 'https://i.ibb.co/4S5jDGt/images-q-tbn-ANd9-Gc-Tr-ETBr-Mye-UTj-G0f-JHVKAAomp7-Xv-Hr2-EYVyg-usqp-CAU.jpg'),
  DemoUsersModel(fName: 'Anna', lName: 'Kendrick', image: 'https://i.ibb.co/RhgNmTx/zj0t895.jpg'),
  DemoUsersModel(fName: 'Natalie', lName: 'Dormer', image: 'https://i.ibb.co/kx21J22/65be0dc3437c65b7e72a6d9d6c04a335.jpg'),
];
import 'package:flutter/material.dart';

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
  DemoUsersModel({
    this.image,
    this.fName,
    this.lName
});
}

final List<DemoUsersModel> demoGroupMembers = [
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
  DemoUsersModel(fName: 'Andrew',lName: 'Garfield', image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTAREpxUjgMdzWJZXXsJwiZNShvRGIdLC_jBA&usqp=CAU'),
  DemoUsersModel(fName: 'Brian',lName: 'Summer', image: 'https://i.ibb.co/6ZYm1h7/cd4576b9bb4b9d051d2ce9bd8cf3074f.jpg'),
  DemoUsersModel(fName: 'Cinna' , lName: 'Winter', image: 'https://i.ibb.co/nQKjHg2/images-q-tbn-ANd9-Gc-T3ci1s1-De-Pfm-B-Y78-Spdd-WFK31ocv-Ncnzgqg-usqp-CAU.jpg'),
  DemoUsersModel(fName: 'Isha', lName: 'Talwar', image: 'https://i.ibb.co/4S5jDGt/images-q-tbn-ANd9-Gc-Tr-ETBr-Mye-UTj-G0f-JHVKAAomp7-Xv-Hr2-EYVyg-usqp-CAU.jpg'),
  DemoUsersModel(fName: 'Anna', lName: 'Kendrick', image: 'https://i.ibb.co/RhgNmTx/zj0t895.jpg'),
  DemoUsersModel(fName: 'Natalie', lName: 'Dormer', image: 'https://i.ibb.co/kx21J22/65be0dc3437c65b7e72a6d9d6c04a335.jpg'),
];
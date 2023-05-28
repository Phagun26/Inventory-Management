import 'package:thispls/home.dart';
import 'package:thispls/models/Inventory.dart';
import 'package:thispls/models/account.dart';
import 'package:thispls/models/add_car.dart';
import 'package:thispls/models/carlist.dart';
import 'package:thispls/models/confirmation.dart';
import 'package:thispls/models/history.dart';
import 'package:thispls/models/inward.dart';
import 'package:thispls/models/login_page.dart';
import 'package:thispls/models/carlist.dart';
import 'package:thispls/models/outward.dart';
import 'package:thispls/models/requests.dart';
import 'package:thispls/models/updates.dart';
import 'models/Register.dart';
import 'models/rentersList.dart';
import 'models/welcome.dart';
import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;

void main() => runApp(myApp());

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    //http.post(Uri.parse("http://192.168.1.161:3000/"));
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        routes: {
          "/": (context) => welcomePage(),
          "/login": (context) => LoginDemo(),
          "/signup/dealer": (context) => Register_as_dealer(),
          // "/signup/Renter": (context) => Register_as_Renter(),
          "/addCar": (context) => add_car(),
          "/home": (context) => home(),
          "/renters": (context) => rentersList(),
          "/carlist": (context) => car_list(),
          "/request": (context) => request(),
          "/updates": (context) => updates(),
          "/account": (context) => account(),
          "/inward" : (context) => inward(),
          "/outward" : (context) => outward(),
          "/confirm" : (context) => confirmm(),
          "/inventory" : (context) => inventory(),
          "/history" : (context) => history(),


        });
  }
}



import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './Screens/Home.dart';

void main()
{
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_)
    {
        runApp(MyApp());
    });
}

class MyApp extends StatelessWidget
{
    @override
    Widget build(BuildContext context)
    {
        return MaterialApp(
            title: 'Gravity Simulation',
            theme: ThemeData(),
            home: HomeScreen(),
            debugShowCheckedModeBanner: false,
        );
    }
}


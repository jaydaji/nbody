import 'dart:core';
import 'package:flutter/material.dart';

import './Pages/Home.page.class.dart';

void main()
=> runApp(MyApp());

class MyApp extends StatelessWidget
{
    @override
    Widget build(BuildContext context)
    {
        return MaterialApp(
            title: 'Gravity Simulation',
            theme: ThemeData(),
            home: Home(),
            debugShowCheckedModeBanner: false,
        );
    }
}


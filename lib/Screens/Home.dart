//flutter imports
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

import '../Constants/Constants.dart';

import './Simulation.dart';
import './Shop.dart';

//home page widget that contains the scaffold
class HomeScreen extends StatelessWidget
{
    @override
    Widget build(BuildContext context)
    {
        return HomeWidget();
    }
}

//home content widget to go within the home page
class HomeWidget extends StatefulWidget
{
    @override
    HomeState createState()
    => HomeState();
}

class HomeState extends State<HomeWidget>
{
    @override
    Widget build(BuildContext context)
    {
        return Scaffold(
            appBar: AppBar(
                title: Text(
                    Constants.homeTitle,
                    style: TextStyle(
                        color: Colors.white,
                    ),
                ),
                centerTitle: true
            ),
            drawer: Drawer(child: ListView(
                children: <Widget>[
                    ListTile(
                        leading: Icon(Icons.brightness_5),
                        title: Text(Constants.gravityTitle),
                        onTap: ()
                        {
                            // change app state...
                            Navigator.pop(context);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context)
                                => SimulationScreen()));
                        },
                    ),
                    ListTile(
                        leading: Icon(Icons.shopping_cart),
                        title: Text(Constants.shopTitle),
                        onTap: ()
                        {
                            // change app state...
                            Navigator.pop(context);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context)
                                => ShopScreen())); // close the drawer
                        },
                    ),
                ]
            )),
            body: SafeArea(
                child: Center(),
            ),
        );
    }

}
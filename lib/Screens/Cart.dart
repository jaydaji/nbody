//flutter imports
import 'package:flutter/material.dart';

import '../Constants/Constants.dart';

//home page widget that contains the scaffold
class CartScreen extends StatelessWidget
{
    @override
    Widget build(BuildContext context)
    {
        return Scaffold(
            appBar: AppBar(
                title: Text(
                    Constants.shopTitle,
                    style: TextStyle(
                        color: Colors.white,
                    ),
                ),
                centerTitle: true),
            body: SafeArea(child: CartWidget()
            ),
        );
    }
}

//home content widget to go within the home page
class CartWidget extends StatefulWidget
{
    @override
    CartState createState()
    => CartState();
}

class CartState extends State<CartWidget>
{
    @override
    Widget build(BuildContext context)
    {
        return Scaffold(
            body: Center(

            ),
        );
    }

}
//flutter imports
import 'package:flutter/material.dart';

import '../Constants/Constants.dart';

import '../Screens/Cart.dart';

import '../Features/Shop/Data/Products.dart';
import '../Features/Shop/Components/ProductTile.dart';

import '../Features/Shop/State/ShopBloc.dart';

//home page widget that contains the scaffold
class ShopScreen extends StatelessWidget
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
                centerTitle: true,
                actions: <Widget>[IconButton(
                    icon: Icon(Icons.playlist_play),
                    tooltip: 'Air it',
                    onPressed: ()
                    {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context)
                            => CartScreen()));
                    },
                )
                ],),
            body: SafeArea(child: ShopWidget()
            ),
        );
    }
}

//home content widget to go within the home page
class ShopWidget extends StatefulWidget
{
    @override
    ShopState createState()
    => ShopState();
}

class ShopState extends State<ShopWidget>
{
    final ShopBloc shopBloc = ShopBloc();
    Products _products = Products();

    @override
    Widget build(BuildContext context)
    {
        return Scaffold(
            body: Center(
                child: ListView.builder(
                    itemCount: _products
                        .getProducts()
                        .length,
                    itemBuilder: (context, index)
                    {
                        return ProductTileWidget(_products.getProducts()[index]);
                    },
                ),
            ),
        );
    }

}
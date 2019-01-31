import 'package:flutter/material.dart';
import '../Models/Product.dart';

import '../State/ShopBloc.dart';

class ProductTileWidget extends StatefulWidget
{
    Product _product;

    ProductTileWidget(product)
    {
        _product = product;
    }

    @override
    ProductTileState createState()
    => ProductTileState(_product);
}

class ProductTileState extends State<ProductTileWidget>
{
    final ShopBloc shopBloc = ShopBloc();
    Product _product;

    ProductTileState(product)
    {
        _product = product;
    }

    @override
    void initState()
    {
        super.initState();
    }

    @override
    Widget build(BuildContext context)
    {
        return createTile();
    }

    Widget createTile()
    {
        return Card(
            child: Column(
                children: <Widget>[
                    ListTile(
                        leading: RaisedButton(
                            child: Text("Add to Cart"),
                            onPressed: ()
                            {
                                shopBloc.dispatch(ShopEvent.increment);
                                print(shopBloc);
                            }),
                        title: Text(this._product.getName()),
                        subtitle: Text(this._product.getPrice().toString()),
                        trailing: RaisedButton(
                            child: Text("Remove from Cart"),
                            onPressed: ()
                            {
                                shopBloc.dispatch(ShopEvent.decrement);
                                print(shopBloc);
                            }),
                    ),
                ],
            ),
        );
    }

}
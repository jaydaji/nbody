import 'package:flutter_test/flutter_test.dart';
import 'package:nbody/Features/Shop/Components/ProductTile.dart';
import 'package:nbody/Features/Shop/Data/Products.dart';

void main()
{
    test('ProductTileWidget can be constructed with a product', ()
    {
        print('ProductTileWidget can be constructed with a product');
        Products products = Products();

        ProductTileWidget productTile = ProductTileWidget(products.getProducts()[2]);
        expect(productTile.runtimeType, ProductTileWidget);
    });
}
import '../Models/Product.dart';

class Products
{
    List<Product> products = <Product>[];

    Products()
    {
        products.add(Product(name: "Sledgehammer", price: 125.75));
        products.add(Product(name: "Axe", price: 190.50));
        products.add(Product(name: "Bandsaw", price: 562.13));
        products.add(Product(name: "Chisel", price: 12.9));
        products.add(Product(name: "Hacksaw", price: 18.45));
    }

    getProducts()
    {
        return products;
    }

}
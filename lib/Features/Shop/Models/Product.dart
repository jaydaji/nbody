class Product
{
    String _name;
    double _price;

    Product({String name, double price})
    {
        _name = name;
        _price = price;
    }

    String getName()
    {
        return _name;
    }

    double getPrice()
    {
        return _price;
    }

}
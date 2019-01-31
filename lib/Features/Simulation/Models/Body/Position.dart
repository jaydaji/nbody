class BodyPosition
{
    double _positionX;
    double _positionY;

    BodyPosition({double positionX = 200.0, double positionY = 200.0})
    {
        this._positionX = positionX;
        this._positionY = positionY;
    }

    void setX(positionX)
    {
        this._positionX = positionX;
    }

    void setY(positionY)
    {
        this._positionY = positionY;
    }

    double getX()
    {
        return this._positionX;
    }

    double getY()
    {
        return this._positionY;
    }
}
class BodyAcceleration
{
    double _accelerationX;
    double _accelerationY;

    BodyAcceleration({double accelerationX = 0.0, double accelerationY = 0.0})
    {
        this._accelerationX = accelerationX;
        this._accelerationY = accelerationY;
    }

    void setX(accelerationX)
    {
        this._accelerationX = accelerationX;
    }

    void setY(accelerationY)
    {
        this._accelerationY = accelerationY;
    }

    double getX()
    {
        return this._accelerationX;
    }

    double getY()
    {
        return this._accelerationY;
    }

}
class BodyVelocity
{
    double _velocityX;
    double _velocityY;

    BodyVelocity({double velocityX = 0.0, double velocityY = 0.0})
    {
        this._velocityX = velocityX;
        this._velocityY = velocityY;
    }

    void setX(velocityX)
    {
        this._velocityX = velocityX;
    }

    void setY(velocityY)
    {
        this._velocityY = velocityY;
    }

    double getX()
    {
        return this._velocityX;
    }

    double getY()
    {
        return this._velocityY;
    }
}
import './Position.dart';
import './Velocity.dart';
import './Acceleration.dart';

import 'dart:math';

class Body
{
    double G = 6.673e-11; // gravitational constant

    BodyPosition _position;
    BodyVelocity _velocity;
    BodyAcceleration _acceleration;

    double _radius; // force components
    double _mass; // mass

    // create and initialize a new Body
    Body(BodyPosition position, BodyVelocity velocity, double mass)
    {
        this._position = position;
        this._velocity = velocity;
        this._mass = mass;
        this._acceleration = BodyAcceleration();

        if (this._mass != 3.0)
        {
            this._radius = (
                (3 * (
                    this._mass / (pi * 4)
                )) / 3) * 500;
        }
        else
        {
            this._radius = 10.0;
        }
    }

    void setPosition(BodyPosition position)
    {
        this._position.setX(position.getX());
        this._position.setY(position.getY());
    }

    BodyPosition getPosition()
    {
        return this._position;
    }

    // update the velocity and position using a timestep dt
    void update(double dt)
    {
        dt = 350000000.0;
        this._velocity.setX(this._velocity.getX() + dt * this._acceleration.getX() / this._mass);
        this._velocity.setY(this._velocity.getY() + dt * this._acceleration.getY() / this._mass);
        this._position.setX(this._position.getX() + dt * this._velocity.getX());
        this._position.setY(this._position.getY() + dt * this._velocity.getY());
    }

    // returns the distance between two bodies
    double distanceTo(Body b)
    {
        double distanceX = this._position.getX() - b._position.getX();
        double distanceY = this._position.getY() - b._position.getY();
        return sqrt(distanceX * distanceX + distanceY * distanceY);
    }

    // set the force to 0 for the next iteration

    void resetForce()
    {
        this._acceleration.setX(0.0);
        this._acceleration.setY(0.0);
    }

    // compute the net force acting between the body a and b, and
    // add to the net force acting on a

    void addForce(Body b)
    {
        Body a = this;
        double EPS = 3E4; // softening parameter (just to avoid infinities)
        double distanceX = b._position.getX() - a._position.getX();
        double distanceY = b._position.getY() - a._position.getY();
        double distance = sqrt(distanceX * distanceX + distanceY * distanceY);
        double F = (G * a._mass * b._mass) / (distance * distance + EPS * EPS);
        a._acceleration.setX(a._acceleration.getX() + F * distanceX / distance);
        a._acceleration.setY(a._acceleration.getY() + F * distanceY / distance);
    }

    bool isValid()
    {
        if (this._position
            .getX()
            .runtimeType == double && this._position
            .getY()
            .runtimeType == double)
        {
            return true;
        }
        return false;
    }

    double getRadius()
    {
        return _radius;
    }
}

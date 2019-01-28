import './Position.class.dart';
import './Velocity.class.dart';
import './Acceleration.class.dart';

import 'dart:math';

class Body
{
    double G = 6.673e-11; // gravitational constant

    Position _position;
    Momentum _velocity;
    Acceleration _acceleration;

    double radius; // force components
    double mass; // mass

    // create and initialize a new Body
    Body(Position position, Momentum velocity, double mass)
    {
        this._position = new Position(position.getX(), position.getY());
        this._velocity = new Momentum(velocity.getX(), velocity.getY());
        this._acceleration = new Acceleration(0.0, 0.0);

        this.mass = mass;
        if (this.mass != 3.0)
        {
            this.radius = (
                (3 * (
                    this.mass / (pi * 4)
                )) / 3) * 500;
        }
        else
        {
            this.radius = 10.0;
        }
    }

    void setPosition(Position position)
    {
        this._position.setX(position.getX());
        this._position.setY(position.getY());
    }

    Position getPosition()
    {
        return this._position;
    }

    // update the velocity and position using a timestep dt
    void update(double dt)
    {
        dt = 500000000.0;
        this._velocity.setX(this._velocity.getX() + dt * this._acceleration.getX() / mass);
        this._velocity.setY(this._velocity.getY() + dt * this._acceleration.getY() / mass);
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
        double F = (G * a.mass * b.mass) / (distance * distance + EPS * EPS);
        a._acceleration.setX(a._acceleration.getX() + F * distanceX / distance);
        a._acceleration.setY(a._acceleration.getY() + F * distanceY / distance);
    }
}

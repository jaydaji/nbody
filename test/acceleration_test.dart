import 'package:flutter_test/flutter_test.dart';

import 'package:nbody/Features/Simulation/Models/Body/Acceleration.dart';

void main()
{
    test('Acceleration properties return doubles', ()
    {
        print('Acceleration properties return doubles');
        BodyAcceleration acceleration = BodyAcceleration();
        expect(acceleration
            .getX()
            .runtimeType, double);
        expect(acceleration
            .getY()
            .runtimeType, double);
    });

    test('Acceleration can be instantiated with default values', ()
    {
        print('Acceleration can be instantiated with default values');
        BodyAcceleration acceleration = BodyAcceleration();
        expect(acceleration.getX(), 0.0);
        expect(acceleration.getY(), 0.0);
    });

    test('Acceleration can be instantiated with passed values', ()
    {
        print('Acceleration can be instantiated with passed values');
        BodyAcceleration acceleration = BodyAcceleration(accelerationX: 10.0, accelerationY: 10.0);
        expect(acceleration.getX(), 10.0);
        expect(acceleration.getY(), 10.0);
    });

    test('Acceleration properties can be set using public setters', ()
    {
        print('Acceleration properties can be set using public setters');
        BodyAcceleration acceleration = BodyAcceleration();
        expect(acceleration.getX(), 0.0);
        expect(acceleration.getY(), 0.0);
        acceleration.setX(20.0);
        acceleration.setY(20.0);
        expect(acceleration.getX(), 20.0);
        expect(acceleration.getY(), 20.0);
    });
}
import 'package:flutter_test/flutter_test.dart';

import 'package:nbody/Features/Simulation/Models/Body/Velocity.dart';

void main()
{
    test('Velocity properties return doubles', ()
    {
        print('Velocity properties return doubles');
        BodyVelocity velocity = BodyVelocity();
        expect(velocity
            .getX()
            .runtimeType, double);
        expect(velocity
            .getY()
            .runtimeType, double);
    });

    test('Velocity can be instantiated with default values', ()
    {
        print('Velocity can be instantiated with default values');
        BodyVelocity velocity = BodyVelocity();
        expect(velocity.getX(), 0.0);
        expect(velocity.getY(), 0.0);
    });

    test('Velocity can be instantiated with passed values', ()
    {
        print('Velocity can be instantiated with passed values');
        BodyVelocity velocity = BodyVelocity(velocityX: 10.0, velocityY: 10.0);
        expect(velocity.getX(), 10.0);
        expect(velocity.getY(), 10.0);
    });

    test('Velocity properties can be set using public setters', ()
    {
        print('Velocity properties can be set using public setters');
        BodyVelocity velocity = BodyVelocity();
        expect(velocity.getX(), 0.0);
        expect(velocity.getY(), 0.0);
        velocity.setX(20.0);
        velocity.setY(20.0);
        expect(velocity.getX(), 20.0);
        expect(velocity.getY(), 20.0);
    });
}
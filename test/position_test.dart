import 'package:flutter_test/flutter_test.dart';

import 'package:nbody/Features/Simulation/Models/Body/Position.dart';

void main()
{
    test('Position properties return doubles', ()
    {
        print('Position properties return doubles');
        BodyPosition position = BodyPosition();
        expect(position
            .getX()
            .runtimeType, double);
        expect(position
            .getY()
            .runtimeType, double);
    });

    test('Position can be instantiated with default values of 200.0', ()
    {
        print('Position can be instantiated with default values');
        BodyPosition position = BodyPosition();
        expect(position.getX(), 200.0);
        expect(position.getY(), 200.0);
    });

    test('Position can be instantiated with passed values', ()
    {
        print('Position can be instantiated with passed values');
        BodyPosition position = BodyPosition(positionX: 10.0, positionY: 10.0);
        expect(position.getX(), 10.0);
        expect(position.getY(), 10.0);
    });

    test('Position properties can be set using public setters', ()
    {
        print('Position properties can be set using public setters');
        BodyPosition position = BodyPosition();
        expect(position.getX(), 200.0);
        expect(position.getY(), 200.0);
        position.setX(300.0);
        position.setY(300.0);
        expect(position.getX(), 300.0);
        expect(position.getY(), 300.0);
    });
}
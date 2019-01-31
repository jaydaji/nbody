import 'package:flutter_test/flutter_test.dart';

import 'package:nbody/Constants/Constants.dart';

void main()
{
    test('Title should be Gravity Simulation', ()
    {
        print('Title should be Gravity Simulation');
        expect(Constants.gravityTitle, 'Gravity Simulation');
    });

    test('Title should be Home', ()
    {
        print('Title should be Home');
        expect(Constants.homeTitle, 'Home');
    });
}
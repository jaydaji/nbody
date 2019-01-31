//dart imports
import 'dart:math';
import 'dart:core';
import 'dart:ui';

//flutter imports
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

//constants
import '../Constants/Constants.dart';

//models for bodies
import '../Features/Simulation/Models/Body/Body.dart';
import '../Features/Simulation/Models/Body/Position.dart';
import '../Features/Simulation/Models/Body/Velocity.dart';

//home page widget that contains the scaffold
class SimulationScreen extends StatelessWidget
{
    @override
    Widget build(BuildContext context)
    {
        return Scaffold(
            appBar: AppBar(
                title: Text(
                    Constants.gravityTitle,
                    style: TextStyle(
                        color: Colors.white,
                    ),
                ),
                centerTitle: true),
            body: SafeArea(child: SimulationWidget()
            ),
        );
    }
}

//home content widget to go within the home page
class SimulationWidget extends StatefulWidget
{
    @override
    SimulationState createState()
    => SimulationState();
}

class SimulationState extends State<SimulationWidget>
    with TickerProviderStateMixin
{
    Animation<double> animation;
    List<Body> bodys = <Body>[];

    AnimationController _controller;

    @override
    void initState()
    {
        super.initState();
        setupAnimation();
        setupSimulation();
    }

    setupAnimation()
    {
        _controller = AnimationController(
            duration: const Duration(milliseconds: 15), vsync: this);
        animation = Tween(begin: 0.0, end: 100.0).animate(_controller);

        animation.addStatusListener((status)
        {
            if (status == AnimationStatus.completed)
            {
                _controller.forward(from: 0.0);
            }
        });
    }

    setupSimulation()
    {
        _controller.addListener(()
        {
            setState(()
            {
                runSimulation(bodys.length);
            });
        });

        _controller.forward();
    }

    runSimulation(int bodysLength)
    {
        calculateForces(bodysLength);
        //Then, loop again and update the bodies using timestep dt
        for (int i = 1; i < bodysLength; i++)
        {
            bodys[i].update(0.0);
        }
    }

    calculateForces(int bodysLength)
    {
        for (int i = 0; i < bodysLength; i++)
        {
            bodys[i].resetForce();
            //Notice-2 loops-->N^2 complexity
            for (int j = 0; j < bodysLength; j++)
            {
                if (i != j) bodys[i].addForce(bodys[j]);
            }
        }
    }

    dispose()
    {
        _controller.dispose();
        super.dispose();
    }

    Widget createDrawer()
    {
        return Drawer(child: ListTile(
            leading: Icon(Icons.brightness_5),
            title: Text('Gravity Simulation'),
            onTap: ()
            {
                // change app state...
                Navigator.pop(context); // close the drawer
            },
        ));
    }

    Widget createBody(MediaQueryData mediaQueryData)
    {
        return Center(
            child: Container(
                height: mediaQueryData.size.height,
                width: mediaQueryData.size.width,
                child: CustomPaint(
                    foregroundPainter: MyPainter(this.bodys),
                    child: Padding(
                        padding: const EdgeInsets.all(100.0),
                    ),
                ),
            ),
        );
    }

    Widget createFab(MediaQueryData mediaQueryData)
    {
        return FloatingActionButton(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            child: Icon(Icons.add),
            onPressed: ()
            {
                generateNewParticle(mediaQueryData);
            },
        );
    }

    @override
    Widget build(BuildContext context)
    {
        final mediaQueryData = MediaQuery.of(context);

        return Scaffold(
            drawer: createDrawer(),
            body: createBody(mediaQueryData),
            floatingActionButton: createFab(mediaQueryData),
        );
    }

    double generateRandomNumber()
    {
        return Random().nextInt(100).toDouble();
    }

    void generateNewParticle(MediaQueryData mediaQueryData)
    {
        if (bodys.length < 1)
        {
            generateBlackHole(mediaQueryData);
        }
        for (int i = 0; i < 5; ++i)
        {
            bodys.add(Body(
                BodyPosition(positionX: generateRandomNumber(), positionY: generateRandomNumber()),
                BodyVelocity(velocityX: 0.0000000080, velocityY: -0.00000000300),
                Random().nextDouble() / 15)
            );
        }
    }

    void generateBlackHole(MediaQueryData mediaQueryData)
    {
        bodys.add(
            Body(
                BodyPosition(positionX: mediaQueryData.size.width / 2, positionY: mediaQueryData.size.height / 2.5),
                BodyVelocity(velocityX: 0.0, velocityY: 0.0),
                3.0)
        );
    }

}

class MyPainter extends CustomPainter
{
    List<Body> _bodys;

    MyPainter(List<Body> bodys)
    {
        _bodys = bodys;
    }

    @override
    void paint(Canvas canvas, Size size)
    {
        Paint nbody = Paint()
            ..color = Colors.black;
        //This draws the bodies
        for (int i = 0; i < _bodys.length; ++i)
        {
            paintBody(i, canvas, nbody);
        }
    }

    paintBody(int i, Canvas canvas, Paint nbody)
    {
        if (_bodys[i].isValid())
        {
            Offset position = Offset(_bodys[i].getPosition().getX(), _bodys[i].getPosition().getY());

            canvas.drawCircle(position, _bodys[i].getRadius(), nbody);
        }
    }

    @override
    bool shouldRepaint(CustomPainter oldDelegate)
    {
        return true;
    }
}
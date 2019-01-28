import 'dart:math';
import 'dart:core';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

import './Constants/Constants.class.dart';

import './Models/Body/Body.class.dart';
import './Models/Body/Position.class.dart';
import './Models/Body/Velocity.class.dart';

void main()
=> runApp(MyApp());

class MyApp extends StatelessWidget
{
    @override
    Widget build(BuildContext context)
    {
        return MaterialApp(
            title: 'Gravity Simulation',
            theme: ThemeData(),
            home: Home(),
            debugShowCheckedModeBanner: false,
        );
    }
}

class Home extends StatelessWidget
{
    @override
    Widget build(BuildContext context)
    {
        return Scaffold(
            appBar: AppBar(
                title: Text(
                    Constants.title,
                    style: TextStyle(
                        color: Colors.white,
                    ),
                ),
                backgroundColor: Constants.backgroundColor,
                centerTitle: true),
            body: HomeContent());
    }
}

class HomeContent extends StatefulWidget
{
    @override
    _HomeContentState createState()
    => _HomeContentState();
}

class _HomeContentState extends State<HomeContent>
    with TickerProviderStateMixin
{
    Animation<double> animation;

    List<Body> bodys = [Body(BodyPosition(positionX: 200.0, positionY: 200.0),
        BodyVelocity(velocityX: 0.0, velocityY: 0.0),
        3.0)
    ];

    double percentage = 0.0;
    double newPercentage = 0.0;
    AnimationController controller;

    @override
    void initState()
    {
        super.initState();

        controller = AnimationController(
            duration: const Duration(milliseconds: 20), vsync: this);
        animation = Tween(begin: 0.0, end: 100.0).animate(controller);

        animation.addStatusListener((status)
        {
            if (status == AnimationStatus.completed)
            {
                controller.forward(from: 0.0);
            }
        });

        controller.addListener(()
        {
            setState(()
            {
                runSimulation(bodys.length);

                //percentage = lerpDouble(percentage, newPercentage, controller.value);
            });
        });

        controller.forward();

        setState(()
        {
            percentage = 0.0;

            /* controller = AnimationController(
          vsync: this, duration: new Duration(milliseconds: 3000));

     

      controller.forward(from: 0.0);*/
        });

        //
    }

    runSimulation(int bodysLength)
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
        //Then, loop again and update the bodies using timestep dt
        for (int i = 1; i < bodysLength; i++)
        {
            bodys[i].update(1e11);
        }
    }

    dispose()
    {
        controller.dispose();
        super.dispose();
    }

    @override
    Widget build(BuildContext context)
    {
        return Center(
            child: Container(
                height: 400.0,
                width: 400.0,
                child: CustomPaint(
                    foregroundPainter: MyPainter(
                        lineColor: Colors.amber,
                        completeColor: Colors.blueAccent,
                        completePercent: percentage,
                        bodys: this.bodys,
                        width: 8.0),
                    child: Padding(
                        padding: const EdgeInsets.all(100.0),
                        child: RaisedButton(
                            color: Colors.purple,
                            splashColor: Colors.blueAccent,
                            shape: CircleBorder(),
                            child: Text("Click"),
                            onPressed: ()
                            {
                                setState(()
                                {
                                    generateNewCircle();
                                    percentage = newPercentage;
                                    newPercentage += 10;
                                    if (newPercentage > 100.0)
                                    {
                                        percentage = 0.0;
                                        newPercentage = 0.0;
                                    }
                                    controller.forward(from: 0.0);
                                });
                            }),
                    ),
                ),
            ),
        );
    }

    double generateRandomNumber()
    {
        return Random().nextInt(250).toDouble();
    }

    void generateNewCircle()
    {
        bodys.add(Body(
            BodyPosition(positionX: generateRandomNumber(), positionY: generateRandomNumber()),
            BodyVelocity(velocityX: 0.000000005, velocityY: -0.0000000005),
            Random().nextDouble() / 2)
        );
    }
}

class MyPainter extends CustomPainter
{
    Color lineColor;
    Color completeColor;
    double completePercent;
    double width;
    List<Body> bodys;

    double x;
    double y;

    MyPainter({this.lineColor,
        this.completeColor,
        this.completePercent,
        this.bodys,
        this.width});

    @override
    void paint(Canvas canvas, Size size)
    {
        Paint line = Paint()
            ..color = lineColor
            ..strokeCap = StrokeCap.round
            ..style = PaintingStyle.stroke
            ..strokeWidth = width;
        Paint complete = Paint()
            ..color = completeColor
            ..strokeCap = StrokeCap.round
            ..style = PaintingStyle.stroke
            ..strokeWidth = width;

        Paint nbody = Paint()
            ..color = completeColor
            ..strokeWidth = width;

        Offset center = Offset(size.width / 2, size.height / 2);
        double radius = min(size.width / 2, size.height / 2);
        //This draws the outside circle
        canvas.drawCircle(center, radius, line);
        for (int i = 0; i < bodys.length; ++i)
        {
            Offset position = Offset(bodys[i].getPosition().getX(), bodys[i].getPosition().getY());
            canvas.drawCircle(position, bodys[i].getRadius(), nbody);
        }
        double arcAngle = 2 * pi * (completePercent / 100);
        //This draws the progress circle that fills in the above circle
        /*canvas.drawArc(new Rect.fromCircle(center: center, radius: radius), -pi / 2,
        arcAngle, false, complete);*/
    }

    @override
    bool shouldRepaint(CustomPainter oldDelegate)
    {
        return true;
    }
}


import 'dart:math';
import 'dart:core';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

void main()
=> runApp(new MyApp());

class MyApp extends StatelessWidget
{
    @override
    Widget build(BuildContext context)
    {
        return new MaterialApp(
            title: 'Flutter Experiments',
            theme: new ThemeData(),
            home: new Home(),
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
            appBar: new AppBar(
                elevation: 0.0,
                title: new Text(
                    "Flutter Experiments",
                    style: new TextStyle(
                        color: Colors.white,
                        fontFamily: 'Nunito',
                        letterSpacing: 1.0),
                ),
                backgroundColor: new Color(0xFF2979FF),
                centerTitle: true),
            body: new HomeContent());
    }
}

class HomeContent extends StatefulWidget
{
    @override
    _HomeContentState createState()
    => _HomeContentState();
}

class Pair
{
    Pair(this.x, this.y);

    int x;
    int y;
}

class _HomeContentState extends State<HomeContent>
    with TickerProviderStateMixin
{
    Animation<double> animation;
    List<Body> bodys = [Body(200.0, 200.0, 0.0, 0.0, 0.05)];
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
        for (int i = 0; i < bodysLength; i++)
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
        return new Center(
            child: new Container(
                height: 400.0,
                width: 400.0,
                child: new CustomPaint(
                    foregroundPainter: new MyPainter(
                        lineColor: Colors.amber,
                        completeColor: Colors.blueAccent,
                        completePercent: percentage,
                        bodys: this.bodys,
                        width: 8.0),
                    child: new Padding(
                        padding: const EdgeInsets.all(100.0),
                        child: new RaisedButton(
                            color: Colors.purple,
                            splashColor: Colors.blueAccent,
                            shape: new CircleBorder(),
                            child: new Text("Click"),
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
        return new Random().nextInt(500).toDouble();
    }

    void generateNewCircle()
    {
        bodys.add(Body(
            generateRandomNumber(), generateRandomNumber(), 0.0, 0.0, Random().nextDouble()));
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
        Paint line = new Paint()
            ..color = lineColor
            ..strokeCap = StrokeCap.round
            ..style = PaintingStyle.stroke
            ..strokeWidth = width;
        Paint complete = new Paint()
            ..color = completeColor
            ..strokeCap = StrokeCap.round
            ..style = PaintingStyle.stroke
            ..strokeWidth = width;

        Paint nbody = new Paint()
            ..color = completeColor
            ..strokeWidth = width;

        Offset center = new Offset(size.width / 2, size.height / 2);
        double radius = min(size.width / 2, size.height / 2);
        //This draws the outside circle
        canvas.drawCircle(center, radius, line);
        for (int i = 0; i < bodys.length; ++i)
        {
            Offset position = new Offset(bodys[i].positionX, bodys[i].positionY);
            canvas.drawCircle(position, bodys[i].radius, nbody);
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

class Body
{
    double G = 6.673e-11; // gravitational constant

    double positionX;
    double positionY; // holds the cartesian positions
    double velocityX;
    double velocityY; // velocity components
    double forceX;
    double forceY;
    double radius; // force components
    double mass; // mass

    // create and initialize a new Body
    Body(double positionX, double positionY, double velocityX, double velocityY, double mass)
    {
        this.positionX = positionX;
        this.positionY = positionY;
        this.velocityX = velocityX;
        this.velocityY = velocityY;
        this.mass = mass;
        this.radius = (
            (3 * (
                this.mass / (pi * 4)
            )) / 3) * 500;
    }

    // update the velocity and position using a timestep dt
    void update(double dt)
    {
        dt = 1000000000.0;
        velocityX += dt * forceX / mass;
        velocityY += dt * forceY / mass;
        positionX += dt * velocityX;
        positionY += dt * velocityY;
    }

    // returns the distance between two bodies
    double distanceTo(Body b)
    {
        double distanceX = positionX - b.positionX;
        double distanceY = positionY - b.positionY;
        return sqrt(distanceX * distanceX + distanceY * distanceY);
    }

    // set the force to 0 for the next iteration

    void resetForce()
    {
        forceX = 0.0;
        forceY = 0.0;
    }

    // compute the net force acting between the body a and b, and
    // add to the net force acting on a

    void addForce(Body b)
    {
        Body a = this;
        double EPS = 3E4; // softening parameter (just to avoid infinities)
        double distanceX = b.positionX - a.positionX;
        double distanceY = b.positionY - a.positionY;
        double distance = sqrt(distanceX * distanceX + distanceY * distanceY);
        double F = (G * a.mass * b.mass) / (distance * distance + EPS * EPS);
        a.forceX += F * distanceX / distance;
        a.forceY += F * distanceY / distance;
    }
}

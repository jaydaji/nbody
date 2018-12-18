import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Experiments',
      theme: new ThemeData(),
      home: new Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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

class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class Pair {
  Pair(this.x, this.y);

  int x;
  int y;
}

class _HomeContentState extends State<HomeContent>
    with TickerProviderStateMixin {
  List<Pair> points = [Pair(200, 200), new Pair(4, 7)];
  double percentage = 0.0;
  double newPercentage = 0.0;
  AnimationController percentageAnimationController;

  @override
  void initState() {
    super.initState();
    setState(() {
      points.add(Pair(20, 30));
      percentage = 0.0;
    });
    percentageAnimationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 100))
      ..addListener(() {
        setState(() {
          percentage = lerpDouble(
              percentage, newPercentage, percentageAnimationController.value);
        });
      });
    percentageAnimationController.forward();
  }

  dispose() {
    percentageAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Container(
        height: 400.0,
        width: 400.0,
        child: new CustomPaint(
          foregroundPainter: new MyPainter(
              lineColor: Colors.amber,
              completeColor: Colors.blueAccent,
              completePercent: percentage,
              points: this.points,
              width: 8.0),
          child: new Padding(
            padding: const EdgeInsets.all(100.0),
            child: new RaisedButton(
                color: Colors.purple,
                splashColor: Colors.blueAccent,
                shape: new CircleBorder(),
                child: new Text("Click"),
                onPressed: () {
                  setState(() {
                    generateNewCircle();
                    percentage = newPercentage;
                    newPercentage += 10;
                    if (newPercentage > 100.0) {
                      percentage = 0.0;
                      newPercentage = 0.0;
                    }
                    percentageAnimationController.forward(from: 0.0);
                  });
                }),
          ),
        ),
      ),
    );
  }

  int generateRandomNumber() {
    var rng = new Random();
    return rng.nextInt(500);
  }

  void generateNewCircle() {
    for (int i = 0; i < points.length; ++i) {
      points[i].x++;
      points[i].y++;
    }
    points.add(Pair(generateRandomNumber(), generateRandomNumber()));
  }
}

class MyPainter extends CustomPainter {
  Color lineColor;
  Color completeColor;
  double completePercent;
  double width;
  List<Pair> points;

  double x;
  double y;

  MyPainter(
      {this.lineColor,
      this.completeColor,
      this.completePercent,
      this.points,
      this.width});

  @override
  void paint(Canvas canvas, Size size) {
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
    for (int i = 0; i < points.length; ++i) {
      Offset random = new Offset(points[i].x / 2, points[i].y / 2);
      canvas.drawCircle(random, 8, nbody);
    }
    double arcAngle = 2 * pi * (completePercent / 100);
    //This draws the progress circle that fills in the above circle
    /*canvas.drawArc(new Rect.fromCircle(center: center, radius: radius), -pi / 2,
        arcAngle, false, complete);*/
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

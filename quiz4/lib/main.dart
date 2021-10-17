import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/physics.dart';
import 'balls.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: new Quiz4(),
    );
  }
}

class Quiz4 extends StatelessWidget {
  const Quiz4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fullscreenSize = MediaQuery.of(context).size;
    final appBar = AppBar(
      title: Text("Quiz4"),
      centerTitle: true,
    );
    return Scaffold(
      appBar: appBar,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: MainScreen(
          screenSize: Size(fullscreenSize.width,fullscreenSize.height - appBar.preferredSize.height),
        ),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  MainScreen({required this.screenSize, this.maximumRadius = 100});
  final Size screenSize;
  final double maximumRadius;
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  late AnimationController radiusController;
  late AnimationController ballMovementController;
  late Offset ballPosition;
  late double initialHeight;
  late double ballRadius;
  List<CustomPaint> balllist = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    radiusController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
      upperBound: widget.maximumRadius,
    );
    radiusController.addListener(() {
      setState(() {
        ballRadius = radiusController.value;
      });
    });
    ballMovementController = AnimationController(
      vsync: this,
      duration: Duration(seconds:5),
    );
    ballMovementController.addListener(() {
      setState(() {
        double ballheightp = initialHeight+ballMovementController.value*(widget.screenSize.height-25-initialHeight-ballRadius);
        ballPosition = Offset(ballPosition.dx,ballheightp);
      });
    });
    ballMovementController.addStatusListener((status) {
      if(status == AnimationStatus.completed){
      }
    });
    ballPosition = Offset.zero;
    initialHeight = 0;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    radiusController.dispose();
    ballMovementController.dispose();
    super.dispose();
  }

  void addingNewBall(){
    balllist.add(new CustomPaint(
        size: widget.screenSize,
        painter: Balls(
          position: ballPosition,
          radiusController: radiusController,
        ),
    ),);
  }

  void startFall(){
    setState(() {
      initialHeight = ballPosition.dy;
    });
      ballMovementController.animateWith(GravitySimulation(9.8, 0, 1.001, 0));
  }

  void onTapDown(TapDownDetails details){
    print("tap down");
    radiusController.reset();
    radiusController.forward();
    final RenderBox referenceBox = context.findRenderObject() as RenderBox;
    setState(() {
      ballPosition = referenceBox.globalToLocal(details.globalPosition);
    });
  }
  void onTapUp(TapUpDetails details){
    final RenderBox referenceBox = context.findRenderObject() as RenderBox;
    setState(() {
      ballPosition = referenceBox.globalToLocal(details.globalPosition);
    });
    radiusController.stop();
    if(radiusController.value > 0){
      startFall();
    }
  }
  void onPanStart(DragStartDetails details){
    print("pan satrt");
    if(!radiusController.isAnimating && radiusController.value<widget.maximumRadius){
      radiusController.reset();
      radiusController.forward();
    }
    final RenderBox referenceBox = context.findRenderObject() as RenderBox;
    setState(() {
      ballPosition = referenceBox.globalToLocal(details.globalPosition);
    });
  }

  void onPanUpdate(DragUpdateDetails details){
    print("pan update");
    final RenderBox referenceBox = context.findRenderObject() as RenderBox;
    setState(() {
      ballPosition = referenceBox.globalToLocal(details.globalPosition);
    });
  }

  void onPanEnd(DragEndDetails details){
    print("pan end");
    radiusController.stop();
    startFall();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onPanStart: onPanStart,
      onPanUpdate: onPanUpdate,
      onPanEnd: onPanEnd,
      child: CustomPaint(
        painter: Balls(radiusController: radiusController,position: ballPosition),
      ),
    );
  }
}




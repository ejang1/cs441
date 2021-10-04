import 'package:flutter/material.dart';
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
class Quiz4 extends StatefulWidget {
  const Quiz4({Key? key}) : super(key: key);

  @override
  _Quiz4State createState() => _Quiz4State();
}

class _Quiz4State extends State<Quiz4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bouncing Balls"),
      ),
      body: MyWidget(),
    );
  }
}
class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {

  double posx = -100;
  double posy = -100;

  void onTapDown(BuildContext context, TapDownDetails details) {
    print('${details.globalPosition}');
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset localOffset = box.globalToLocal(details.globalPosition);
    setState(() {
      posx = localOffset.dx;
      posy = localOffset.dy;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) => onTapDown(context, details),
      child: new Stack(fit: StackFit.expand, children: <Widget>[
        new Container(color: Colors.deepPurpleAccent),
        new Positioned(
          child: CustomPaint(
            painter: Balls(),
          ),
          left: posx,
          top: posy,
        )
      ]),
    );
  }
}


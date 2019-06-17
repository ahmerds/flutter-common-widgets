import 'package:flutter/material.dart';
import 'dart:math';
import 'package:vector_math/vector_math.dart' show radians;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AnimatedButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: RadialMenu(),),
    );
  }
}

class RadialMenu extends StatefulWidget {
  @override
  _RadialMenuState createState() => _RadialMenuState();
}

class _RadialMenuState extends State<RadialMenu> with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: Duration(milliseconds: 900), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return RadialAnimation(controller: controller);
  }
}

class RadialAnimation extends StatelessWidget {
  RadialAnimation({ Key key, this.controller }) :
        animateScale = Tween<double>(begin: 1.5, end: 0.0).animate(
          CurvedAnimation(parent: controller, curve: Curves.ease)
        ),
        animateTranslate = Tween<double>(begin: 0.0, end: 100.0).animate(
          CurvedAnimation(parent: controller, curve: Curves.elasticInOut)
        ),
        animateRotation = Tween<double>(begin: 0.0, end: 360.0).animate(
          CurvedAnimation(parent: controller, curve: Interval(0.0, 0.7, curve: Curves.easeIn))
        ),
        super(key : key);

  final AnimationController controller;
  final Animation<double> animateScale;
  final Animation<double> animateTranslate;
  final Animation<double> animateRotation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, builder) {
        return Transform.rotate(
          angle: radians(animateRotation.value),
          child: Stack(
            children: <Widget>[
              _buildButton(0, color: Colors.red, icon: FontAwesomeIcons.thumbtack),
              _buildButton(45, color: Colors.green, icon: FontAwesomeIcons.sprayCan),
              _buildButton(90, color: Colors.orange, icon: FontAwesomeIcons.fire),
              _buildButton(135, color: Colors.yellow, icon: FontAwesomeIcons.kiwiBird),
              _buildButton(180, color: Colors.black, icon: FontAwesomeIcons.cat),
              _buildButton(225, color: Colors.blueAccent, icon: FontAwesomeIcons.paw),
              _buildButton(270, color: Colors.pink, icon: FontAwesomeIcons.chessKnight),
              _buildButton(315, color: Colors.purple, icon: FontAwesomeIcons.bolt),
              Transform.scale(
                scale: animateScale.value - 1.5,
                child: FloatingActionButton(
                  child: Icon(FontAwesomeIcons.timesCircle),
                  onPressed: () => _close(),
                  backgroundColor: Colors.red,
                  heroTag: "CloseButton",
                ),
              ),
              Transform.scale(
                scale: animateScale.value,
                child: FloatingActionButton(
                  onPressed: () => _open(),
                  child: Icon(FontAwesomeIcons.solidDotCircle),
                  heroTag: "OpenButton",
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _buildButton(double angle, { Color color, IconData icon }) {
    final double rad = radians(angle);
    return Transform(
      transform: Matrix4.identity()..translate(
        (animateTranslate.value) * cos(rad),
          (animateTranslate.value) * sin(rad)
      ),
      child: FloatingActionButton(
        child: Icon(icon),
        backgroundColor: color,
        onPressed: () => print("A button was clicked"),
        heroTag: "Icon${angle.toString()}",
      ),
    );
  }

  _open() {
     controller.forward();
  }

  _close() {
     controller.reverse();
  }
}
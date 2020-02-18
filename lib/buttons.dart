import 'package:flutter/material.dart';
import 'package:polygon_clipper/polygon_border.dart';
import 'package:polygon_clipper/polygon_clipper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'nomination_form.dart';
import 'main.dart';
import 'dart:math';


Widget drawBackgroundPoly(status){
  if(status){
    return Container(
      decoration: ShapeDecoration(
        shape: PolygonBorder(sides: 6, borderRadius: 13.0),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFe8e8e8),
            Colors.white,
          ]
        ),
      ),
    );
  }else{
    return Container(
      color: Color(0xFFF6F6F6),
    );
  }
}

Widget drawBackgroundBox(status){
  if(status){
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFe8e8e8),
            Colors.white,
          ]
        ),
      ),
    );
  }else{
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xFFF6F6F6),
      ),
    );
  }
}


class HexagonButton extends StatefulWidget {
  final String svgFilePath,
  gemName;

  HexagonButton({
    Key key,
    this.svgFilePath,
    this.gemName
  }) : super(key: key);

  @override
  _HexagonButtonState createState() => _HexagonButtonState();
}

class _HexagonButtonState extends State<HexagonButton> {
  bool buttonPressed = false;
  var polyShape = PolygonBorder(sides: 6, borderRadius: 13.0);
  
  @override
  Widget build(BuildContext context) {
    double scaleFactor = min(MediaQuery.of(context).size.width/2.5,MediaQuery.of(context).size.height),
    // double scaleFactor = 160.0,
    sizeDimentn = scaleFactor,
    blurRad = scaleFactor/20,
    moveX = scaleFactor/50,
    moveY = scaleFactor/30;
    return GestureDetector(
      onTapDown: (TapDownDetails details)=> setState(() => buttonPressed = true),
      onTapUp: (TapUpDetails details){
        setState(() {
          buttonPressed = false;
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NominationForm(pageName: widget.gemName),
            )
          );
        });
      },
      onTapCancel: ()=> setState(() => buttonPressed = false),
      child: Container(
        height: sizeDimentn,
        width: sizeDimentn,
        child: Stack(
          children: <Widget>[
            Opacity(
              opacity: buttonPressed?0.0:1.0,
              child: Container(
                decoration: ShapeDecoration(
                  shape: polyShape,
                  shadows: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: Offset(moveX,moveY),
                      blurRadius: blurRad,
                      spreadRadius: 2.0,
                    ),
                  ],
                ),
              ),
            ),
            Opacity(
              opacity: buttonPressed?0.0:1.0,
              child: Container(
                decoration: ShapeDecoration(
                  shape: polyShape,
                  shadows: [
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-moveY*1.0,-moveX*2.5),
                      blurRadius: blurRad,
                      spreadRadius: 2.0,
                    ),
                  ],
                ),
              ),
            ),
            ClipPolygon(
              sides: 6,
              borderRadius: 13.0,
              child: drawBackgroundPoly(buttonPressed),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Opacity(
                    opacity: 0.6,
                    child: SvgPicture.asset(
                      widget.svgFilePath,
                      height: 50.0,
                      width: 70.0,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 12.0),
                    child: Text(
                      widget.gemName,
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RectangularButton extends StatefulWidget {
  final String buttonName;

  RectangularButton({
    Key key,
    this.buttonName,
  }) : super(key: key);
  
  @override
  _RectangularButtonState createState() => _RectangularButtonState();
}

class _RectangularButtonState extends State<RectangularButton> {
  bool buttonPressed = false;
  double moveX = 5,
  moveY = 6,
  blurRad = 10;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details)=> setState(() => buttonPressed = true),
      onTapUp: (TapUpDetails details){
        setState(() {
          buttonPressed = false;
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => NominationForm(widget.gemName),
          //   )
          // );
        });
      },
      onTapCancel: ()=> setState(() => buttonPressed = false),
      child: Container(
        height: 50,
        width: screenWidth-64,
        child: Stack(
          children: <Widget>[
            Opacity(
              opacity: buttonPressed?0.0:1.0,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: Offset(moveX,moveY),
                      blurRadius: blurRad,
                      spreadRadius: 2.0,
                    ),
                  ],
                ),
              ),
            ),
            Opacity(
              opacity: buttonPressed?0.0:1.0,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-moveY*1.0,-moveX*2.5),
                      blurRadius: blurRad,
                      spreadRadius: 2.0,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: drawBackgroundBox(buttonPressed),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  widget.buttonName,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
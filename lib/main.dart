// import 'dart:html';

import 'package:flutter/material.dart';
import 'dart:ui';
import 'buttons.dart';

void main() => runApp(MyApp());

final String rubySvg = "assets/ruby.svg",
crystalSvg = "assets/crystal.svg",
diamondSvg = "assets/diamond.svg",
greenSvg = "assets/green.svg",
saffireSvg = "assets/saffire.svg";

Map nomineeNames = {
  "rubyName": "",
  "crystalName":"",
  "diamondName":"",
  "emeraldName":"",
  "saffirename":""},
nomineeDescription = {
  "RubyDescription": "",
  "CrystalDescription":"",
  "DiamondDescription":"",
  "EmeraldDescription":"",
  "SaffireDescription":""};

double screenWidth,screenHeight;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tally Ratna',
      theme: ThemeData(
        backgroundColor: Color(0xFFF6F6F6),
        scaffoldBackgroundColor: Color(0xFFF6F6F6),
        primarySwatch: Colors.grey,
        // primaryColor: Color(0xFFF6F6F6),
        fontFamily: "Avenir",
        appBarTheme: AppBarTheme(
          color: Color(0xFFF6F6F6),
          textTheme: TextTheme(
            headline6: TextStyle(
              color: Colors.grey[800],
              fontSize: 24.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          elevation: 0,
        ),
      ),
      home: HomePage()
    );
  }
}

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              'Tally Ratna',
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 40.0, bottom: 40),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      HexagonButton(svgFilePath: rubySvg, gemName: "Ruby"),
                      HexagonButton(svgFilePath: crystalSvg, gemName: "Jade"),
                  ]),
                  Center(
                    child: HexagonButton(svgFilePath: diamondSvg, gemName: "Diamond"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      HexagonButton(svgFilePath: greenSvg, gemName: "Emerald"),
                      HexagonButton(svgFilePath: saffireSvg, gemName: "Saffire"),
                  ]),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 80.0),
            child: Align(
              // padding: const EdgeInsets.symmetric(vertical: 80.0),
              alignment: FractionalOffset.bottomCenter,
              child: RectangularButton(buttonName: "Submit Nominations",),
            ),
          ),
        ],
      ),
    );
  }
}
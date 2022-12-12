library daily_weather_app;

import 'package:flutter/material.dart';
import 'dart:convert';

import '../Models/ThemeAttribute.dart';
import '../Models/Utility.dart';
import 'HomePage.dart';


class LaunchPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _LaunchPage();
  }
}

class _LaunchPage extends State<LaunchPage> {
    //Variables
    String _user_email="";
    ThemeAttribute theme_attribute = ThemeAttribute();
    Utility utility = Utility();


    @override
    void initState(){
        
        Future.delayed(const Duration(seconds: 1)).then((value){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => HomePage()));
        });

        super.initState();
    }

    @override
    Widget build(BuildContext context) {
        final double height = MediaQuery.of(context).size.height;
        final double width = MediaQuery.of(context).size.width;

        return SafeArea(
            child: Scaffold( 
                body: Center(
                    child: Container(
                        width: width,
                        height: height,
                        child: Stack(
                            children: <Widget>[
                                Container(
                                    width: width,
                                    height: height,
                                ),
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: const <Widget>[
                                        Center(
                                          child: SizedBox(height: 20.0),
                                        ),
                                        Center(),
                                    ],
                                ),
                            ],
                        )
                      ),
                  ),
              )
          );
    }


    /*[Method]*/

    void checkLoginStatus() async {
        //Variables
        
        Future<int>.delayed(const Duration(milliseconds: 100)).then((value){
            if(true)
            {
                Navigator.pushReplacementNamed(context, '/home');
            }
        });
    }
}
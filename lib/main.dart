import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'Pages/HomePage.dart';

void main(){
    debugPaintSizeEnabled = false;
    debugPaintBaselinesEnabled = false;
    debugPaintLayerBordersEnabled = false;
    debugPaintPointersEnabled = false;
    debugRepaintRainbowEnabled = false;
    debugRepaintTextRainbowEnabled = false;
    debugDisableClipLayers = false;
    debugDisablePhysicalShapeLayers = false;
    debugDisableOpacityLayers = false;
    runApp(DailyWeatherApp());
}

class DailyWeatherApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
      return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primarySwatch: Colors.lightBlue,
                buttonColor: Colors.deepPurple,
            ),
            home: HomePage(),
            routes: {
                //'/': (BuildContext context) => launchPage(),
                //'/launch': (BuildContext context) => launchPage(),
                '/home': (BuildContext context) => HomePage(),
                //'/website': (BuildContext context) => BrowserPage("http://dynamicevolution.technology"),
            },
            onGenerateRoute: (RouteSettings setting){
                final List<String> pathElements = setting.name!.split('/');
                if(pathElements[0] != ''){
                    return null;
                }
                if(pathElements[1] == 'user'){
                    final int index = int.parse(pathElements[2]);

                    return MaterialPageRoute<bool>(
                          builder: (BuildContext context) => HomePage());
                }
                
                return null;
            },
            onUnknownRoute: (RouteSettings settings){
                print('Route not found');
                return MaterialPageRoute(builder: (BuildContext context) => DailyWeatherApp());
            },
        );
    }
}

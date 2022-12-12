import 'package:daily_weather_app/Models/WeatherUpdate.dart';
import 'package:daily_weather_app/Models/WidgetState.dart';
import 'package:daily_weather_app/Widgets/HourlyCardLargeWidget.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import '../Widgets/MainAppBar.dart';
import 'dart:convert';
import 'dart:math';

import '../Models/Constants.dart';
import '../Models/ThemeAttribute.dart';
import '../Models/Utility.dart';
import '../Models/WidgetState.dart';



/*
* @Description:
*
*/
class ForecastPage extends StatefulWidget {
  /*[Attributes]*/
  final WIDGET_STATE stateId;
  final List<WeatherUpdate> widgetDataObject;

  /*
  * @Description: Constructor
  *
  * @param:
  *
  * @return: void
  */
  const ForecastPage({required Key key, this.stateId = WIDGET_STATE.INITIAL_STATE, required this.widgetDataObject}) : super(key: key);

  /*
  * @Description:
  *
  * @param:
  *
  * @return: void
  */
  @override
  State<StatefulWidget> createState() => _ForecastPageState(stateId: this.stateId, widgetDataObject: this.widgetDataObject);
}

/*
* @Description:
*
* @param:
*
* @return: void
*/
class _ForecastPageState extends State<ForecastPage> with WidgetsBindingObserver, TickerProviderStateMixin{
    /*[Attributes]*/
     WIDGET_STATE stateId;
    late List<WeatherUpdate> widgetDataObject;
    WIDGET_STATE _mainDisplayState = WIDGET_STATE.HAS_DATA;
    Widget _view = Container();
    ThemeAttribute _themeAttribute = ThemeAttribute();
    final Utility _utility = Utility();
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    bool _isPageLoading = false;

    /*[Constructors]*/


    /*
    * @Description: Constructor
    *
    * @param:
    *
    * @return: void
    */
    _ForecastPageState({this.stateId = WIDGET_STATE.INITIAL_STATE, required this.widgetDataObject});

    /*[Live Cycle methods]*/

    /*
    * @Description: 
    *
    * @param:
    *
    * @return: void
    */
    @override
    void initState(){
        super.initState();
        WidgetsBinding.instance.addObserver(this);
    }

    @override
    void dispose() {
        super.dispose();
        WidgetsBinding.instance.removeObserver(this);
    }
    

    /*
    * @Description: 
    *
    * @param:
    *
    * @return: void
    */
    @override
    Widget build(BuildContext context) {
        //Variables
        final Size deviceSize = MediaQuery.of(context).size;

        //Set view
        switch(stateId)
        {
            case WIDGET_STATE.IS_LOADING:
            {
                _view = SafeArea(
                    child: Scaffold(
                        key: _scaffoldKey,
                            appBar: MainAppBar(),
                            body: Container(
                                //color: Colors.red,
                            ),
                    )
                );
                break;
            }

            case WIDGET_STATE.HAS_ERROR:
            {
                break;
            }

            case WIDGET_STATE.HAS_DATA:
            {
                _view = SafeArea(
                    child: Scaffold(
                        key: _scaffoldKey,
                        backgroundColor: _themeAttribute.primaryColor,
                            appBar: MainAppBar(
                              backgroundColor: Colors.transparent,
                              appBarMode: AppBarMode.back,
                            ),
                            body: SingleChildScrollView(
                              child: _mainDisplay(),
                            ),
                    )
                );
                break;
            }


            default:
            {
                _view = SafeArea(
                    child: Scaffold(
                        key: _scaffoldKey,
                        backgroundColor: Colors.white,
                            appBar: MainAppBar(),
                            body: _mainDisplay(),
                    )
                );
                break;
            }
        }


        return _view;
    }


    /*[Methods]*/


    /*
    * @Description: 
    *
    * @param:
    *
    * @return: void
    */
    Widget _mainDisplay() {
        //Variables
        final Size deviceSize = MediaQuery.of(context).size;

        

        switch(_mainDisplayState)
        {
            case WIDGET_STATE.IS_LOADING:
            {
                return Container(
                );
                break;
            }

            case WIDGET_STATE.NO_DATA:
            {
                return Container();
                break;
            }

            case WIDGET_STATE.HAS_DATA:
            {
                return Container(
                  width: deviceSize.width,
                  padding: const EdgeInsets.only(left: 0, right: 0, bottom: 20),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(0, 0, 23, 75),
                          Color.fromARGB(255, 12, 69, 160),
                        ],
                        begin: FractionalOffset(0.0, 0.0),
                        end: FractionalOffset(0.0, 1.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 0,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              child: _weatherIcon(widgetDataObject[0], deviceSize.width * 0.4),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Today",
                                    style: _themeAttribute.textStyle_1.apply(
                                      fontSizeDelta: 3
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        Text(widgetDataObject[0].temperature.amount.toString(),
                                          style: _themeAttribute.textStyle_1.apply(
                                            fontWeightDelta: 900,
                                            fontSizeDelta: 64,
                                            fontFamily: 'Iwata Maru Gothic W55',
                                          ),
                                        ),
                                        Text(widgetDataObject[0].temperature.units,
                                          style: _themeAttribute.textStyle_1.apply(
                                            //fontWeightDelta: 500,
                                            fontSizeDelta: 48,
                                            fontFamily: 'Iwata Maru Gothic W55'
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(widgetDataObject[0].condition.name,
                                    style: _themeAttribute.textStyle_1.apply(
                                      fontSizeDelta: 10
                                    ),
                                  ),
                                  Text("Real Feel "+widgetDataObject[0].temperature.feels_like.toString()+widgetDataObject[0].temperature.units,
                                    style: _themeAttribute.textStyle_2.apply(
                                      fontSizeDelta: 0
                                    ),
                                  ),
                                ]
                              ),
                            )
                          ],
                        )
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 40, right: 40),
                        width: deviceSize.width * 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Image.asset(
                                      packagePath+"lib/Assets/Images/rain_drop_500x500.png",
                                      width: 25,
                                      height: 25,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(widget.widgetDataObject[0].precipitation.amount.toString()+widget.widgetDataObject[0].precipitation.units,
                                  style: _themeAttribute.textStyle_2,),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Image.asset(
                                      packagePath+"lib/Assets/Images/wind_500x500.png",
                                      width: 25,
                                      height: 25,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(widget.widgetDataObject[0].wind.amount.toStringAsFixed(1)+widget.widgetDataObject[0].wind.units.toString(),
                                  style: _themeAttribute.textStyle_2,),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Image.asset(
                                      packagePath+"lib/Assets/Images/speed_500x500.png",
                                      width: 25,
                                      height: 25,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(widget.widgetDataObject[0].humidity.amount.toString()+widget.widgetDataObject[0].humidity.units.toString(),
                                  style: _themeAttribute.textStyle_2,),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: deviceSize.height - 305,
                        child: ListView(
                          key: GlobalKey(),
                          children: widgetDataObject.getRange(1, 6).toList().asMap().entries.map((weatherUpdate){
                            return HourlyCardLargeWidget(
                              key: Key("hourly_"+weatherUpdate.value.id.toString()),
                              stateId: WIDGET_STATE.HAS_DATA,
                              widgetDataObject: weatherUpdate.value,
                              active: weatherUpdate.key == 0 ? true : false,
                            );
                          }).toList(),
                        )
                      )
                    ],
                  ),
                );
                break;
            }

            default:
            {
                return Container();
                break;
            }

        }
    }

    /*
    * @Description: 
    *
    * @param:
    *
    * @return: void
    */
    Widget _pageLoader()
    {
        final Size devicSize = MediaQuery.of(context).size;

        if(_isPageLoading)
        {
            return Container(
                height: 3,
                margin: const EdgeInsets.only(bottom: 5),
                child: const LinearProgressIndicator(
                    backgroundColor: Colors.black,
                ),
            );
        }
        else
        {
            return Container(
                height: 3,
                margin: const EdgeInsets.only(bottom: 5)
            );
        }
    }

    /*
    * @Description: 
    *
    * @param:
    *
    * @return: void
    */
    Widget _weatherIcon(WeatherUpdate weatherUpdate, double size) {
        //Variables
        
        switch (weatherUpdate.condition.id) {
          case 1:
            return Image.asset(
              packagePath+"lib/Assets/Images/sun_500x500.png",
              width: size,
              height: size,
            );
            break;

          case 2:
            return Image.asset(
              packagePath+"lib/Assets/Images/partly_cloudy_500x500.png",
              width: size,
              height: size,
            );
            break;

          case 3:
            return Image.asset(
              packagePath+"lib/Assets/Images/cloud_x3_500x500.png",
              width: size,
              height: size,
            );
            break;

          case 4:
            return Image.asset(
              packagePath+"lib/Assets/Images/cloud_x2_rainly_500x500.png",
              width: size,
              height: size,
            );
            break;

          case 5:
            return Image.asset(
              packagePath+"lib/Assets/Images/stormy_500x500.png",
              width: size,
              height: size,
            );
            break;

          default:
            return Image.asset(
              packagePath+"lib/Assets/Images/cloud_x3_500x500.png",
              width: size,
              height: size,
            );
        }
    }
}
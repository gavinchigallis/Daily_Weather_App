import 'package:flutter/material.dart';

class ThemeAttribute{

    //Colors
    final Color _primaryColor = const Color.fromARGB(255, 4, 22, 78); //hex: #01164D
    final Color _secondaryColor = const Color.fromARGB(255, 50, 86, 138);

    //Text Styles
    TextStyle _textStyle_1 = TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.normal
    );

    TextStyle _textStyle_2 = TextStyle(
        color: Color.fromRGBO(174, 197, 246, 1),
        fontSize: 14,
        fontWeight: FontWeight.normal
    );

    ThemeAttribute();

    Color get primaryColor{
        return _primaryColor;
    }

    Color get secondaryColor{
        return _secondaryColor;
    }

    //Standard small black text
    TextStyle get textStyle_1{
        return _textStyle_1;
    }

    //Standard Page header Large text
    TextStyle get textStyle_2{
        return _textStyle_2;
    }
}
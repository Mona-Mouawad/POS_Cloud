import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pos/shared/style/colors.dart';

ThemeData lightTheme=
   ThemeData(
     primarySwatch: Colors.blue,
      backgroundColor:Colors.white,
      //  fontFamily: 'Urd',
        fontFamily: 'Cairo',
        appBarTheme: AppBarTheme(
          color:defultcolor ,
            centerTitle: true,
                  // color: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: defultcolor
          ),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: defultcolor,
           )
        ),
        scaffoldBackgroundColor: Colors.white,
      );



import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:pos/Api/get.dart';
import 'cubit/LoginCubit.dart';
import 'cubit/cubit.dart';
import 'modules/Login.dart';
import 'DataBase/DataBase.dart';
import 'shared/Content.dart';
import 'shared/bloc_observer.dart';
import 'shared/helper/Dio_Helper.dart';
import 'shared/helper/cach_Helper.dart';
import 'shared/location.dart';
import 'Api/Timer.dart';
import 'DataBase/getDB.dart';
import 'modules/layout.dart';
import 'modules/loading.dart';
import 'shared/style/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer=MyBlocObserver();
  Dio_Helper.init();
  await Cach_helper.init();
  await CheckConnection();
  LeName =Cach_helper.GetData(key: 'LeName') ?? null ;
  LE_ID =Cach_helper.GetData(key: 'LeId') ?? null ;
  S_D = Cach_helper.GetData(key: 'S_D') ?? false ;
  serviceEnabled = Cach_helper.GetData(key: 'serviceEnabled') ?? false ;
  UserId = Cach_helper.GetData(key: 'UserId') ?? null ;
  deviceId= Cach_helper.GetData(key: 'deviceId') ?? null;
  Active = Cach_helper.GetData(key: 'Active') ?? 0 ;
  USER_NAME =Cach_helper.GetData(key: 'USER_NAME')?? '';

  await createdatabase();
  await getInf();
  await GetAllData_DB();
 // await GetAllApiTable(LeId: 1, UserId: 1);
  Widget ?widget;


if(deviceId != null)
  {
    if(Active == 1 && S_D)
      {
        await GetFromAPI_Timer(LeId : LE_ID );
        await PostToAPI_Timer ();
      }
  }

  PermissionStatus? _permissionGranted;
  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    Cach_helper.SaveData(key: "serviceEnabled", value: false) ;
    if(!serviceEnabled) {
      do
       {
        serviceEnabled = await location.requestService();
      }
      while (!serviceEnabled);
    }
    if(serviceEnabled)
      Cach_helper.SaveData(key: "serviceEnabled", value: true) ;
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      do
      {
        _permissionGranted = await location.hasPermission();
        _permissionGranted = await location.requestPermission();
      }
      while (_permissionGranted != PermissionStatus.granted);
    }
  }

  widget= loginScreen();

  if(USER_NAME != null && UserId != null  && Active == 0)
    {
      widget= Loading();
    }

  else if (USER_NAME != null && UserId != null && Active == 1)
  {
    widget= LayoutScreen();
  }

  runApp(MyApp(startwidget: widget,));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Widget? startwidget;
  MyApp({this.startwidget});
  @override
  Widget build(BuildContext context) {
    return
      MultiBlocProvider(
          providers: [
            BlocProvider(create:(BuildContext context)=>posCubit()),
    BlocProvider(
    create: (BuildContext context)=>Logincubit())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        themeMode: ThemeMode.light,
    //   home:startwidget,
   //      home:loginScreen(),
         home: LayoutScreen()
      )
        );
  }
}




import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/cubit/cubit.dart';
import 'package:pos/cubit/states.dart';
import 'package:pos/shared/component.dart';
import 'package:pos/shared/style/colors.dart';
import '../Api/get.dart';
import '../shared/Content.dart';
import 'layout.dart';

class Loading extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Loading();
}

class _Loading extends State<Loading> {

  Widget build(BuildContext context) {
    // TODO: implement build
    refersh() {
      if (Active ==1 ) {
        Future.delayed(const Duration(milliseconds: 20), () async {
          await getdevicedata(deviceId: deviceId!,UserId: UserId!).then((value)
               => NavigatorAndFinish(context, LayoutScreen())
          ); });}
      Future.delayed(const Duration(seconds: 12), () async {
        await getdevicedata(deviceId: deviceId!,UserId: UserId!).then((value) {
          setState(() {
            if (Active ==1 ) {
              NavigatorAndFinish(context, LayoutScreen());
              //   emit(SuccessgeActive1State());
            } else {
              refersh();
            }
          });

        });
      });
    }

    return BlocConsumer<posCubit, posStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = posCubit.get(context);
        //  UserSec_Post(context);
          refersh ();
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: Text(
                    'فى انتظار الموافقه',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: defultblack,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
         // if (device == null)  Center(child:CircularProgressIndicator() ),
         //
         // if(device != null)
              //  BuildCondition(
              //       condition: Active == 0, //cubit.active == 0 ,
              //       builder: (context) =>
                        CircularProgressIndicator(),
                    // fallback: (context) =>
                    //      defultButton(text: 'تم الموافقه(دخول)'.toUpperCase(),
                    //        width: MediaQuery.of(context).size.width*.8,
                    //        ontap:()=> NavigatorAndFinish(context, LayoutScreen()),
                 //         )),
              ],
            ),
          );
        });
  }
}







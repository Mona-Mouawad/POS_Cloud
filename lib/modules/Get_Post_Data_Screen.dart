import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/cubit/cubit.dart';
import 'package:pos/cubit/states.dart';
import 'package:pos/modules/layout.dart';
import 'package:pos/shared/component.dart';
import 'package:pos/shared/style/colors.dart';
import '../Api/get.dart';
import '../shared/Content.dart';

class Get_Post_Data_Screen extends StatefulWidget {
  @override
  State<Get_Post_Data_Screen> createState() => _Get_Post_Data_ScreenState();
}

class _Get_Post_Data_ScreenState extends State<Get_Post_Data_Screen> {
  @override
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<posCubit, posStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = posCubit.get(context);
        return Scaffold(
          // appBar: AppBar(
          //   backgroundColor: Colors.white,
          //   leading: IconButton(
          //       onPressed: () {
          //         NavigatorAndFinish(context, LayoutScreen());
          //       },
          //       icon: Icon(
          //         Icons.arrow_back_ios,
          //         color: defultcolor,
          //       )),
          // ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            NavigatorAndFinish(context, LayoutScreen());
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: defultcolor,
                          )),
                      //  Spacer(),
                      Expanded(
                        child: Text(
                          //تصدير و استراد
                          'تصدير و استراد البيانات',
                          maxLines: 2, textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              height: 1.1,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      //  Spacer(),
                    ],
                  ),
                  Spacer(flex: 1),
                  Center(
                    child: Image(
                      image: AssetImage('images/تخزين و استرجاع البيانات.jpg'),
                      height: 120,
                    ),
                  ),
                  Spacer(flex: 1),
                  defultButton(
                      text: 'تصدير البيانات',
                      ontap: () async {
                        Cache.play('m.mp3', mode: PlayerMode.LOW_LATENCY);
                        // final isConnected =
                        //     await InternetConnectionChecker().connectionStatus;
                    await  CheckConnection();
                        if (ConnectionStatus) {
                          await getdevicedata(
                              deviceId: deviceId!, UserId: UserId!);
                          Future.delayed(
                            Duration(
                              seconds: 1,
                            ),
                            () => cubit.PostAllData(context),
                          );
                        } else {
                          openmessageNullNetwork(context);
                        }
                      }),
                  if (state is loadingPostDataState)
                    LinearProgressIndicator(
                      minHeight: 2,
                    ),
                  SizedBox(
                    height: 30,
                  ),
                  defultButton(
                      text: 'استيراد البيانات',
                      ontap: () async {
                        Cache.play('m.mp3', mode: PlayerMode.LOW_LATENCY);
                        // final isConnected =
                        //     await InternetConnectionChecker().connectionStatus;
                        // if (isConnected == InternetConnectionStatus.connected) {
                        await  CheckConnection();
                        if (ConnectionStatus) {
                          await getdevicedata(
                              deviceId: deviceId!, UserId: UserId!);
                          Future.delayed(
                            Duration(
                              seconds: 1,
                            ),
                            () => cubit.GetAllData(context),
                          );
                        } else {
                          openmessageNullNetwork(context);
                        }
                      }),
                  if (state is loadingPostDataState)
                    LinearProgressIndicator(
                      minHeight: 2,
                    ),
                  Spacer(flex: 4),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Future openmessageNullNetwork(context) => showDialog(
    context: context,
    builder: (context) => AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Text(
            'تاكد من انك متصل بالشبكة',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.redAccent),
          ),
        ));

Future openmessageSuccessGet(context) => showDialog(
    context: context,
    builder: (context) => AlertDialog(
          content: Text(
            'تم استراد البيانات بنجاح',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ));

Future openmessageSuccessPost(context) => showDialog(
    context: context,
    builder: (context) => AlertDialog(
          content: Text(
            'تم تصدير البيانات بنجاح',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ));

Future openmessageActive_0(context) => showDialog(
    context: context,
    builder: (context) => AlertDialog(
          content: Text(
            'لا يمكنك تصدير او استراد البيانات',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.redAccent),
          ),
        ));

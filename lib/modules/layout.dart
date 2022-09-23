import 'dart:io';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/cubit/cubit.dart';
import 'package:pos/cubit/states.dart';
import 'package:pos/modules/Customer&Stock.dart';
import 'package:pos/modules/Settings.dart';
import 'package:pos/modules/Stock.dart';
import 'package:pos/modules/Treasury.dart';
import 'package:pos/modules/Get_Post_Data_Screen.dart';
import 'package:pos/modules/clien.dart';
import 'package:pos/modules/reports.dart';
import 'package:pos/shared/component.dart';
import 'package:pos/shared/print.dart';
import 'package:pos/shared/style/colors.dart';
import '../DataBase/getDB.dart';
import '../shared/Content.dart';

int numberNotification = 0;
//int numbermessage = 0;
BluetoothDevice ? deviceConn ;
String ? _devicesMsg;
List<BluetoothDevice> _devices = [];
bool _connected = false;
bool _pressed = false;

//BluetoothManager bluetoothManager = BluetoothManager.instance;
//PrinterBluetoothManager bluetoothManager = PrinterBluetoothManager();
BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({Key? key}) : super(key: key);
  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {

  void initState() {
    if (Platform.isAndroid) {
      bluetooth.onStateChanged().listen((val) {
        print('state = $val');
        if (!mounted) return;
        if (val == 12) {
          print('on');
          initPrinter();
        } else if (val == 10) {
          print('off');
          setState(() => _devicesMsg = 'Bluetooth Disconnect!');
        }
      });
    } else {
      initPrinter();
    }
    super.initState();
   // initPrinter();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<posCubit, posStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var Cubit = posCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.grey[300],
          appBar: AppBar(
            //  titleSpacing:40,
       //     leading: Icon(Icons.swap_vertical_circle_rounded, size: 28),
            title: Text('مرحبا: ${USER_NAME!}',textDirection: TextDirection.rtl,
              style: TextStyle(fontSize: 16, color: Colors.white),),
            actions: [
              // SizedBox(width: 20,),
              // Stack(
              //   alignment: Alignment.centerRight,
              //   children: [
              //     Container(
              //       width: 35,
              //       child: Center(
              //         child: IconButton(
              //           onPressed: () async {},
              //           icon: Icon(Icons.message, color: Colors.white,),),
              //       ),
              //     ),
              //     Container(
              //       width: 12,
              //       decoration: BoxDecoration(
              //           shape: BoxShape.circle, color: defultcolor),
              //       child: Center(child: Text('$numbermessage',
              //         style: TextStyle(color: Colors.white, fontSize: 10),)),
              //     )
              //   ],
              // ),
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  Container(
                    width: 35,
                    child: Center(
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.notifications, color: Colors.white,),),
                    ),
                  ),
                  Container(
                    width: 12,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: defultcolor),
                    child: Center(child: Text('$numberNotification',
                      style: TextStyle(color: Colors.white, fontSize: 10),)),
                  )
                ],
              ),
              SizedBox(width: 20,),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    textDirection: TextDirection.rtl,
                    children: [
                      item(text: 'فاتورة بيع', function: () {
                        Cubit.valStock = '';
                        Cust_Model = null;
                        NavigatorTo(context, Customer_Stock());
                      }, image: 'images/فاتورة بيع.png'),
                      SizedBox(width: 8,),
                      item(text: 'المخزن', function: () {
                        NavigatorTo(context, Stock());
                      }, image: 'images/المخزن.png'),
                     //  SizedBox(width: 8,),
                      // item(text: 'تسليم فاتورة/أمر بيع', function: (){
                      //   NavigatorTo(context, SellOrderDelivery());
                      // }, image: 'images/تسليم.jpg'),
                      // SizedBox(width: 8,),
                      // item(text: 'أمر بيع', function: () {
                       //  Cubit.valStock = '';
                      //   Cust_Model = null;
                      //   NavigatorTo(context, SO_Customer_Stock());
                      // }, image: 'images/أمر_بيع.jpg'),

                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    textDirection: TextDirection.rtl,
                    children: [
                      item(text: 'العملاء', function: () {
                        NavigatorTo(context, clienScreen());
                      }, image: 'images/العملاء.png'),

                      SizedBox(width: 8,),
                      item(text: 'الخزينه', function: () {
                      Cubit. ChageRadioTreasury(2);
                      Cubit.valBanks_Treasury = '' ;
                      Cubit.valPAYMENT_METHOD = '' ;
                        NavigatorTo(context, Treasury());
                      }, image: 'images/خزنه2.jpg'),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    textDirection: TextDirection.rtl,
                    children: [
                      item(text: 'الاستعلامات و التقارير', function: () {
                        //reportsScreen
                        NavigatorTo(context, reportsScreen());
                      }, image: 'images/الاستعلامات.png'),
                      SizedBox(width: 8,),
                      item(text: 'تصدير و استيراد البيانات', function: (){
                        NavigatorTo(context, Get_Post_Data_Screen());
                      }, image: 'images/تخزين و استرجاع البيانات.jpg'),

                      SizedBox(width: 8,),
                      item(text: 'الاعدادات', function: () {
                        NavigatorTo(context, Settings());
                      }, image: 'images/الاعدادات.jpg'),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: double.infinity,
                    height: 225,
                    //color: Colors.white.withOpacity(.6),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'اعدادات الطابعه',
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            textDirection: TextDirection.rtl,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Spacer(),
                              Text(
                                '80mm',
                                maxLines: 2,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                              Radio(
                                  value: 1,
                                  groupValue: Cubit.RPrint,
                                  onChanged: (v) {
                                    Cubit.ChageRadioPrint(v);
                                  }),
                              Spacer(),
                              Text(
                                '58mm',
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                              Radio(
                                  value: 2,
                                  groupValue: Cubit.RPrint,
                                  onChanged: (v) {
                                    Cubit.ChageRadioPrint(v);
                                  }),
                              Spacer(),
                            ],
                          ),
                          Container(height: 64, width: MediaQuery
                              .of(context)
                              .size
                              .width * .8,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.lightBlue,
                                    width: 1,
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(7)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              textDirection: TextDirection.rtl,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: Container(
                                      height: 40,
                                      alignment: Alignment.centerRight,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius: BorderRadius.circular(
                                              7)),
                                      clipBehavior: Clip.antiAlias,
                                      child: Text(
                                        '  قم باختيار  جهاز بلوتوث',
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                            color: Colors.grey[700],
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10),
                                      )),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      gradient: LinearGradient(
                                          colors: buttonColor)),
                                  clipBehavior: Clip.antiAlias,
                                  child: MaterialButton(
                                      child: Text(
                                        'اختر',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                      onPressed: () async {
                                        openBlutooth(context);
                                      }),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  height: 60,
                                  width: 65,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      gradient: LinearGradient(
                                          colors: buttonColor)),
                                  clipBehavior: Clip.antiAlias,
                                  child: Center(
                                    child: Text(
                                      'بلوتوث',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                  ),
                                ),

                              ],
                            ),),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            textDirection: TextDirection.rtl,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              defultButton(text: 'قطع الاتصال', ontap: () {
                                bluetooth.disconnect();
                              },
                                  width: (MediaQuery
                                      .of(context)
                                      .size
                                      .width / 2) - 40, height: 60),
                              SizedBox(
                                width: 15,
                              ),
                              defultButton(text: 'اتصال', ontap: () {
                                //deviceConn
                                if(deviceConn != null)   bluetooth.connect(deviceConn!);
                              },
                                  width: (MediaQuery
                                      .of(context)
                                      .size
                                      .width / 2) - 40, height: 60),
                            ],
                          ),
                        ],
                      ),
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8,),
                  Text(
                    'جميع الحقوق محفوظه لشركة Software4eg',
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }


  Widget item({required text, required function, required image}) =>
      Expanded(
        child: InkWell(
          onTap: function,
          child: Container(
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),),
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: Image(image: AssetImage(image)),
                  )),
                  SizedBox(height: 5,),
                  Center(child: Text(text, textAlign: TextAlign.center,
                    style: TextStyle(color: defultcolor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),)),
                  SizedBox(height: 5,),
                ],
              ),
            ),
          ),
        ),
      );


  Future openBlutooth(context) =>
      showDialog(
          context: context,
          builder: (context) {
            bool searchTap = false;
            return AlertDialog(
              // alignment: Alignment.centerRight,
              contentPadding: EdgeInsets.all(10),
              content:StatefulBuilder(
                builder: (context,setState) =>  Container(
                //  height: MediaQuery.of(context).size.height * .3,
                width: MediaQuery
                    .of(context)
                    .size
                    .width * .6,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(alignment: Alignment.centerLeft,
                        child: Text('BLE',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(color: defultcolor,
                              fontWeight: FontWeight.w500,
                              fontSize: 12),),
                      ),
                      Container(alignment: Alignment.centerRight,
                        child: Text('اختيار طابعه', textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(color: defultcolor,
                              fontWeight: FontWeight.w500,
                              fontSize: 12),),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(width: MediaQuery
                            .of(context)
                            .size
                            .width * .8,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.lightBlue,
                                  width: 1,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(7)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              textDirection: TextDirection.rtl,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'No can matched to use',
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(color: defultcolor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,height: 1),
                                ),
                                Text(
                                  'blutooth',
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(color: defultcolor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,height: 1),
                                ),
                              ],
                            ),
                          ),),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        height: 50,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * .6,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.lightBlue),
                        clipBehavior: Clip.antiAlias,
                        child: MaterialButton(
                            child: Text(
                              'ابحث',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                            onPressed: () async {
                              setState(() {
                                searchTap = true ;
                              });
                            }),
                      ),
                      SizedBox(height: 10,),
                      if(searchTap)
                         Column(
                            children: [
                              Container(alignment: Alignment.centerRight,
                                child: Text(
                                  'الاجهزة المتاحه', textAlign: TextAlign.center,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(color: defultcolor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12),),
                              ),
                              Container(decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.lightBlue,
                                      width: 1,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(7)),
                                child: BuildCondition(
                                  condition: _devices.isNotEmpty ,
                                  builder: (context)=> Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Container(
                                      height: (40 * (_devices.length)) as double ,
                                      child: ListView.builder(
                                        itemCount: _devices.length,
                                        itemBuilder: (c, i) {
                                          return ListTile(
                                            leading: Icon(Icons.print),
                                            title: Text(_devices[i].name!),
                                            subtitle: Text(_devices[i].address!),
                                            onTap: () {
                                              deviceConn = _devices[i] ;
                                              bluetooth.connect(_devices[i]);
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  fallback: (context)=>Center(child: Text(_devicesMsg ?? '',style: TextStyle(fontSize: 12),))
                                ),
                              ),
                            ],
                          ),
                    ],
                  ),
                ) ),
              ),
            );
          });


  Future<void> initPrinter() async {
    // bluetoothManager.startScan(Duration(seconds: 2));
    // bluetoothManager.scanResults.listen((val) {
    //   if (!mounted) return;
    //   setState(() => _devices = val);
    //   if (_devices.isEmpty) setState(() => _devicesMsg = 'No Devices');
    // });
    List<BluetoothDevice> devices = [];
    _devices= await bluetooth.getBondedDevices();
    bluetooth.getBondedDevices().then((val) {
      if (!mounted) return;
      setState(() => _devices = val);
      if (_devices.isEmpty) setState(() => _devicesMsg = 'No Devices');
    });
    // bluetooth.onStateChanged().listen((state) {
    //   switch (state) {
    //     case BlueThermalPrinter.CONNECTED:
    //       setState(() {
    //         _connected = true;
    //         _pressed = false;
    //       });
    //       break;
    //     case BlueThermalPrinter.DISCONNECTED:
    //       setState(() {
    //         _connected = false;
    //         _pressed = false;
    //       });
    //       break;
    //     default:
    //       print(state);
    //       break;
    //   }
    // });

    // if (!mounted) return;
    // setState(() {
    //   _devices = devices;
    //   if (_devices.isEmpty) setState(() => _devicesMsg = 'No Devices');
    // });

  }



}
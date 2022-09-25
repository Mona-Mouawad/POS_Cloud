import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/cubit/cubit.dart';
import 'package:pos/cubit/states.dart';
import 'package:pos/shared/component.dart';

import '../DataBase/INSERTS.dart';

class SellOrderDelivery extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SellOrderDelivery();
}

class _SellOrderDelivery extends State<SellOrderDelivery> {
  TextEditingController searchcontroller = TextEditingController();
  TextEditingController Stockcontroller = TextEditingController();
  Color? colors;
  bool? cond = true;

  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocConsumer<posCubit, posStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = posCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: AppBar(
              title: Text(
                "تسليم أمر بيع",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                clipBehavior: Clip.antiAlias,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        '${DateTime.now().day} / ${DateTime.now().month} / ${DateTime.now().year}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Image(
                        image: AssetImage('images/تسليم.jpg'),
                        height: 80,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        textDirection: TextDirection.rtl,
                        children: [
                          Container(
                              width:
                                  (MediaQuery.of(context).size.width / 2) - 130,
                              child: Text(
                                'فاتورة',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              )),
                          Radio(
                              value: 1,
                              groupValue: cubit.RSellOrderDelivery,
                              onChanged: (v) {
                                cubit.ChageRadioSellOrderDelivery(v);
                              }),
                          Container(
                            width: (MediaQuery.of(context).size.width / 2) - 130,
                            child: Text(
                              'أمر بيع',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                          ),
                          Radio(
                              value: 2,
                              groupValue: cubit.RSellOrderDelivery,
                              onChanged: (v) {
                                cubit.ChageRadioSellOrderDelivery(v);
                              }),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          if(dataS != '')
                           Expanded(
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.grey[200],
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: Center(child: Text('${dataS}')),
                            ),
                          ),
                          MaterialButton(
                              onPressed: () => Scan(),
                              child: Image(
                                image: AssetImage('images/barcode.jpg'),
                                height: 48,
                                width: 60,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      defultButton(
                          text: 'تسليم',
                          width: MediaQuery.of(context).size.width * 0.55,
                          ontap: () async {
                            if (dataS != '') {
                              await insertSellOrderDelivery(
                                  DocType: cubit.RSellOrderDelivery ,
                                  Barcode: dataS,
                                  DocDate: DateTime.now().toString());
                              if (insertSellDelivery) {
                                dataS = '';
                                openmessageSuccess(context);
                              }
                            } else {
                              openmessageNull(context);
                            }
                          }),
                      SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Future openmessageNull(context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: Text(
              'لم يتم التسليم , من فضلك استخدم ال QR',
              textAlign: TextAlign.center,textDirection: TextDirection.rtl,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.redAccent),
            ),
          ));

  Future openmessageSuccess(context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: Text(
              'تم التسليم ',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ));

  String dataS = "";

  Scan() async {
    var cubit = posCubit.get(context);
    await FlutterBarcodeScanner.scanBarcode(
            '#343168', 'cancel', true, ScanMode.BARCODE)
        .then((value) => setState(() {
              dataS = value;
              print(dataS);
            }));
  }

  String dataQr = "";

  ScanQr() async {
    var cubit = posCubit.get(context);
    await FlutterBarcodeScanner.scanBarcode(
            '#343168', 'cancel', true, ScanMode.QR)
        .then((value) => setState(() {
              dataS = value;
              cubit.Search_ItemsInStock(
                  Name: dataS, StockName: cubit.valStock_Details);
              print(dataS);
            }));
  }

  Future openFollowSCAN() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            backgroundColor: Colors.black45,
            content: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  defultButton(
                      text: 'استخدم باركود',
                      width: MediaQuery.of(context).size.width * 0.55,
                      ontap: () async {
                        await Scan();
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  defultButton(
                      text: 'استخدم QR',
                      width: MediaQuery.of(context).size.width * 0.55,
                      ontap: () async {
                        await ScanQr();
                      }),
                ],
              ),
            ),
          ));
}

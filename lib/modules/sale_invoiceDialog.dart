import 'dart:io';
import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pos/DataBase/getDB.dart';
import 'package:pos/models/InvoiceItemModel.dart';
import 'package:pos/modules/Buyingrecipt.dart';
import 'package:pos/shared/component.dart';
import 'package:pos/shared/style/colors.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:pos/cubit/cubit.dart';
import '../shared/Content.dart';
import '../shared/print.dart';

final _ScreenshotController = ScreenshotController();
Uint8List? byte;

Future sale_invoice({context, List<InvoiceItemModel>? ITEMmodel}) => showDialog(
    context: context,
    builder: (context) {
      var cubit = posCubit.get(context);
      // double length = double.parse(ITEMmodel!.length.toString()) ;
      return StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          backgroundColor: Colors.white,
          content: Container(
            color: Colors.white,
            //height: MediaQuery.of(context).size.height*.9,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black,
                                  width: 1,
                                  style: BorderStyle.solid)),
                          child: IconButton(
                            icon: Icon(Icons.print),
                            onPressed: () async {
                              final bytes =
                                  await _ScreenshotController.capture();
                              image(byte: bytes, context: context);
                              // saveImage(bytes!);
                              //                             setState(()  {
                              //                               byte = bytes ;
                              //                               // Image image = decodeImageFromList(byte!) as Image;
                              // });
                              //                             await _ScreenshotController.capture(
                              //                                     delay: const Duration(milliseconds: 10))
                              //                                 .then((image) async {
                              //                               Print(image);
                              //                             });
                            },
                          )),
                      Spacer(),
                      Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black,
                                  width: 1,
                                  style: BorderStyle.solid)),
                          child: IconButton(
                            icon: Icon(Icons.share),
                            onPressed: () async {
                              await ScreenShot_Share();
                              NavigatorTo(context, Buyingrecipt());
                            },
                          )),
                      Spacer(),
                      Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black,
                                  width: 1,
                                  style: BorderStyle.solid)),
                          child: IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () async {
                              Cache.play('m.mp3', mode: PlayerMode.LOW_LATENCY);
                              NavigatorAndFinish(context, Buyingrecipt());
                           //   await getStock_Details(database);
                            },
                          )),
                    ],
                  ),
                  Screenshot(
                    controller: _ScreenshotController,
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black,
                                        width: 1,
                                        style: BorderStyle.solid)),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 3),
                                  child: Row(
                                    textDirection: TextDirection.rtl,
                                    children: [
                                      SizedBox(
                                        width: 7,
                                      ),
                                      Text(
                                        '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                      Spacer(),
                                      Text(
                                        '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}'
                                            .toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                      SizedBox(
                                        width: 7,
                                      ),
                                    ],
                                  ),
                                )),
                            // Image(
                            //   image: AssetImage('images/logo2.jpg'),
                            //   height: 50,
                            // ),
                            Text(
                              '${LeName}'.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              textDirection: TextDirection.rtl,
                              children: [
                                Container(
                                  width: 70,
                                  child: Text(
                                    'فاتورة رقم',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: defultcolor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: borderContainer(
                                        text: '${INVOICE_model!.InvoiceNo}')),
                              ],
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              textDirection: TextDirection.rtl,
                              children: [
                                Container(
                                  width: 70,
                                  child: Text(
                                    'العميل',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: defultcolor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: borderContainer(
                                        text: INVOICE_model!.Name.toString())),
                              ],
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            // Row(
                            //   crossAxisAlignment: CrossAxisAlignment.center,
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   textDirection: TextDirection.rtl,
                            //   children: [
                            //     Container(
                            //       width: 70,
                            //       child: Text(
                            //         'الكاشير',
                            //         textAlign: TextAlign.center,
                            //         style: TextStyle(
                            //             color: defultcolor,
                            //             fontWeight: FontWeight.bold,
                            //             fontSize: 12),
                            //       ),
                            //     ),
                            //     SizedBox(
                            //       width: 10,
                            //     ),
                            //     Expanded(child: borderContainer(text: 'لا يوجد')),
                            //   ],
                            // ),
                            // SizedBox(
                            //   height: 7,
                            // ),
                            Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black,
                                        width: 1,
                                        style: BorderStyle.solid)),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 3),
                                  child: Row(
                                    textDirection: TextDirection.rtl,
                                    children: [
                                      SizedBox(
                                        width: 7,
                                      ),
                                      Container(width: MediaQuery.of(context).size.width * .25,
                                        child: Text(
                                          'اسم المنتج'.toString(),
                                          textAlign: TextAlign.start,textDirection: TextDirection.rtl,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10),
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        'السعر'.toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10),
                                      ),
                                      Spacer(),
                                      Text(
                                        'الكميه'.toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10),
                                      ),
                                      Spacer(),
                                      Text(
                                        'الاجمالى'.toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10),
                                      ),
                                      SizedBox(
                                        width: 7,
                                      ),
                                    ],
                                  ),
                                )),
                            SizedBox(
                              height: 4,
                            ),
                            if (ITEMmodel!.length > 0)
                              Container(
                                height: 47 *
                                    double.parse(ITEMmodel.length.toString()),
                                width: MediaQuery.of(context).size.width * .75,
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return recipts(
                                        context: context,
                                        cubit: cubit,
                                        ITEMmodel: ITEMmodel[index]);
                                  },
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    height: 1,
                                  ),
                                  itemCount: ITEMmodel.length,
                                ),
                              ),
                            //  SizedBox(height: 1),
                            Container(
                              color: Colors.black,
                              height: 1,
                              width: double.infinity,
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              textDirection: TextDirection.rtl,
                              children: [
                                Container(
                                  width: 70,
                                  child: Text(
                                    'الاجمالى',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: defultcolor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: borderContainer(
                                        text: '${INVOICE_model!.PRICE}')),
                              ],
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              textDirection: TextDirection.rtl,
                              children: [
                                Container(
                                  width: 70,
                                  child: Text(
                                    'قيمة الخصم',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: defultcolor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: borderContainer(
                                        text: '${INVOICE_model!.Discount}')),
                              ],
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              textDirection: TextDirection.rtl,
                              children: [
                                Container(
                                  width: 70,
                                  child: Text(
                                    'بعد الخصم',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: defultcolor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: borderContainer(
                                        text: '${INVOICE_model!.VALUE}')),
                              ],
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              textDirection: TextDirection.rtl,
                              children: [
                                Container(
                                  width: 70,
                                  child: Text(
                                    'نوع الدفع',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: defultcolor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                if (cubit.Rval == 1)
                                  Expanded(child: borderContainer(text: 'كاش')),
                                if (cubit.Rval == 2)
                                  Expanded(
                                      child: borderContainer(text: 'دفع اجل')),
                              ],
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              textDirection: TextDirection.rtl,
                              children: [
                                Container(
                                  width: 70,
                                  child: Text(
                                    'مدفوع',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: defultcolor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                // if((paid.text !='' && paid.text!=null) && cubit.Rval == 2)
                                //   Expanded(child: borderContainer(text: paid.text)),
                                // if((paid.text =='' || paid.text == null) && cubit.Rval == 2 )
                                //   Expanded(child: borderContainer(text: 0.0)),
                                // if((paid.text =='' || paid.text == null) && cubit.Rval == 1 )
                                //   Expanded(child: borderContainer(text: cubit.AfterOffer.toString())),

                                Expanded(
                                    child: borderContainer(
                                        text: INVOICE_model!.Paid)),
                              ],
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              textDirection: TextDirection.rtl,
                              children: [
                                Container(
                                  width: 70,
                                  child: Text(
                                    'باقي',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: defultcolor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: borderContainer(
                                        text:
                                            INVOICE_model!.Remaind.toString())),
                              ],
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            if (Cust_Model!.AmountPaid != null)
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                textDirection: TextDirection.rtl,
                                children: [
                                  Container(
                                    width: 70,
                                    child: Text(
                                      'مديونيه سابقه',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: defultcolor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: borderContainer(
                                          text: Cust_Model!.AmountPaid)),
                                ],
                              ),
                            SizedBox(
                              height: 7,
                            ),
                            borderContainer(
                                text:
                                    'برجاء الاحتفاظ بالفاتورة لاسترجاع المشتريات'),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              'لخدمات البيع الذكية Software4eg',
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  color: defultcolor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // if(byte != null)
                  //   Image.memory(byte!)
                ],
              ),
            ),
          ),
        ),
      );
    });

Widget recipts({colors, context, cubit, InvoiceItemModel? ITEMmodel}) => Column(
      children: [
        Container(
          height: 43,
         // width: MediaQuery.of(context).size.width * .6,
          color: colors,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            textDirection: TextDirection.rtl,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .24,
                child: Text(
                  ITEMmodel!.ITEM_NAME!.toString(),
                  maxLines: 10,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 10),
                ),
              ),
              Spacer(),
              SizedBox(
                width: 5,
              ),
              Text(
                "${ITEMmodel.SALES_PRICE1 ?? '0'}",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 10),
              ),
              Spacer(),
              SizedBox(
                width: 5,
              ),
              // Text(
              //   "${ITEMmodel.UomQuantity ?? '0'}X${ITEMmodel.UomName}",
              //   textAlign: TextAlign.center,
              //   style: TextStyle(
              //       color: Colors.black,
              //       fontWeight: FontWeight.bold,
              //       fontSize: 10),
              // ),
             Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${ITEMmodel.UomQuantity ?? '0'} x  ${ITEMmodel.StandConvFactor}",textAlign: TextAlign.center,//textDirection: TextDirection.rtl,
                    // '1000',
                    maxLines: 2,
                    style: TextStyle(
                        color: defultblack,
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                  ),
                  // Text(
                  //   "${ITEMmodel.UomName}",textAlign: TextAlign.center,
                  //   style: TextStyle(
                  //       color: defultblack,
                  //       fontSize: 10,
                  //       ),
                  // ),
                ],
              ),
              Spacer(),
              SizedBox(
                width: 7,
              ),
              Text(
                '${ITEMmodel.TOTAL ?? '0'}'.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 10),
              ),
              SizedBox(
                width: 7,
              ),
            ],
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(1.0),
            child: Container(
              color: Colors.black,
              height: .5,
              width: double.infinity,
            )),
      ],
    );

ScreenShot_Share() async {
  await _ScreenshotController.capture(delay: const Duration(milliseconds: 10))
      .then((image) async {
    if (image != null) {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = await File('${directory.path}/image.png').create();
      await imagePath.writeAsBytes(image);

      /// Share Plugin
      await Share.shareFiles([imagePath.path]);
    }
  });
}

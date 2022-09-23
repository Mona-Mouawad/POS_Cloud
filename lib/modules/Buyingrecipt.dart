import 'package:audioplayers/audioplayers.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/cubit/cubit.dart';
import 'package:pos/cubit/states.dart';
import 'package:pos/models/InvoiceItemModel.dart';
import 'package:pos/modules/SearchITEMS_Dialog.dart';
import 'package:pos/modules/layout.dart';
import 'package:pos/shared/Content.dart';
import 'package:pos/shared/component.dart';
import 'package:pos/shared/style/colors.dart';
import 'categories.dart';
import 'editProtectDialog.dart';
import 'openFollowItemDialog.dart';

class Buyingrecipt extends StatefulWidget {

  Buyingrecipt();

  @override
  State<StatefulWidget> createState() => _Buyingrecipt();
}

class _Buyingrecipt extends State<Buyingrecipt> {

  _Buyingrecipt();

  Color? colors;
  bool? cond = true;
  TextEditingController offer = TextEditingController();

  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocConsumer<posCubit, posStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = posCubit.get(context);
          print('            STOCK_ID          ' + cubit.V_STOCKID.toString());

          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    NavigatorAndFinish(context, LayoutScreen());
                  }),
              title: Text(
                "فاتورة بيع",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            body: Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () {
                        openSearchItem(
                            context: context,
                            cubit: cubit,
                            StockID: cubit.V_STOCKID);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width - 130,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                              Spacer(),
                              Text(
                                'ابحث عن المنتج ',
                                maxLines: 2,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
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
                  height: 12,
                ),
                Container(
                  color:bar ,
                  height: 35,
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      // SizedBox(
                      //   width: 10,
                      // ),
                      // Text(
                      //   'صوره المنتج',
                      //   style: TextStyle(
                      //       color: Colors.white,
                      //       fontSize: 10,
                      //       fontWeight: FontWeight.bold),
                      // ),
                      // SizedBox(width: 15,),
                      Container(
                        width: MediaQuery.of(context).size.width *.4,
                        child: Center(
                          child: Text(
                            'المنتج',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Spacer(),
                      Text(
                        'السعر',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Text(
                        'الكميه',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Text(
                        'الاجمالي',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: BuildCondition(
                    condition: cubit.ItemsList.length > 0,
                    builder: (context) => ListView.separated(
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        if (index % 2 != 0) {
                          colors = Colors.blue[100];
                        } else {
                          colors = Colors.grey[100];
                        }
                        return Items(
                            colors: colors,
                            context: context,
                            cubit: cubit,
                            ITEMmodel: cubit.ItemsList[index]);
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        height: 3,
                      ),
                      itemCount: cubit.ItemsList.length,
                    ),
                    fallback: (context) => Container(),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context)
                      .size
                      .width, color: Colors.grey[100],
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 5, right: 30, left: 30, bottom: 5),
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                textDirection: TextDirection.rtl,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Spacer(),
                                  Container(
                                      child: Text(
                                        'الاجمالي :',
                                        textAlign: TextAlign.center,
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 9),
                                      )),
                                  Spacer(),
                                  Expanded(
                                      child: Text(
                                    'خصم مبلغ',
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 9),
                                  )),
                                  Radio(
                                      value: 1,
                                      groupValue: cubit.ROfferval,
                                      onChanged: (v) {
                                        if (offer.text != null &&
                                            offer.text != '')
                                          cubit.ChageRadioOffer(
                                              v: v,
                                              offer: double.parse(offer.text));
                                        else
                                          cubit.ChageRadioOffer(
                                              v: v, offer: 0.0);
                                      }),
                                  // Spacer(),
                                  Text(
                                    '%الخصم',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 9),
                                  ),
                                  Radio(
                                      value: 2,
                                      groupValue: cubit.ROfferval,
                                      onChanged: (v) {
                                        if (offer.text != null &&
                                            offer.text != '')
                                          cubit.ChageRadioOffer(
                                              v: v,
                                              offer: double.parse(offer.text));
                                        else
                                          cubit.ChageRadioOffer(v: v, offer: 0);
                                      }),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                textDirection: TextDirection.rtl,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  borderContainer(
                                      text: '${cubit.V_Total} جنيه',
                                      borderWidth: 2,
                                      Size: 12,
                                      width: MediaQuery.of(context).size.width /
                                              2 -
                                          95,
                                      height: 50,
                                      color: defultcolor),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2 -
                                            95,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black,
                                            width: 2,
                                            style: BorderStyle.solid)),
                                    child: Center(
                                      child: TextFormField(
                                        controller: offer,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          hintText: '0',
                                          hintStyle: TextStyle(
                                              color: Colors.redAccent),
                                        ),
                                        style: TextStyle(
                                            color: Colors.redAccent,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                        textAlign: TextAlign.center,
                                        cursorColor: Colors.redAccent,
                                        onChanged: (v) {
                                          if (v == '' && cubit.ROfferval == 1)
                                            cubit.ChageRadioOffer(
                                                v: cubit.ROfferval, offer: 0);
                                          if (v == '' && cubit.ROfferval == 2)
                                            cubit.ChageRadioOffer(
                                                v: cubit.ROfferval, offer: 0);
                                          else
                                            cubit.ChageRadioOffer(
                                                v: cubit.ROfferval,
                                                offer: double.parse(v));
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                      width: MediaQuery.of(context).size.width *
                                              .5 -
                                          30,
                                      child: Text(
                                        'بعد الخصم :',
                                        textAlign: TextAlign.start,
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                            color: defultcolor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      )),
                                  Spacer(),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                textDirection: TextDirection.rtl,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    height: 60,
                                    width: (MediaQuery.of(context).size.width /
                                            2) -
                                        90,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        gradient: LinearGradient(
                                            colors: buttonColor)),
                                    clipBehavior: Clip.antiAlias,
                                    child: MaterialButton(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          child: Text(
                                            'حاسب',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        ),
                                        onPressed: () async {
                                          Cache.play('m.mp3',
                                              mode: PlayerMode.LOW_LATENCY);
                                          if (cubit.ItemsList.length > 0) {
                                              openFollowItem(
                                                  context: context,
                                                  ITEMmodel: cubit.ItemsList);
                                          } else
                                            openmessageNull(context);
                                        }),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  borderContainer(
                                      text: '${cubit.AfterOffer} جنيه',
                                      borderWidth: 2,
                                      Size: 12,
                                      width: MediaQuery.of(context).size.width /
                                              2 -
                                          95,
                                      height: 50,
                                      color: Colors.redAccent),
                                ],
                              ),
                            ],
                          ),
                          color: Colors.white,
                        ),
                      ),
                      CircleAvatar(
                          radius: 20,
                          backgroundColor: defultcolor,
                          child: IconButton(
                            onPressed: () {
                              NavigatorTo(context, CategoriesScreen());
                            },
                            icon: Icon(Icons.apps_outlined),
                            color: Colors.white,
                          )),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  Widget Items({colors, context, cubit, InvoiceItemModel? ITEMmodel}) =>
      Container(
        //height: 75,
        color: colors,
        child: InkWell(
          onTap: () {
            editProtectDialog(context: context, ITEMmodel: ITEMmodel!);
            // openCalculteItem(context, ITEMmodel!);
            posCubit.get(context).numText = ITEMmodel.UomQuantity!;
            cubit.changeCheck(priceText: ITEMmodel.SALES_PRICE1 ?? 0 , Vcheck: false);
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            textDirection: TextDirection.rtl,
            children: [
              SizedBox(
                width: 10,
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 5),
              //   child: Stack(
              //     alignment: Alignment.center,
              //     children: [
              //       CircleAvatar(
              //         radius: 28,
              //         backgroundColor: Colors.black,
              //       ),
              //       CircleAvatar(
              //         radius: 26,
              //         backgroundImage: AssetImage('images/images.png'),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   width: 10,
              // ),
              Expanded(
                child: Container(height: 65,
                  child: Center(
                    child: Text(
                      '${ITEMmodel!.ITEM_NAME ?? ''}',
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: defultblack,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: 55,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                clipBehavior: Clip.antiAlias,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    '${ITEMmodel.Price ?? '0'} '   ,
                  //  '',
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(
                        color: defultcolor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Container(
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                clipBehavior: Clip.antiAlias,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    children: [
                      Text(
                        "${ITEMmodel.UomQuantity ?? '0'} x ${ITEMmodel.StandConvFactor}",textAlign: TextAlign.center,//textDirection: TextDirection.rtl,
                        // '1000',
                        maxLines: 2,
                        style: TextStyle(
                            color: defultcolor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                      // Text(
                      //   "${ITEMmodel.UomName}",textAlign: TextAlign.center,
                      //   // '1000',
                      //   maxLines: 2,
                      //   style: TextStyle(
                      //       color: defultcolor,
                      //       fontSize: 12,
                      //       fontWeight: FontWeight.bold),
                      // ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Container(
                width: 55,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                clipBehavior: Clip.antiAlias,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    '${ITEMmodel.TOTAL ?? '0'}',
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(
                        color: defultcolor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
            ],
          ),
        ),
      );


  String dataS = "";

  Scan() async {
    await FlutterBarcodeScanner.scanBarcode(
            '#343128', 'cancel', true, ScanMode.BARCODE)
        .then((value) => setState(() {
              dataS = value;
             posCubit.get(context).Search_ItemsBARCODE(
                  BARCODE: dataS,
                 );
              print(dataS);
            }));
  }
}

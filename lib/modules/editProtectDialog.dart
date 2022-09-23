import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/cubit/cubit.dart';
import 'package:pos/models/InvoiceItemModel.dart';
import 'package:pos/modules/Buyingrecipt.dart';
import 'package:pos/shared/component.dart';
import 'package:pos/shared/style/colors.dart';

import '../DataBase/getDB.dart';
import '../cubit/states.dart';
import '../models/Inv_Uom_Model.dart';
import '../shared/Content.dart';

TextEditingController Quantitycontroller = TextEditingController();
// TextEditingController T1controller=TextEditingController();
// TextEditingController T2controller=TextEditingController();
// TextEditingController T3controller=TextEditingController();

double? Quantity;

bool FristOpen = true;
//bool ? checkItem ;

Future editProtectDialog({context, required InvoiceItemModel ITEMmodel}) =>
    showDialog(
        context: context,
        builder: (context) {
          var cubit = posCubit.get(context);
          // if(ITEMmodel.T1_QUANTITY != null )    T1controller.text= ITEMmodel.T1_QUANTITY.toString() ;
          // if(ITEMmodel.T2_QUANTITY != null )      T2controller.text= ITEMmodel.T2_QUANTITY.toString();
          // if(ITEMmodel.T3_QUANTITY != null )      T3controller.text= ITEMmodel.T3_QUANTITY.toString();

          if (((Quantitycontroller.text != null ||
                      Quantitycontroller.text == '') ||
                  ITEMmodel.UomQuantity != null) &&
              FristOpen) {
            Quantity = ITEMmodel.UomQuantity;
            Quantitycontroller.text = ITEMmodel.UomQuantity.toString();
          }
          return AlertDialog(
            content: BlocConsumer<posCubit, posStates>(
                listener: (context, state) {},
                builder: (context, state) {
                  var cubit = posCubit.get(context);
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'تعديل بيانات الصنف',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          textDirection: TextDirection.rtl,
                          children: [
                            Container(
                                width: 90,
                                child: Text(
                                  'الكمية',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                )),
                            Expanded(
                              child: defultTextField(
                                  context: context,
                                  height: 40,
                                  hintcolor: Colors.redAccent,
                                  controller: Quantitycontroller,
                                  type: TextInputType.number,
                                  Texttcolor: Colors.redAccent,
                                  ontap: (){

                                    Quantitycontroller.text = '' ;
                                    cubit.ChangeQunController();
                                    },
                                  onchange: (v) {
                                    if (v == '') {
                                      Quantity = 1.0;
                                    } else
                                      Quantity = double.parse(v);

                                  }),

                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        //  Row(
                        //    crossAxisAlignment: CrossAxisAlignment.center,
                        //    mainAxisAlignment: MainAxisAlignment.center,
                        //    textDirection: TextDirection.rtl,
                        //    children: [
                        //      Spacer(),
                        //      Container(
                        //          width: 112,
                        //          child: Text(
                        //            'معادله رياضيه',
                        //            textAlign: TextAlign.center,
                        //            style: TextStyle(
                        //                fontWeight: FontWeight.bold, fontSize: 14),
                        //          )),
                        //      Spacer(),
                        //      Checkbox(
                        //       // value: cubit.checkEditQuantity,
                        //        value: ITEMmodel.check,
                        //        onChanged: (bool? v) {
                        //            cubit.changeEditQuantityCheck(v);
                        //            ITEMmodel.check = cubit.checkEditQuantity ;
                        //        },
                        //        activeColor: defultcolor,
                        //      ),
                        //    ],
                        //  ),
                        //  if(ITEMmodel.check!)
                        // // if(cubit.checkEditQuantity )
                        //     Row(
                        //    crossAxisAlignment: CrossAxisAlignment.center,
                        //    mainAxisAlignment: MainAxisAlignment.center,
                        //    textDirection: TextDirection.rtl,
                        //    children: [
                        //      Container(
                        //        width: MediaQuery.of(context).size.width/6 ,
                        //        height: 35,
                        //        decoration: BoxDecoration(
                        //            border:Border.all(color: Colors.black,width: 0.5,style: BorderStyle.solid)),
                        //        child: TextFormField(
                        //          controller: T1controller ,
                        //          keyboardType: TextInputType.number,maxLines: 1,minLines:1 ,
                        //          style: TextStyle(
                        //              color: Colors.redAccent,
                        //              fontWeight: FontWeight.bold,
                        //              fontSize: 12),textAlignVertical: TextAlignVertical.center,
                        //          decoration: InputDecoration( contentPadding: EdgeInsets.zero,
                        //              border: OutlineInputBorder(borderSide: BorderSide(color:Colors.black,width: 3,style: BorderStyle.solid ) )),
                        //          textAlign: TextAlign.center,
                        //          cursorColor:Colors.redAccent ,
                        //          onChanged: (v){
                        //           if(v != '') ITEMmodel.T1_QUANTITY = int.parse(v);
                        //          },
                        //          onFieldSubmitted: (v)
                        //          {
                        //            cubit.EditQuantityCheck();
                        //          },
                        //
                        //        ),
                        //      ),
                        //      SizedBox(
                        //        width: 5,
                        //      ),
                        //      Text('X'),
                        //      SizedBox(
                        //        width: 5,
                        //      ),
                        //      Container(
                        //        width: MediaQuery.of(context).size.width/6,
                        //        height: 40,
                        //        decoration: BoxDecoration(
                        //            border:Border.all(color: Colors.black,width: 0.5,style: BorderStyle.solid)),
                        //        child: Padding(
                        //          padding: const EdgeInsets.all(0.0),
                        //          child: TextFormField(
                        //            controller:T2controller ,
                        //            keyboardType: TextInputType.number,maxLines: 1,minLines:1 ,
                        //            style: TextStyle(
                        //                color: Colors.redAccent,
                        //                fontWeight: FontWeight.bold,
                        //                fontSize: 12),textAlignVertical: TextAlignVertical.center,
                        //            decoration: InputDecoration( contentPadding: EdgeInsets.zero,
                        //            border: OutlineInputBorder(borderSide: BorderSide(color:Colors.black,width: 3,style: BorderStyle.solid ) )),
                        //            textAlign: TextAlign.center,
                        //            cursorColor:Colors.redAccent ,
                        //            onChanged: (v){
                        //              if(v != '') ITEMmodel.T2_QUANTITY = int.parse(v);
                        //            },
                        //            onFieldSubmitted: (v)
                        //            {
                        //              cubit.EditQuantityCheck();
                        //            },
                        //
                        //          ),
                        //        ),
                        //      ),
                        //      SizedBox(
                        //        width: 5,
                        //      ),
                        //      Text('X'),
                        //      SizedBox(
                        //        width: 5,
                        //      ),
                        //      Container(
                        //        width: MediaQuery.of(context).size.width/6,
                        //        height: 40,
                        //        decoration: BoxDecoration(
                        //            border:Border.all(color: Colors.black,width: 0.5,style: BorderStyle.solid)),
                        //        child: TextFormField(
                        //          controller:T3controller ,
                        //          keyboardType: TextInputType.number,maxLines: 1,minLines:1 ,
                        //          style: TextStyle(
                        //              color: Colors.redAccent,
                        //              fontWeight: FontWeight.bold,
                        //              fontSize: 12),textAlignVertical: TextAlignVertical.center,
                        //          decoration: InputDecoration(border: OutlineInputBorder(borderSide: BorderSide(color:Colors.black,width: 3,style: BorderStyle.solid ) )),
                        //          textAlign: TextAlign.center,
                        //          cursorColor:Colors.redAccent ,
                        //          onChanged: (v){
                        //            if(v != '') ITEMmodel.T3_QUANTITY = int.parse(v);
                        //          },
                        //          onFieldSubmitted: (v)
                        //          {
                        //            cubit.EditQuantityCheck();
                        //          },
                        //
                        //        ),
                        //      ),
                        //    ],
                        //  ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          textDirection: TextDirection.rtl,
                          children: [
                            Container(
                                width: 90,
                                child: Text(
                                  'الوحدة',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: defultblack,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                )),
                            Expanded(
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Colors.grey[200]),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  textDirection: TextDirection.rtl,
                                  children: [
                                    SizedBox(
                                      width: 15,
                                    ),
                                    DropdownButton<String>(
                                        menuMaxHeight: 160,
                                        underline: Container(),
                                        //TREASURY_Model> TREASURY_RAYMENT
                                        items: Inv_Uom_List.map(
                                            (Inv_Uom_Model item) {
                                          return DropdownMenuItem<String>(
                                            value: item.UomName,
                                            alignment:
                                                AlignmentDirectional.centerEnd,
                                            child: Text(
                                              item.UomName.toString(),
                                              textAlign: TextAlign.center,
                                              textDirection: TextDirection.rtl,
                                              style: TextStyle(
                                                  color: defultcolor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 11),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (v) async {
                                          await cubit.changeDropdownInvUom(
                                              v: v.toString(),
                                              ITEMmodel: ITEMmodel);
                                        },
                                        value: ITEMmodel.UomName),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          textDirection: TextDirection.rtl,
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                                width: 45,
                                child: Text(
                                  'سعر 1',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                )),
                            Radio(
                                value: 1,
                                groupValue: cubit.RPrice,
                                onChanged: (v) {
                                  cubit.ChageRadioPrice(v);
                                }),
                            Expanded(
                              child: Container(
                                  height: 35,
                                  decoration: BoxDecoration(
                                      color: TTF,
                                      borderRadius: BorderRadius.circular(12)),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Center(
                                    child: Text(
                                      '${ITEMmodel.SALES_PRICE1 ?? '0'}'
                                          .toString(),
                                      textAlign: TextAlign.center,
                                      textDirection: TextDirection.ltr,
                                      style: TextStyle(
                                          color: defultcolor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        if (ITEMmodel.SalesPrice2 != null)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            textDirection: TextDirection.rtl,
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                  width: 45,
                                  child: Text(
                                    'سعر 2',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  )),
                              Radio(
                                  value: 2,
                                  groupValue: cubit.RPrice,
                                  onChanged: (v) {
                                    cubit.ChageRadioPrice(v);
                                  }),
                              Expanded(
                                child: Container(
                                    height: 35,
                                    decoration: BoxDecoration(
                                        color: TTF,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: Center(
                                      child: Text(
                                        '${ITEMmodel.SalesPrice2}',
                                        textAlign: TextAlign.center,
                                        textDirection: TextDirection.ltr,
                                        style: TextStyle(
                                            color: defultcolor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        SizedBox(
                          height: 5,
                        ),
                        if (ITEMmodel.SalesPrice3 != null)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            textDirection: TextDirection.rtl,
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                  width: 45,
                                  child: Text(
                                    'سعر 3',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  )),
                              Radio(
                                  value: 3,
                                  groupValue: cubit.RPrice,
                                  onChanged: (v) {
                                    cubit.ChageRadioPrice(v);
                                  }),
                              Expanded(
                                child: Container(
                                    height: 35,
                                    decoration: BoxDecoration(
                                        color: TTF,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: Center(
                                      child: Text(
                                        '${ITEMmodel.SalesPrice3}',
                                        textAlign: TextAlign.center,
                                        textDirection: TextDirection.ltr,
                                        style: TextStyle(
                                            color: defultcolor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          textDirection: TextDirection.rtl,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12)),
                                clipBehavior: Clip.antiAlias,
                                height: 70,
                                child: MaterialButton(
                                    color: TTF,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      child: Text(
                                        'حذف الصنف من القائمه',
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        style: TextStyle(
                                            color: Colors.redAccent,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);

                                      // openmessageMissQuantityE(context:  context, ITEMmodel:  ITEMmodel);
                                      posCubit
                                          .get(context)
                                          .DeletFormItemsList(item: ITEMmodel);
                                      //  cubit.changeEditQuantityCheck(false);

                                      Quantitycontroller.text = '1';
                                      cubit.RPrice = 1;
                                      //Navigator.pop(context);
                                      FristOpen = true;
                                    }),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  gradient:
                                      LinearGradient(colors: buttonColor)),
                              clipBehavior: Clip.antiAlias,
                              child: MaterialButton(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 5),
                                    child: Text(
                                      'حفظ',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                  ),
                                  onPressed: () {
                                    // if(ITEMmodel.check! && T1controller.text == '' && T2controller.text == ''&& T3controller.text == '' ) {
                                    //   ITEMmodel.check = false ;
                                    // }
                                    // if(ITEMmodel.check! ) {
                                    //       cubit.EditQuantityCheck();
                                    //     }
                                    if (Quantitycontroller.text == null ||
                                        Quantitycontroller == '') {
                                      Quantity = 1.0;
                                    }
                                    //if(cubit.)
                                    //  cubit.UpdateITEM_QUANTITY(item_Model: );
                                    if (cubit.RPrice == 1) {
                                      cubit.UpdateFormItemsList(
                                        Price: ITEMmodel.SALES_PRICE1 as double,
                                        UomQUANTITY: Quantity!,
                                        item: ITEMmodel,
                                        context: context,
                                        // T1: T1controller.text ,
                                        // T2: T2controller.text ,
                                        // T3: T3controller.text ,
                                        // check: ITEMmodel.check!
                                      );
                                    }
                                    if (cubit.RPrice == 2) {
                                      cubit.UpdateFormItemsList(
                                          Price:
                                              ITEMmodel.SalesPrice2 as double,
                                          UomQUANTITY: Quantity!,
                                          item: ITEMmodel,
                                          // T1: T1controller.text ,
                                          // T2: T2controller.text ,
                                          // T3: T3controller.text ,
                                          // check: ITEMmodel.check!,
                                          context: context);
                                    }
                                    if (cubit.RPrice == 3) {
                                      cubit.UpdateFormItemsList(
                                          Price:
                                              ITEMmodel.SalesPrice3 as double,
                                          UomQUANTITY: Quantity!,
                                          item: ITEMmodel,
                                          // T1: T1controller.text ,
                                          // T2: T2controller.text ,
                                          // T3: T3controller.text ,
                                          // check: ITEMmodel.check!,
                                          context: context);
                                    }
                                    Cache.play('m.mp3',
                                        mode: PlayerMode.LOW_LATENCY);
                                    Navigator.pop(context);
                                    if (cubit.N_Q)
                                      openmessageMissQuantityE(
                                          context: context,
                                          ITEMmodel: ITEMmodel,
                                          Quantity: Quantity);
                                    Quantitycontroller.text = '';
                                    FristOpen = true;
                                  }),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
          );
        });

Future openmessageMissQuantityE(
        {context, required InvoiceItemModel ITEMmodel, Quantity}) =>
    showDialog(
        context: context,
        builder: (context) {
          var cubit = posCubit.get(context);
          return AlertDialog(
            contentPadding: EdgeInsets.all(5),
            content: Container(
              // width: 200,
              //  height: 100,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'هذه الكمية غير موجودة بالمخزن',
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.black),
                  ),
                  Row(
                    textDirection: TextDirection.rtl,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: LinearGradient(colors: buttonColor)),
                        clipBehavior: Clip.antiAlias,
                        child: MaterialButton(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 5),
                              child: Text(
                                'استكمال',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                            ),
                            onPressed: () {
                              if (cubit.RPrice == 1) {
                                cubit.UpdateFormItemsList(
                                  Price: ITEMmodel.SALES_PRICE1 as double,
                                  UomQUANTITY: Quantity,
                                  item: ITEMmodel,
                                  state: true,
                                  context: context,
                                  //    T1: T1controller.text ,
                                  //  check: ITEMmodel.check!,
                                  //  T2: T2controller.text ,
                                  //  T3: T3controller.text
                                );
                              }
                              if (cubit.RPrice == 2) {
                                cubit.UpdateFormItemsList(
                                  Price: ITEMmodel.SalesPrice2 as double,
                                  UomQUANTITY: Quantity!,
                                  item: ITEMmodel,
                                  state: true,
                                  context: context,
                                  // T1: T1controller.text ,
                                  // check: ITEMmodel.check!,
                                  // T2: T2controller.text ,
                                  // T3: T3controller.text
                                );
                              }
                              if (cubit.RPrice == 3) {
                                cubit.UpdateFormItemsList(
                                  Price: ITEMmodel.SalesPrice3 as double,
                                  UomQUANTITY: Quantity!,
                                  item: ITEMmodel,
                                  state: true,
                                  context: context,
                                  // check: ITEMmodel.check!,
                                  // T1: T1controller.text ,
                                  // T2: T2controller.text ,
                                  // T3: T3controller.text
                                );
                                openmessageMissQuantityE(
                                    context: context, ITEMmodel: ITEMmodel);
                              }
                              NavigatorTo(context, Buyingrecipt());
                            }),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: LinearGradient(colors: buttonColor)),
                        clipBehavior: Clip.antiAlias,
                        child: MaterialButton(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 5),
                              child: Text(
                                'الغاء',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });

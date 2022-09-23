import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../DataBase/INSERTS.dart';
import 'package:pos/modules/sale_invoiceDialog.dart';
import 'package:pos/cubit/cubit.dart';
import 'package:pos/cubit/states.dart';
import 'package:pos/DataBase/getDB.dart';
import 'package:pos/models/PAYMENT_METHOD_Model.dart';
import 'package:pos/models/TREASURY_Model.dart';
import '../models/InvoiceItemModel.dart';
import '../shared/Content.dart';
import '../shared/component.dart';
import '../shared/style/colors.dart';
import 'Buyingrecipt.dart';

TextEditingController paid = TextEditingController();
List<int> itemID = [];

Future openFollowItem({context, List<InvoiceItemModel>? ITEMmodel}) =>
    showDialog(
        context: context,
        builder: (context) {
          var cubit = posCubit.get(context);
          ITEMmodel!.forEach((element) {
            itemID = [];
            itemID.add(element.ITEM_ID as int);
          });
          return AlertDialog(
            backgroundColor: Colors.white,
            content: StatefulBuilder(
              builder: (context,setState) => BlocConsumer<posCubit, posStates>(
                listener: (context, state) {},
                builder: (context,setState) =>SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'فاتوره مبيعات',
                        maxLines: 2,
                        style: TextStyle(
                            color: defultcolor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
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
                                'دفع كاش',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: defultblack,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10),
                              )),
                          Radio(
                              value: 1,
                              groupValue: cubit.Rval,
                              onChanged: (v) {
                               // setState((){});
                                if (paid.text != null && paid.text != '')
                                  cubit.ChageRadioFollowing(
                                      v: v, paid: double.parse(paid.text));
                                else
                                  cubit.ChageRadioFollowing(v: v);
                               // setState((){});
                              }),
                          Container(
                            width: (MediaQuery.of(context).size.width / 2) - 130,
                            child: Text(
                              'دفع أجل',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: defultblack,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10),
                            ),
                          ),
                          Radio(
                              value: 2,
                              groupValue: cubit.Rval,
                              onChanged: (v) {
                               // setState((){});
                                if (paid.text != null && paid.text != '')
                                  cubit.ChageRadioFollowing(
                                      v: v, paid: double.parse(paid.text));
                                else
                                  cubit.ChageRadioFollowing(v: v);
                               // setState((){});
                              }),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        textDirection: TextDirection.rtl,
                        children: [
                          Container(
                              width:
                              (MediaQuery.of(context).size.width / 2) - 130,
                              child: Text(
                                'طرق الدفع',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: defultblack,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              )),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.grey[200]),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                textDirection: TextDirection.rtl,
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  DropdownButton<String>(
                                    menuMaxHeight: 180,underline: Container(),
                                    items: PAYMENT_METHOD_ModelList.map(
                                            (PAYMENT_METHOD_Model item) {
                                          return DropdownMenuItem<String>(
                                            value: item.PAYMENT_METHOD_NAME,
                                            alignment: AlignmentDirectional.centerEnd,
                                            child: Text(
                                              item.PAYMENT_METHOD_NAME.toString(),
                                              textAlign: TextAlign.center,
                                              textDirection: TextDirection.rtl,
                                              style: TextStyle(
                                                  color: defultcolor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12),
                                            ),
                                          );
                                        }).toList(),
                                    onChanged: (v) {
                                     // setState((){});
                                      cubit.changeDropdownPAYMENT_METHOD(
                                          v: v.toString());
                                     // setState((){});
                                    },
                                    value: cubit.valPAYMENT_METHOD.toString().isNotEmpty ? cubit.valPAYMENT_METHOD.toString() : null ,

                                  ),

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        textDirection: TextDirection.rtl,
                        children: [
                          Container(
                              width:
                              (MediaQuery.of(context).size.width / 2) - 130,
                              child: Text(
                                'خزن/بنوك',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: defultblack,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              )),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.grey[200]),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                textDirection: TextDirection.rtl,
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  DropdownButton<String>(
                                    menuMaxHeight: 180,underline: Container(),
                                    //TREASURY_Model> TREASURY_RAYMENT
                                    items: cubit.TREASURY_RAYMENT
                                        .map((TREASURY_Model item) {
                                      return DropdownMenuItem<String>(
                                        value: item.TreasuryName,
                                        alignment: AlignmentDirectional.centerEnd,
                                        child: Text(
                                          item.TreasuryName.toString(),
                                          textAlign: TextAlign.center,
                                          textDirection: TextDirection.rtl,
                                          style: TextStyle(
                                              color: defultcolor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (v) {
                                      cubit.changeDropdownBanks_Treasury(
                                          v: v.toString());
                                    },
                                    value: cubit.valBanks_Treasury.toString().isNotEmpty ? cubit.valBanks_Treasury.toString() : null ,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        textDirection: TextDirection.rtl,
                        children: [
                          Container(
                              width:
                              (MediaQuery.of(context).size.width / 2) - 130,
                              child: Text(
                                'الاجمالى',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: defultblack,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              )),
                          Expanded(
                            child: Container(
                                height: 48,
                                decoration: BoxDecoration(
                                    color: TTF,
                                    borderRadius: BorderRadius.circular(12)),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Center(
                                  child: Text(
                                    '${cubit.AfterOffer} جنيه',
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
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        textDirection: TextDirection.rtl,
                        children: [
                          Container(
                              width:
                              (MediaQuery.of(context).size.width / 2) - 130,
                              child: Text(
                                'مدفوع',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: defultblack,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              )),
                          if (cubit.Rval == 1)
                            Expanded(
                              child: Container(
                                  height: 48,
                                  decoration: BoxDecoration(
                                      color: TTF,
                                      borderRadius: BorderRadius.circular(12)),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Center(
                                    child: Text(
                                      '${cubit.AfterOffer} جنيه',
                                      textAlign: TextAlign.center,
                                      textDirection: TextDirection.ltr,
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                  )),
                            ),
                          if (cubit.Rval == 2)
                            Expanded(
                              child: defultTextField(
                                  context: context,
                                  controller: paid,
                                  type: TextInputType.number,
                                  hintText: '0.0',
                                  hintcolor: Colors.red,
                                  onchange: (v) {
                                    if (v != null && v != '')
                                      cubit.ChageRadioFollowing(
                                          v: cubit.Rval, paid: double.parse(v));
                                    else
                                      cubit.ChageRadioFollowing(v: cubit.Rval);
                                  }),
                            ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        textDirection: TextDirection.rtl,
                        children: [
                          Container(
                              width:
                              (MediaQuery.of(context).size.width / 2) - 130,
                              child: Text(
                                'باقي',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: defultblack,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              )),
                          Expanded(
                            child: Container(
                                height: 48,
                                decoration: BoxDecoration(
                                    color: TTF,
                                    borderRadius: BorderRadius.circular(12)),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Center(
                                  child: Text(
                                    '${cubit.remander} جنيه',
                                    textAlign: TextAlign.center,
                                    textDirection: TextDirection.ltr,
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      Row(
                        textDirection: TextDirection.rtl,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: (MediaQuery.of(context).size.width * 0.6) - 80,
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                gradient: LinearGradient(colors: buttonColor)),
                            clipBehavior: Clip.antiAlias,
                            child: MaterialButton(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 5),
                                  child: Text(
                                    'تسجيل عملية البيع',
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                ),
                                onPressed: () async {
                                  if ((paid.text == '' || paid.text == null) &&
                                      cubit.Rval == 2) paid.text = '0.0';
                                  if ((paid.text == '' || paid.text == null) &&
                                      cubit.Rval == 1)
                                    paid.text = cubit.AfterOffer.toString();
                                  if ((paid.text != '' || paid.text != null) &&
                                      cubit.Rval == 1)
                                    paid.text = cubit.AfterOffer.toString();

                                  if ((cubit.valPAYMENT_METHOD.toString() != '' &&
                                      cubit.valBanks_Treasury != '') || cubit.Rval == 2  ) {
                                    // await cubit.updataCUSTAMOUNT_PAID(
                                    //     Cust_Model: Cust_Model!,
                                    //     remender: cubit.remander);

                                    await insertINVOICE(
                                        context: context,
                                        INVOICE_DATE: DateTime.now().toString(),
                                        CustVenId: Cust_Model!.CUST_VEN_ID,
                                        InvoiceType: cubit.RInvoice,
                                        OFFER: cubit.Discount,
                                        PAYMENT_METHOD_ID:
                                        cubit.V_PAYMENT_METHOD_ID,
                                        Paid: paid.text,
                                        Remaind: cubit.remander,
                                        PRICE: cubit.V_Total,
                                        TREASURY_ID: cubit.V_TREASURY_ID,
                                        STOCK_ID: cubit.V_STOCKID,
                                        VALUE: cubit.AfterOffer);

                                    if (insertINVOICES) {
                                      Cache.play('m.mp3',
                                          mode: PlayerMode.LOW_LATENCY);
                                      Future.delayed(Duration(milliseconds:60),() async {
                                        if (INVOICE_model!.INVOICE_TYPE == 1)
                                        {
                                          await insertCashInOut(
                                              CustVenId: Cust_Model!.CUST_VEN_ID,
                                              TreasuryId: cubit.V_TREASURY_ID,
                                              Add: true,
                                              Amount: double.parse(paid.text),
                                              DocDate: DateTime.now().toString(),
                                              ExpenseId: null,
                                              TransType: 'IN',    // 'OUT'   'IN'
                                              Remark: 'بيع',
                                              // getTable: true,
                                              PaymentMethodId:
                                              cubit.V_PAYMENT_METHOD_ID,
                                              InvoiceId: INVOICE_model!.INVOICE_ID,
                                              status: "new");
                                        }
                                        if (INVOICE_model!.INVOICE_TYPE == 2)
                                        {
                                          await insertCashInOut(
                                              CustVenId: Cust_Model!.CUST_VEN_ID,
                                              TreasuryId: cubit.V_TREASURY_ID,
                                              Add: false,
                                              //getTable: true,
                                              Amount: double.parse(paid.text),
                                              DocDate: DateTime.now().toString(),
                                              ExpenseId: null,
                                              TransType: 'OUT',     // 'OUT'   'IN'
                                              Remark: 'مرتجع',
                                              PaymentMethodId:
                                              cubit.V_PAYMENT_METHOD_ID,
                                              InvoiceId: INVOICE_model!.INVOICE_ID,
                                              status: "new");
                                        }


                                        NavigatorTo(context, Buyingrecipt());

                                          sale_invoice(
                                              context: context,
                                              ITEMmodel: ITEMmodel);
                                   //     });
                                      });
                                      Future.delayed(Duration(seconds:2),() async {
                                                                              //    setState(() {
                                        paid.text = '';
                                        cubit.Rval = 1;
                                        cubit.valPAYMENT_METHOD = '';
                                        cubit.valBanks_Treasury = '';
                                        cubit.V_Total = 0;
                                        cubit.AfterOffer = 0;
                                        cubit.remander = 0;
                                        cubit.valStock = '';
                                      });

                                    }
                                  } else
                                    openmessagePaymentNull(context);
                                }),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          defultButton(
                              text: 'الغاء',
                              width:
                              (MediaQuery.of(context).size.width * 0.3 - 30),
                              ontap: () {
                                Navigator.pop(context);
                                cubit.ChageRadioFollowing(v: 1);
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });


  Future openmessagePaymentNull(context) =>
      showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(
                contentPadding: EdgeInsets.symmetric(vertical: 2),
                content: Text(
                  'من فضلك ادخل طرق الدفع',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black),
                ),
              ));


Future openmessageNull(context) => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      contentPadding: EdgeInsets.all(3),
      content: Text(
        'ابحث عن المنتج عن طريق الاسم او الباركود باستخدام الكاميرا',
        textAlign: TextAlign.center,
        maxLines: 2,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black),
      ),
    ));






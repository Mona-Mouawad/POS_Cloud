import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/DataBase/getDB.dart';
import 'package:pos/cubit/cubit.dart';
import 'package:pos/cubit/states.dart';
import 'package:pos/models/PAYMENT_METHOD_Model.dart';
import 'package:pos/models/TREASURY_Model.dart';
import 'package:pos/modules/TreasuryMoveReport.dart';
import 'package:pos/shared/Content.dart';
import 'package:pos/shared/component.dart';
import 'package:pos/shared/style/colors.dart';

import '../DataBase/INSERTS.dart';

class Treasury extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _Treasury();
}

class _Treasury extends State<Treasury> {
  TextEditingController amount = TextEditingController();
  TextEditingController notes = TextEditingController();
  TextEditingController CUST = TextEditingController();
  TextEditingController OUTGOING = TextEditingController();
  TextEditingController CUSTSEARCH = TextEditingController();
  TextEditingController OUTGOINGSEARCH = TextEditingController();

  int ? cust_id ;
  int ? expense_id;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    double width = MediaQuery
        .of(context)
        .size
        .width;

    return BlocConsumer<posCubit, posStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = posCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.grey[300],
            appBar: AppBar(
              title: Text('حركة الخزينه',
                style: TextStyle(fontSize: 18, color: Colors.white),),
            ),
            body: SingleChildScrollView(
              child: Column(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,),
                      clipBehavior: Clip.antiAlias,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image(image: AssetImage('images/خزنه2.jpg'),
                              height: 80,),
                            //   SizedBox(height: 5,),
                            Row(crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              textDirection: TextDirection.rtl,
                              children: [
                                Text(
                                  'خصم من الخزينة', textAlign: TextAlign.center,
                                  style: TextStyle(color: defultcolor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),),
                                Radio(value: 1,
                                    groupValue: cubit.RTreasuryval,
                                    onChanged: (v) {
                                      cubit.ChageRadioTreasury(v);
                                    }),
                                Text(
                                  'اضافه للخزينة', textAlign: TextAlign.center,
                                  style: TextStyle(color: defultcolor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),),
                                Radio(value: 2,
                                    groupValue: cubit.RTreasuryval,
                                    onChanged: (v) {
                                      cubit.ChageRadioTreasury(v);
                                    }),
                              ],),
                            SizedBox(height: 15,),
                            Row(crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              textDirection: TextDirection.rtl,
                              children: [
                                Container(width: (MediaQuery
                                    .of(context)
                                    .size
                                    .width / 2) - 130,
                                    child: Text(
                                      'طرق الدفع', textAlign: TextAlign.center,
                                      style: TextStyle(color: defultcolor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),)),
                                Expanded(
                                  child: Container(height: 45,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        color: Colors.grey[200]),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center,
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      textDirection: TextDirection.rtl,
                                      children: [
                                        SizedBox(width: 15,),
                                        DropdownButton<String>(
                                          menuMaxHeight: 180,
                                          underline: Container(),
                                          items: PAYMENT_METHOD_ModelList.map((
                                              PAYMENT_METHOD_Model item) {
                                            return DropdownMenuItem<String>
                                              (value: item.PAYMENT_METHOD_NAME,
                                              alignment: AlignmentDirectional
                                                  .centerEnd,
                                              child: Text(
                                                item.PAYMENT_METHOD_NAME
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                                textDirection: TextDirection
                                                    .rtl,
                                                style: TextStyle(
                                                    color: defultcolor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12),),
                                            );
                                          }).toList(),
                                          onChanged: (v) {
                                            cubit.changeDropdownPAYMENT_METHOD(
                                                v: v.toString());
                                          },
                                          value: cubit.valPAYMENT_METHOD
                                              .toString()
                                              .isNotEmpty
                                              ? cubit.valPAYMENT_METHOD
                                              .toString()
                                              : null,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15,),
                            Row(crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              textDirection: TextDirection.rtl,
                              children: [
                                Container(width: (MediaQuery
                                    .of(context)
                                    .size
                                    .width / 2) - 130,
                                    child: Text(
                                      'خزن/بنوك', textAlign: TextAlign.center,
                                      style: TextStyle(color: defultcolor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),)),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        color: Colors.grey[200]),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center,
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      textDirection: TextDirection.rtl,
                                      children: [
                                        SizedBox(width: 15,),
                                        DropdownButton<String>(
                                          menuMaxHeight: 180,
                                          underline: Container(),
                                          //TREASURY_Model> TREASURY_RAYMENT
                                          items: cubit.TREASURY_RAYMENT.map((
                                              TREASURY_Model item) {
                                            return DropdownMenuItem<String>
                                              (value: item.TreasuryName,
                                              alignment: AlignmentDirectional
                                                  .centerEnd,
                                              child: Text(
                                                item.TreasuryName.toString(),
                                                textAlign: TextAlign.center,
                                                textDirection: TextDirection
                                                    .rtl,
                                                style: TextStyle(
                                                    color: defultcolor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12),),
                                            );
                                          }).toList(),
                                          onChanged: (v) {
                                            cubit.changeDropdownBanks_Treasury(
                                                v: v.toString());
                                          },
                                          value: cubit.valBanks_Treasury
                                              .toString()
                                              .isNotEmpty
                                              ? cubit.valBanks_Treasury
                                              .toString()
                                              : null,
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15,),
                            Row(crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              textDirection: TextDirection.rtl,
                              children: [
                                Container(width: (MediaQuery
                                    .of(context)
                                    .size
                                    .width / 2) - 130,
                                    child: Text(
                                      'العميل', textAlign: TextAlign.center,
                                      style: TextStyle(color: defultcolor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),)),
                                Expanded(
                                  child: InkWell(onTap: () {
                                    openCUST(context);
                                  },
                                    child: Container( //width: MediaQuery.of(context).size.width*.5 -45,height: 48,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              14),
                                          color: Colors.grey[200]),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .center,
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        textDirection: TextDirection.rtl,
                                        children: [
                                          SizedBox(width: 10,),
                                          Icon(Icons.arrow_drop_down),
                                          SizedBox(width: 20,),
                                          Text(CUST.text.toString(),
                                            // textAlign: TextAlign.end,
                                            textDirection: TextDirection.ltr,
                                            style: TextStyle(color: defultcolor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                            SizedBox(height: 15,),
                            if(cubit.RTreasuryval == 1 )
                              Row(crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                textDirection: TextDirection.rtl,
                                children: [
                                  Container(width: (MediaQuery
                                      .of(context)
                                      .size
                                      .width / 2) - 130,
                                      child: Text('المصروفات',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: defultcolor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),)),
                                  Expanded(
                                    child: InkWell(onTap: () {
                                      openOUTGONINGS(context);
                                    },
                                      child: Container( //width: MediaQuery.of(context).size.width*.5 -45,height: 48,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                14),
                                            color: Colors.grey[200]),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .center,
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          textDirection: TextDirection.rtl,
                                          children: [
                                            SizedBox(width: 10,),
                                            Icon(Icons.arrow_drop_down),
                                            SizedBox(width: 20,),
                                            Text(OUTGOING.text.toString(),
                                              // textAlign: TextAlign.end,
                                              textDirection: TextDirection.ltr,
                                              style: TextStyle(
                                                  color: defultcolor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12),),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            SizedBox(height: 10,),
                            defultTextField(context: context,
                                //controller: paid,
                                type: TextInputType.number,
                                controller: amount,
                                width: width - 30,
                                hintText: 'المبلغ',
                                hintcolor: defultcolor),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Spacer(),
                                Text('ملاحظات',
                                  style: TextStyle(color: defultcolor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      height: 1
                                  ),),
                                SizedBox(width: 15)
                              ],
                            ),
                            defultTextField(width: width - 30,
                                context: context,
                                //controller: remaining,
                                type: TextInputType.text,
                                //    hintText: 'فاتوه....',
                                hintcolor: defultcolor,
                                controller: notes),

                            SizedBox(height: 15,),
                            Row(textDirection: TextDirection.rtl,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(width: (MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.5) - 80,
                                  child: Text('التاريخ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        height: 1
                                    ),),
                                ),
                                Container(
                                  width: (MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.5) - 80,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      gradient: LinearGradient(
                                          colors: buttonColor)),
                                  clipBehavior: Clip.antiAlias,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 5),
                                    child: Center(
                                      child: Text('${DateTime
                                          .now()
                                          .day}-${DateTime
                                          .now()
                                          .month}-${DateTime
                                          .now()
                                          .year}',
                                        style: TextStyle(color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12
                                        ),),
                                    ),
                                  ),
                                ),
                              ],),
                            SizedBox(height: 10,),
                            Row(textDirection: TextDirection.rtl,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                defultButton(text: cubit.ButtonTextTreasury,
                                  ontap: () async {
                                    // await getCashInOut_Id(database);

                                    if (amount.text != '' &&
                                        (CUST.text != '' || CUST.text != null ||
                                            OUTGOING.text != '') &&
                                        cubit.valBanks_Treasury != '' &&
                                        cubit.valPAYMENT_METHOD != ''
                                        && amount.text != null) {
                                      if (cubit.RTreasuryval == 1) {
                                        if (CUST.text == '') {
                                          expense_id = cubit
                                              .OUTGOINGS_model!.OUTGOINGS_ID;
                                          print(
                                              '           OUTGOINGS_model           ' +
                                                  expense_id.toString());
                                          cust_id = null;
                                        }
                                        else if (OUTGOING.text == '') {
                                          cust_id = cubit
                                              .CUST_ModelSearch!.CUST_VEN_ID;
                                          print(
                                              '           CUST_ModelSearch           ' +
                                                  cust_id.toString());
                                          expense_id = null;
                                        }
                                        await insertCashInOut(
                                            TreasuryId: cubit.V_TREASURY_ID,
                                            DocDate: DateTime.now().toString(),
                                            Amount: double.parse(amount.text),
                                            //  CashInOutId: CashInOut_Id,
                                            PaymentMethodId:
                                            cubit.V_PAYMENT_METHOD_ID,
                                            Remark: notes.text,
                                            TransType: 'OUT',
                                            Add: false,
                                            CustVenId: cust_id,
                                            InvoiceId: null,
                                            status: 'new',
                                            //getTable: true,
                                            ExpenseId: expense_id);
                                      }
                                      if (cubit.RTreasuryval == 2) {
                                        await insertCashInOut(
                                          TreasuryId: cubit.V_TREASURY_ID,
                                          DocDate: DateTime.now().toString(),
                                          Add: true,
                                          status: 'new',
                                          //getTable: true,
                                          Amount: double.parse(amount.text),
                                          //     CashInOutId: CashInOut_Id,
                                          PaymentMethodId:
                                          cubit.V_PAYMENT_METHOD_ID,
                                          Remark: notes.text,
                                          TransType: 'IN',
                                          // 'OUT'   'IN'
                                          CustVenId:
                                          cubit.CUST_ModelSearch!.CUST_VEN_ID,
                                          ExpenseId: null,
                                          InvoiceId: null,
                                        );
                                      }

                                      if (inout) {
                                        setState(() {
                                          if (cubit.RTreasuryval == 1) {
                                            openmessageSubSuccess(context);
                                          }
                                          if (cubit.RTreasuryval == 2) {
                                            openmessageAddSuccess(context);
                                          }
                                          Cache.play('m.mp3',
                                              mode: PlayerMode.LOW_LATENCY);
                                          cubit.V_PAYMENT_METHOD_ID = null;
                                          cubit.CUST_ModelSearch = null;
                                          amount.text = '';
                                          cubit.valPAYMENT_METHOD = '';
                                          notes.text = '';
                                          cubit.OUTGOINGS_model = null;
                                          cubit.valBanks_Treasury = '';
                                          CUST.text = '';
                                          OUTGOING.text = '';
                                        });
                                      }
                                    }
                                  },
                                  width: width - 60,)

                              ],),
                          ],
                        ),

                      ),
                    ),
                  ),
                  Container(
                    width: width - 60,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(colors: buttonColor)),
                    clipBehavior: Clip.antiAlias,
                    child: MaterialButton(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 5),
                          child: Text('عرض تقرير بحركه الخزينة',
                            style: TextStyle(color: Colors.white,
                                fontWeight: FontWeight.bold, fontSize: 12
                            ),),
                        ),
                        onPressed: () {
                          // cubit.getCashInOutSearch(date: 00 ,TREASURYNme:  '');
                          cubit.valBanks_TreasuryReport = '';
                          cubit.CashInOut_ModelListSearch = [];
                          NavigatorTo(context, MoveTreasuryReport());
                        }),
                  ),
                  SizedBox(height: 30,),
                ],
              ),
            ),
          );
        });
  }


  Future openCUST(context) =>
      showDialog(
          context: context,
          builder: (context) {
            var cubit = posCubit.get(context);
            return AlertDialog(
              // alignment: Alignment.centerRight,
              contentPadding: EdgeInsets.all(2),
              content: BlocConsumer<posCubit, posStates>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    var cubit = posCubit.get(context);
                    return Container(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * .3,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * .6,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextFormField(
                                controller: CUSTSEARCH,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsetsDirectional.zero,
                                  prefixIcon: Icon(Icons.search),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    cubit.Search_CUST(CUSTNAME: '');
                                  });
                                },
                                onChanged: (v) {
                                  setState(() {
                                    cubit.Search_CUST(CUSTNAME: v);
                                  });
                                },
                              ),
                            ),

                            ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) =>
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          cubit.CUST_ModelSearch = cubit
                                              .CUST_ModelListSearch[index];
                                          print(cubit.CUST_ModelSearch!
                                              .CUST_VEN_ID);
                                          print(cubit.CUST_ModelSearch!.NAME);
                                          CUST.text =
                                              cubit.CUST_ModelSearch!.NAME!
                                                  .toString();
                                          if (cubit.RTreasuryval == 1) {
                                            OUTGOING.text = '';
                                            cubit
                                                .OUTGOINGS_model = null;
                                          }
                                          CUSTSEARCH.text = '';
                                          cubit.CUST_ModelListSearch = [];
                                          Navigator.pop(context);
                                        });
                                      },
                                      child: Text(
                                        cubit.CUST_ModelListSearch[index].NAME
                                            .toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                    ),
                                separatorBuilder: (context, index) =>
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 50, vertical: 10),
                                      child: Container(
                                        height: 1,
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width * .2,
                                        color: defultcolor,
                                      ),
                                    ),
                                itemCount: cubit.CUST_ModelListSearch.length)
                          ],
                        ),
                      ),
                    );
                  }
              ),
            );
          });

  Future openOUTGONINGS(context) =>
      showDialog(
          context: context,
          builder: (context) {
            var cubit = posCubit.get(context);
            return AlertDialog(
              // alignment: Alignment.centerRight,
              contentPadding: EdgeInsets.all(2),
              content: BlocConsumer<posCubit, posStates>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    var cubit = posCubit.get(context);
                    return Container(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * .3,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * .6,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextFormField(
                                controller: OUTGOINGSEARCH,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsetsDirectional.zero,
                                  prefixIcon: Icon(Icons.search),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    cubit.Search_OUTGOINGS(Outgoing: '');
                                  });
                                },
                                onChanged: (v) {
                                  setState(() {
                                    cubit.Search_OUTGOINGS(Outgoing: v);
                                  });
                                },
                              ),
                            ),

                            ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) =>
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          cubit
                                              .OUTGOINGS_model = cubit
                                              .OUTGOINGS_ModelListSearch[index];
                                          OUTGOING.text = cubit.OUTGOINGS_model!
                                              .OUTGOINGS_NAME!;
                                          print(cubit.OUTGOINGS_model!
                                              .OUTGOINGS_NAME!);
                                          print(cubit.OUTGOINGS_model!
                                              .OUTGOINGS_ID!);
                                          if (cubit.RTreasuryval == 1) {
                                            CUST.text = '';
                                            cubit.CUST_ModelSearch = null;
                                          }

                                          OUTGOINGSEARCH.text = '';
                                          cubit.OUTGOINGS_ModelListSearch = [];
                                          Navigator.pop(context);
                                        });
                                      },
                                      child: Text(
                                        cubit.OUTGOINGS_ModelListSearch[index]
                                            .OUTGOINGS_NAME.toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                    ),
                                separatorBuilder: (context, index) =>
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 50, vertical: 10),
                                      child: Container(
                                        height: 1,
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width * .2,
                                        color: defultcolor,
                                      ),
                                    ),
                                itemCount: cubit.OUTGOINGS_ModelListSearch
                                    .length),
                          ],
                        ),
                      ),
                    );
                  }
              ),
            );
          });

  Future openmessageAddSuccess(context) =>
      showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(
                content: Text(
                  'تم اضافه الملغ بنجاح', textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),

                ),
              ));

  Future openmessageSubSuccess(context) =>
      showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(
                content: Text(
                  'تم خصم الملغ بنجاح', textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),

                ),
              ));

}

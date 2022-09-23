import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/DataBase/getDB.dart';
import 'package:pos/cubit/cubit.dart';
import 'package:pos/cubit/states.dart';
import 'package:pos/models/CashInOut_Model.dart';
import 'package:pos/modules/InvoiceItems.dart';
import 'package:pos/modules/TreasuryOpen.dart';
import 'package:pos/shared/component.dart';
import 'package:pos/shared/style/colors.dart';
import '../DataBase/DataBase.dart';
import '../DataBase/getDB.dart';
import '../models/TREASURY_Model.dart';

class MoveTreasuryReport extends StatelessWidget {
  TextEditingController searchcontroller = TextEditingController();
  Color? colors;

  bool check = false;
  String date = DateTime.now().toString().split(' ')[0];

  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocConsumer<posCubit, posStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = posCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "تقرير بحركة الخزينه",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              // actions: [
              //   IconButton(onPressed: (){
              //     DateDialog(context: context,cubit: cubit);
              //   },
              //     icon: Icon(Icons.date_range_rounded ),)
              // ],
            ),
            body: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  textDirection: TextDirection.rtl,
                  children: [
                    Container(
                        width: (MediaQuery.of(context).size.width / 2) - 130,
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
                              menuMaxHeight: 180,
                              underline: Container(),
                              //TREASURY_Model> TREASURY_RAYMENT
                              items:
                                  TREASURY_ModelList.map((TREASURY_Model item) {
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
                              onChanged: (v) async {
                                cubit.changeDropdownBanks_TreasuryReport(
                                    v: v.toString());
                                await getCach_transDetails(
                                    database: database,
                                    TreasuryName: v.toString(),
                                    context: context,
                                    text: date);
                              },
                              value: cubit.valBanks_TreasuryReport
                                      .toString()
                                      .isNotEmpty
                                  ? cubit.valBanks_TreasuryReport
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * .8 - 30,
                        decoration: BoxDecoration(
                          color: TTF,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          onTap: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.parse('2000-12-31'),
                              lastDate: DateTime.now(),
                            ).then((value) {
                              print(' value Date  $value');
                              if(value != null) {
                                date = value.toString().split(' ')[0];
                                print(date);
                                cubit.getCashInOutSearch(
                                    date: date,
                                    TREASURYNme: cubit.valBanks_TreasuryReport);
                              }
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            // textDirection: TextDirection.RTL,
                            children: [
                              SizedBox(
                                width: 30,
                              ),
                              Icon(Icons.calendar_today_rounded),
                              Spacer(),
                              if (date == null)
                                Text(
                                  'اضغط لأختيار تاريج محدد',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              if (date != null)
                                Text(
                                  '${date}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: defultcolor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              Spacer(),
                            ],
                          ),
                        )),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  color: bar,
                  height: 60,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'ملاحظات',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Spacer(),
                      Text(
                        'التاريخ',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Container(
                        width: MediaQuery.of(context).size.width * .2,
                        child: Text(
                          'المتبقي بعد العمليه',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Spacer(),
                      Text(
                        'المبلغ',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Text(
                        'العمليه',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                    ],
                  ),
                ),
                BuildCondition(
                  condition: cubit.CashInOut_ModelListSearch.length > 0 || cubit.valBanks_TreasuryReport != '',
                  builder: (context) => Expanded(
                    child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        if (index % 2 == 0) {
                          colors = list;
                        } else {
                          colors = list2;
                        }
                        return recipts(colors, context,
                            cubit.CashInOut_ModelListSearch[index]);
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        height: 2,
                      ),
                      itemCount: cubit.CashInOut_ModelListSearch.length,
                    ),
                  ),
                  fallback: (context) => Expanded(
                      child: Center(
                          child:
                              Container(child: Text('اختر الخزنه')))),
                )
              ],
            ),
          );
        });
  }
}

Widget recipts(colors, context, CashInOut_Model CashInOutModel) {
  String ?TransType ;       // 'OUT'   'IN'
  if(CashInOutModel.TransType.toString() == 'OUT' || CashInOutModel.TransType.toString() == 'خصم' ) {
    TransType = 'خصم' ;
  }
  else {
    TransType = 'اضافة';
  }
  return Container(
    height: 79,
    color: colors,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
      child: InkWell(
        onTap: () {
          print(CashInOutModel.toJson());
          if (CashInOutModel.InvoiceId != null) {
            posCubit
                .get(context)
                .getInvoiceItems(InvoiceID: CashInOutModel.InvoiceId);
            NavigatorTo(context, InvoiceItems());
          } else {
            if (CashInOutModel.ExpenseId != null) {
              getCashInOut_ExpenseName(CashInOutModel.ExpenseId);
            }
            if (CashInOutModel.CustVenId != null) {
              getCashInOut_CustVenName(CashInOutModel.CustVenId);
            }
            NavigatorTo(
                context,
                TreasuryOpen(
                  CashInOutModel: CashInOutModel,
                ));
          }
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
//   textDirection: TextDirection.rtl,
          children: [
            SizedBox(
              width: 8,
            ),
            Container(
              width: MediaQuery.of(context).size.width * .12,
              child: Text(
                '${CashInOutModel.Remark ?? ''}',
                textAlign: TextAlign.center,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: defultblack,
                    fontSize: 11,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Spacer(),
            Container(
              width: MediaQuery.of(context).size.width * .17,
              child: Text(
                '${CashInOutModel.DocDate}',
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: defultblack,
                    fontSize: 11,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Spacer(),
            Container(
              width: MediaQuery.of(context).size.width * .16,
              child: Center(
                child: Text(
                  '${double.parse(CashInOutModel.AmountAfterOperation.toStringAsFixed(2))}',
                  maxLines: 2,
                  style: TextStyle(
                      color: defultblack,
                      fontSize: 11,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Spacer(),
            Container(
              width: MediaQuery.of(context).size.width * .17,
              decoration: BoxDecoration(
                color: TTF,
                borderRadius: BorderRadius.circular(12),
              ),
              clipBehavior: Clip.antiAlias,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 2.0, vertical: 4),
                child: Text(
                  '${CashInOutModel.Amount} جنيه',
                  textAlign: TextAlign.center,
//    textDirection: TextDirection.RTL,
                  style: TextStyle(
                      color: defultblack,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Spacer(),
            Container(
              width: 27,
              child: Text(
                '${TransType}',
                maxLines: 2,
                style: TextStyle(
                    color: defultblack,
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: 8,
            ),
          ],
        ),
      ),
    ),
  );
}

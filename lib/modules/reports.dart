import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/cubit/cubit.dart';
import 'package:pos/cubit/states.dart';
import 'package:pos/modules/remainingMClient.dart';
import 'package:pos/shared/component.dart';
import 'package:pos/shared/style/colors.dart';
import 'AnalysCustAccount.dart';
import 'DailyInvoicesReport.dart';
import 'Products_In_Stock.dart';
import 'TreasuryMoveReport.dart';

class reportsScreen extends StatelessWidget {
  var result;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<posCubit, posStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var Cubit = posCubit.get(context);
        return Scaffold(
        //  backgroundColor: Colors.grey[100],
          appBar: AppBar(
            title: Text(
              'الاستعلامات و التقارير',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
            actions: [
              MaterialButton(
                onPressed: () {},
                child: Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${DateTime.now().day} / ${DateTime.now().month} / ${DateTime.now().year}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Image(
                              image: AssetImage('images/الاستعلامات.png'),
                              height: 70,
                            ),
                          ),

                          // Text(
                          //   'تقارير مفصله',
                          //   style: TextStyle(
                          //       color: Colors.grey,
                          //       fontWeight: FontWeight.bold,
                          //       fontSize: 24),
                          // ),
                          SizedBox(
                            height: 10,
                          ),
                          reports(
                              text: ' عرض فواتير المبيعات ',
                              function: () {
                                Cubit.Search_InvoiceNo(InvoiceNo: '');
                                NavigatorTo(context, DailyInvoicesReport());
                              }),
                          SizedBox(
                            height: 12,
                          ),
                          reports(
                              text: 'تقرير بتعاملات الخزينه',
                              function: () {
                                // Cubit.getCashInOutSearch(
                                //     date: 00, TREASURYNme: '');
                                Cubit.valBanks_TreasuryReport = '';
                                Cubit.CashInOut_ModelListSearch =[] ;
                                NavigatorTo(context, MoveTreasuryReport());
                              }),
                          SizedBox(
                            height: 12,
                          ),
                          reports(
                              text: 'تقرير بحساب العميل النهائى',
                              function: () async {
                                NavigatorTo(
                                    context, remainingMClient());
                                //  NavigatorTo(context, remainingMClient());
                              }),
                          SizedBox(height: 12,),
                          reports(text: 'حساب العميل التحليلى',
                              function: (){
                                NavigatorTo(context, AnalysCustAccount());
                              }),
                          SizedBox(
                            height: 12,
                          ),
                          reports(
                              text: 'جرد البضاعه فى المخزن',
                              function: () {
                                Cubit.Stock_Details_ListSearch = [];
                                Cubit.valStock_Details = '';
                                NavigatorTo(context, Products_In_Stock());
                              }),
                          SizedBox(
                            height: 12,
                          ),
                          SizedBox(
                            height: 12,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget reports({required text, required function}) => InkWell(
      onTap: function,
      child: Stack(
        alignment: AlignmentDirectional.centerEnd,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: defultcolor, borderRadius: BorderRadius.circular(12)),
              width: double.infinity,
              height: 33,
              clipBehavior: Clip.antiAlias,
              child: Center(
                  child: Text(
                text,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 12),
              )),
            ),
          ),
          CircleAvatar(
            child: Icon(
              Icons.report,
            ),
            backgroundColor: defultcolor,radius: 20,
          )
        ],
      ),
    );

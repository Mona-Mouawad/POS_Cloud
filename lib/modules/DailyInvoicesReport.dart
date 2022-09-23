import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/cubit/cubit.dart';
import 'package:pos/cubit/states.dart';
import 'package:pos/models/INVOICE_Model.dart';
import 'package:pos/modules/InvoiceItems.dart';
import 'package:pos/shared/component.dart';
import 'package:pos/shared/style/colors.dart';

class DailyInvoicesReport extends StatelessWidget {
  TextEditingController searchcontroller = TextEditingController();
  Color? colors;

  bool check = false;

  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocConsumer<posCubit, posStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = posCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "تقرير الفواتير اليومية",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              // actions: [
              //   IconButton(onPressed: (){
              //     DateDialog(context: context,cubit: cubit);
              //   },
              //       icon: Icon(Icons.date_range_rounded ),)
              // ],
            ),
            body: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 10),
                   child: defultTextField(
                        context: context,
                          onchange: (v){
                            cubit.Search_InvoiceNo(InvoiceNo: v);
                          },
                          onsubmit: (v){},
                        hintText: 'رقم الفاتوره',
                        width: double.infinity,type: TextInputType.number
                      ),
                 ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  color: bar,
                  height: 75,
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Spacer(),
                      SizedBox(
                        width: 25,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'الاجمالي',
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'تاريخ البيع',
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Spacer(),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'رقم الفاتورة',
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'اسم العميل',
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                BuildCondition(
                  condition: cubit.MobPosInvoiceSearchList.length >0 ,
                  builder: (context) => Expanded(
                    child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        if (index % 2 == 0) {
                          colors = list;
                        } else {
                          colors =Colors.grey[200];
                        }
                        return Invoices(index, colors , context,cubit.MobPosInvoiceSearchList[index]);
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        height: 3,
                      ),
                      itemCount: cubit.MobPosInvoiceSearchList.length,
                    ),
                  ),
                  fallback: (context) => Expanded(
                      child: Center()),
                ),
                SizedBox(height: 20,)
              ],
            ),
            // floatingActionButton: Container(
            //   width: 100,
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(12),
            //       color: Colors.redAccent),
            //   clipBehavior: Clip.antiAlias,
            //   child: MaterialButton(
            //       child: Padding(
            //         padding:
            //             const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            //                               child: Text(
            //             'الاجمالي',
            //             maxLines: 2,
            //             style: TextStyle(
            //                 color: Colors.white,
            //                 fontWeight: FontWeight.bold,
            //                 fontSize: 16),
            //           ),
            //
            //       ),
            //       onPressed: () {}),
            // ),
          );
        });
  }
}

Widget Invoices(index, colors ,context, INVOICE_Model itemModel) =>
    Stack(alignment: AlignmentDirectional.topStart, children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: InkWell(onTap:() async {
        await  posCubit.get(context).getInvoiceItems(InvoiceID: itemModel.INVOICE_ID);
          NavigatorTo(context, InvoiceItems());
        } ,
          child: Container(
            height: 110,
            color: colors,
            child: Row(
              textDirection: TextDirection.rtl,
              children: [
                Spacer(),
                Container(
                  width: MediaQuery.of(context).size.width /3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          '${itemModel.VALUE}',
                          maxLines: 2,
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Center(
                        child: Text(
                          '${itemModel.INVOICE_DATE}',
                          maxLines: 1,
                          style: TextStyle(
                              color: defultcolor,
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  width: MediaQuery.of(context).size.width /3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${itemModel.InvoiceNo}',
                        maxLines: 2,
                        style: TextStyle(
                            color: defultcolor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        '${itemModel.Name}',textAlign: TextAlign.center,
                        maxLines: 2,overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.grey[900],
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
      if(itemModel.Discount! > 0.0)
         Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.red,
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                'خصم ${double.parse(itemModel.Discount!.toStringAsFixed(2))} جنيه',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  height: 1,
                  color: Colors.white,
                ),
              ),
            )),
      ),
    ]);

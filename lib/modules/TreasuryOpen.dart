import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/DataBase/getDB.dart';
import 'package:pos/cubit/cubit.dart';
import 'package:pos/cubit/states.dart';
import 'package:pos/shared/style/colors.dart';
import '../models/CashInOut_Model.dart';

class TreasuryOpen extends StatelessWidget{

  @override

  CashInOut_Model ? CashInOutModel ;
  TreasuryOpen({this.CashInOutModel});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double width= MediaQuery.of(context).size.width;

    return BlocConsumer<posCubit,posStates>(
        listener:(context,state){} ,
        builder: (context,state)
        {
          var cubit = posCubit.get(context);
        int ?  RTreasuryval ;
          if(CashInOutModel!.TransType == 'خصم' || CashInOutModel!.TransType =='OUT' ){ RTreasuryval =1 ;}
          if(CashInOutModel!.TransType == 'اضافة' || CashInOutModel!.TransType == 'IN' ){RTreasuryval = 2 ;}
          return Scaffold(
            backgroundColor: Colors.grey[100],
            appBar: AppBar(
              title: Text('حركة الخزينه',
                style:TextStyle(fontSize: 16,color: Colors.white) ,),
            ),
            body: SingleChildScrollView(
              child: Column(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      decoration: BoxDecoration(  borderRadius: BorderRadius.circular(12),
                        color: Colors.white,),
                      clipBehavior: Clip.antiAlias,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 5,),
                            Image(image: AssetImage('images/خزنه2.jpg'),height: 65,),
                            SizedBox(height: 10,),
                            Row(crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              textDirection: TextDirection.rtl,
                              children: [

                                Text('خصم من الخزينة', textAlign: TextAlign.center,
                                  style: TextStyle(color: defultblack,
                                      fontWeight: FontWeight.bold, fontSize: 12),),
                                Radio(value: 1, groupValue: RTreasuryval, onChanged: (v){
                                }),

                                Text('اضافه للخزينة', textAlign: TextAlign.center,
                                  style: TextStyle(color: defultblack,
                                      fontWeight: FontWeight.bold, fontSize: 12),),
                                Radio(value: 2, groupValue: RTreasuryval, onChanged: (v){
                                }),
                              ],),
                            SizedBox(height: 15,),
                            if(CashInOutModel!.PaymentMethodName != null )
                              Row(crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              textDirection: TextDirection.rtl,
                              children: [
                                Container(width: (MediaQuery
                                    .of(context)
                                    .size
                                    .width / 2) - 130,
                                    child: Text('طرق الدفع', textAlign: TextAlign.center,
                                      style: TextStyle(color: defultblack,
                                          fontWeight: FontWeight.bold, fontSize: 12),)),
                                SizedBox(width: 10,),
                                Expanded(
                                  child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        color: Colors.grey[200]),
                                    child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      textDirection: TextDirection.rtl,
                                      children: [
                                        SizedBox(width: 10,),
                                        SizedBox(width: 20,),
                                        Text(CashInOutModel!.PaymentMethodName.toString(),// textAlign: TextAlign.end,
                                          textDirection: TextDirection.ltr,
                                          style: TextStyle(color: defultcolor,
                                              fontWeight: FontWeight.bold, fontSize: 12),),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5,),
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
                                    child: Text('خزن/بنوك', textAlign: TextAlign.center,
                                      style: TextStyle(color: defultblack,
                                          fontWeight: FontWeight.bold, fontSize: 12),)),
                                SizedBox(width: 10,),
                                Expanded(
                                  child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        color: Colors.grey[200]),
                                    child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      textDirection: TextDirection.rtl,
                                      children: [
                                        SizedBox(width: 10,),
                                        SizedBox(width: 20,),
                                        Text(CashInOutModel!.TreasuryName.toString(),// textAlign: TextAlign.end,
                                          textDirection: TextDirection.ltr,
                                          style: TextStyle(color: defultcolor,
                                              fontWeight: FontWeight.bold, fontSize: 12),),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5,),
                              ],
                            ),
                            SizedBox(height: 15,),
                            if(CashInOutModel!.CustVenId != null )
                               Row(crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              textDirection: TextDirection.rtl,
                              children: [
                                Container(width: (MediaQuery
                                    .of(context)
                                    .size
                                    .width / 2) - 130,
                                    child: Text('العميل', textAlign: TextAlign.center,
                                      style: TextStyle(color: defultblack,
                                          fontWeight: FontWeight.bold, fontSize: 12),)),
                                Expanded(
                                  child: Container(//width: MediaQuery.of(context).size.width*.5 -45,height: 48,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(14),
                                          color: Colors.grey[200]),
                                      child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        textDirection: TextDirection.rtl,
                                        children: [
                                          SizedBox(width: 10,),
                                        //  Icon(Icons.arrow_drop_down ),
                                          SizedBox(width: 20,),
                                          Text(CustVenName.toString(),// textAlign: TextAlign.end,
                                            textDirection: TextDirection.ltr,
                                            style: TextStyle(color: defultcolor,
                                                fontWeight: FontWeight.bold, fontSize: 12),),
                                        ],
                                      ),
                                    ),

                                ),

                              ],
                            ),
                            SizedBox(height: 10,),
                            if(CashInOutModel!.ExpenseId != null )
                              Row(crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                textDirection: TextDirection.rtl,
                                children: [
                                  Container(width: (MediaQuery
                                      .of(context)
                                      .size
                                      .width / 2) - 130,
                                      child: Text('المصروفات', textAlign: TextAlign.center,
                                        style: TextStyle(color: defultblack,
                                            fontWeight: FontWeight.bold, fontSize: 12),)),
                                  SizedBox(width: 10,),
                                  Expanded(
                                    child: Container(
                                     // width: (width*0.7)- 50,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color:Colors.grey[200] ),
                                      clipBehavior: Clip.antiAlias,
                                      child:  Row(crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            textDirection: TextDirection.rtl,
                                            children: [
                                              SizedBox(width: 10,),
                                              SizedBox(width: 20,),
                                              Text( ExpenseName.toString(),// textAlign: TextAlign.end,
                                                textDirection: TextDirection.ltr,
                                                style: TextStyle(color: defultcolor,
                                                    fontWeight: FontWeight.bold, fontSize: 12),),
                                            ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5,),
                                ],
                              ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Spacer(),
                                Text('المبلغ',
                                  style: TextStyle(color: defultblack,
                                      fontWeight: FontWeight.bold, fontSize: 12, height: 1
                                  ),),
                                SizedBox(width: 10)
                              ],
                            ),
                            SizedBox(height: 2,),
                            Container(
                              // width: (width*0.7)- 50,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color:Colors.grey[200] ),
                              clipBehavior: Clip.antiAlias,
                              child:  Row(crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                textDirection: TextDirection.rtl,
                                children: [
                                  SizedBox(width: 10,),
                                  SizedBox(width: 20,),
                                  Text( CashInOutModel!.Amount.toString(),// textAlign: TextAlign.end,
                                    textDirection: TextDirection.ltr,
                                    style: TextStyle(color: defultcolor,
                                        fontWeight: FontWeight.bold, fontSize: 12),),
                                ],


                              ),
                            ),
                            SizedBox(height: 15,),
                            Row(
                              children: [
                                Spacer(),
                                Text('ملاحظات',
                                  style: TextStyle(color: defultblack,
                                      fontWeight: FontWeight.bold, fontSize: 12, height: 1
                                  ),),
                                SizedBox(width: 15)
                              ],
                            ),
                            SizedBox(height: 2,),
                            Row(crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              textDirection: TextDirection.rtl,
                              children: [
                                Container(
                                  width: (width*0.9) - 20,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color:Colors.grey[200] ),
                                  clipBehavior: Clip.antiAlias,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0 ,horizontal: 25),
                                      child: Text( CashInOutModel!.Remark?? '', textAlign: TextAlign.end,
                                 //   child: Text( ' kmjikmbghujhjb vbjkjhgfdxcvb liuytcvbnm, loiuyfcvbnm ' ,// textAlign: TextAlign.end,
                                      textDirection: TextDirection.ltr,
                                      style: TextStyle(color: defultcolor,
                                          fontWeight: FontWeight.bold, fontSize: 12),),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15,),
                            Row(textDirection: TextDirection.rtl,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 10,),
                                Container( width: (MediaQuery.of(context).size.width*0.5)- 80,
                                  child: Text('التاريخ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color:defultblack,
                                        fontWeight: FontWeight.bold, fontSize: 12, height: 1
                                    ),),
                                ),
                                Container(
                                  width: (width*0.5)- 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      gradient: LinearGradient(colors: buttonColor)),
                                  clipBehavior: Clip.antiAlias,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 5),
                                    child: Center(
                                    //  child: Text('${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
                                      child: Text('${CashInOutModel!.DocDate}',textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.white,
                                            fontWeight: FontWeight.bold, fontSize: 12
                                        ),),
                                    ),
                                  ),
                                ),
                              ],),
                            SizedBox(height: 10,),

                          ],
                        ),

                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                ],
              ),
            ),
          );
        });
  }



}

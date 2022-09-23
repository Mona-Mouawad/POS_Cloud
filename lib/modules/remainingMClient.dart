import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/cubit/cubit.dart';
import 'package:pos/cubit/states.dart';
import 'package:pos/shared/component.dart';
import 'package:pos/shared/style/colors.dart';
import '../models/FinalBalanceCustVen_Model.dart';
import '../shared/Content.dart';

class remainingMClient extends StatelessWidget {
  TextEditingController searchcontroller=TextEditingController();
  Color? colors ;
  var  result ;
  remainingMClient({this.result});
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocConsumer<posCubit, posStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = posCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text("حساب العميل النهائى",
                style: TextStyle(color: Colors.white,fontSize: 13,fontWeight: FontWeight.bold),
              ),
            ),
            body: Column(
              children: [
                SizedBox(height: 7,),
                // Row( textDirection: TextDirection.rtl,
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text('اجمالي المبلغ المتبقي عند العملاء : ',textDirection: TextDirection.rtl,
                //       style: TextStyle(color: defultblack,
                //         fontSize: 11,fontWeight: FontWeight.bold),),
                //     Text('${result}',textDirection: TextDirection.rtl,
                //       style: TextStyle(color: defultblack,
                //         fontSize: 13,fontWeight: FontWeight.bold),),
                //   ],
                // ),
                SizedBox(height: 7,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: defultTextField(
                    context: context,
                    controller: searchcontroller,
                    hintText: 'اسم العميل - كود العميل ',
                    hintcolor: Colors.grey,
                    prefix: Icons.search,
                    Texttcolor: defultcolor,
                    // ontap: (){ cubit.Search_CUST(CUSTNAME: searchcontroller.text);},
                    // onchange: (v){
                    //   cubit.Search_CUST(CUSTNAME: v);
                    // },
                    onsubmit: (v) async {
                      try{
                        print (int.parse(v).runtimeType);
                        await cubit.getFinalBalanceCustdata(LeId:LE_ID! ,CustId:  int.parse(v),context: context);
                      }
                      catch(error){
                        print (v.runtimeType);
                        await cubit.getFinalBalanceCustdata(LeId:LE_ID! , Name: v,context: context);
                      }
                      },),

                ),
                SizedBox(height: 20,),
                Container(color: bar, height: 50,
                  child: Row(textDirection: TextDirection.rtl,
                    children: [
                      Spacer(),
                      SizedBox(width: 25,),
                      Text('بيانات العميل',style: TextStyle(color: Colors.white,
                          fontSize: 12,fontWeight: FontWeight.bold),),
                      Spacer(),
                      SizedBox(width: 25,),
                      Text('الرصيد الحالى',style: TextStyle(color: Colors.white,
                          fontSize: 12,fontWeight: FontWeight.bold),),
                      Spacer(),
                      // Text('اقصى مديونيه',style: TextStyle(color: Colors.white,
                      //     fontSize: 12,fontWeight: FontWeight.bold),),
                      // SizedBox(width: 20,),
                    ],
                  ),),
                BuildCondition(
                  condition: State is ! loadingFinalBalance_CUSTState  ,
                  builder: (context)=> Expanded(
                    child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      itemBuilder:(context,index) {
                        if(index%2== 0) {colors =list;}
                        else {colors =list2;}
                        return Users(context,colors,cubit.FinalBalanceCust[index]);},
                      separatorBuilder:(context,index)=> SizedBox(height: 3,),
                      itemCount:cubit.FinalBalanceCust.length,
                    ) ,
                  ),
                  fallback: (context)=> Expanded(child: Center(child: CircularProgressIndicator())),

                ),
                if(State is ErrorFinalBalance_CUSTState)
                  Expanded(child: Center(child: Text('هذا العميل غير موجود',style: TextStyle(color: Colors.black),))),
              ],

          ),
          );
        });
  }

  Widget Users(context,colors ,FinalBalanceCustVen_Model CUST_Model)=>Container(
    height: 73,
    color: colors,
    child: Row(
      mainAxisAlignment:  MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center ,
      textDirection: TextDirection.rtl,
      children: [
        Spacer(),
        SizedBox(width: 10,),
        Container(
          width: MediaQuery.of(context).size.width *.4,
          child: Column(
            mainAxisAlignment:  MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center ,
            children: [
              Text('${CUST_Model.Name}',maxLines: 2, textAlign: TextAlign.center,
                style: TextStyle(color: defultblack,
                  fontSize: 12,fontWeight: FontWeight.bold),),
           // if(CUST_Model.CityName!=null)   Text('${CUST_Model.CityName}',maxLines: 2,style: TextStyle(color: defultblack,
           //        fontSize: 13,fontWeight: FontWeight.bold),),
            ],
          ),
        ),
        Spacer(),
        SizedBox(width: 20,),
        Container(
          decoration: BoxDecoration(
            color: TTF,
            borderRadius: BorderRadius.circular(12),),
          clipBehavior: Clip.antiAlias,

          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('${CUST_Model.Balance}',style: TextStyle(color: defultblack,
                fontSize: 12,fontWeight: FontWeight.bold),),
          ),
        ),
        Spacer(),
        // SizedBox(width: 15,),
        // Container(
        //   decoration: BoxDecoration(
        //     color: TTF,
        //     borderRadius: BorderRadius.circular(12),),
        //   clipBehavior: Clip.antiAlias,
        //
        //   child: Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: Text('${CUST_Model.MaxDebtLimt}',style: TextStyle(color: defultblack,
        //         fontSize: 12,fontWeight: FontWeight.bold),),
        //   ),
        // ),
        // Spacer(),
        // SizedBox(width: 15,),
      ],
    ),);
}

Future openmessageNOCustSuccess(context) => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Text(
        'هذا العميل غير موجود',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      ),
    ));

Future openmessageNetworkSuccess(context) => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Text(
        'تاكد من انك متصل بالانترنت',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
      ),
    ));




import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/cubit/cubit.dart';
import 'package:pos/cubit/states.dart';
import 'package:pos/shared/Content.dart';
import 'package:pos/shared/component.dart';
import 'package:pos/shared/style/colors.dart';
import '../DataBase/getDB.dart';
import '../models/AnalyticsCustAccount_Model.dart';

class AnalysCustAccount extends StatefulWidget {

  @override
  State<AnalysCustAccount> createState() => _AnalysCustAccountState();
}

class _AnalysCustAccountState extends State<AnalysCustAccount> {
  @override

  TextEditingController searchcontroller=TextEditingController();
  Color? colors =list2;
  String ?  textDate ;
  String ?  CUST ;


  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocConsumer<posCubit, posStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = posCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text("حساب العميل التحليلى",
                style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
              ),
            ),
            body: Column(
              children: [
                SizedBox(height: 7,),
                // Container(height: 50,
                //     width: MediaQuery.of(context).size.width*.9 -5,
                //     decoration: BoxDecoration(
                //       color: TTF,
                //       borderRadius:  BorderRadius.circular(10),),
                //     clipBehavior: Clip.antiAlias,
                //     child:InkWell(
                //       onTap: (){
                //         showDatePicker(context: context,
                //           initialDate: DateTime.now(),
                //           firstDate:  DateTime.parse('2017-12-31'),
                //           lastDate:DateTime.now(),
                //         ).then((value)
                //         {print (value);
                //         textDate = value.toString().split(' ')[0];
                //         print (textDate) ;
                //
                //         });
                //       },
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         // textDirection: TextDirection.RTL,
                //         children: [
                //           SizedBox(width: 30,),
                //           Icon(Icons.calendar_today_rounded ),
                //           Spacer(),
                //         if(textDate == null)  Text('اضغط لأختيار تاريج محدد', style:TextStyle(fontSize: 12,color: Colors.grey,fontWeight: FontWeight.bold ,),),
                //         if(textDate != null)  Text('${textDate}', style:TextStyle(fontSize: 12,color: Colors.grey,fontWeight: FontWeight.bold ,),),
                //           Spacer(),
                //         ],
                //       ),
                //     )
                // ),
                SizedBox(height: 7,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: defultTextField(
                    context: context,
                    controller: searchcontroller,
                    hintText: 'رقم الهاتف او اسم العميل',
                    hintcolor: Colors.grey,
                    prefix: Icons.search,
                    Texttcolor: defultcolor,
                    ontap: (){openCUST(context);},
                    onsubmit: (v) async {
                      try{
                        print (int.parse(v).runtimeType);
                        await cubit.getCustSuppBalancedata(LeId:LE_ID! ,CustId:  int.parse(v),context: context);
                      }
                      catch(error){
                        print (v.runtimeType);
                        await cubit.getCustSuppBalancedata(LeId:LE_ID! , Name:  v,context: context);
                      }

                      },),
                ),
                SizedBox(height: 20,),
                Container(color: bar, height: 50,
                  child: Row(textDirection: TextDirection.rtl,
                    children: [
                      SizedBox(width: 20,),
                      SizedBox(width: 25,),
                      Text('بيانات العميل',style: TextStyle(color: Colors.white,
                          fontSize: 11,fontWeight: FontWeight.bold),),
                      Spacer(),
                      SizedBox(width: 10,),
                      Text('التاريخ',style: TextStyle(color: Colors.white,
                          fontSize: 11,fontWeight: FontWeight.bold),),
                      Spacer(),
                      SizedBox(width: 10,),
                      Text('الرصيد',style: TextStyle(color: Colors.white,
                          fontSize: 11,fontWeight: FontWeight.bold),),
                      Spacer(),
                      SizedBox(width: 10,),
                      Text('ملاحظات',style: TextStyle(color: Colors.white,
                          fontSize: 11,fontWeight: FontWeight.bold),),
                      SizedBox(width: 20,),
                    ],
                  ),),
                BuildCondition(
                  condition:state is !loadingGetCustSuppBalanceState ,
                  builder: (context)=> Expanded(
                    child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      itemBuilder:(context,index) {
                        if(index%2== 0) {colors =list;}
                        else {colors =list2;}
                        return Users(colors,context,cubit.CustSupp_Reversed[index]);},
                      separatorBuilder:(context,index)=> SizedBox(height: 3,),
                      itemCount:cubit.CustSupp_Reversed.length,
                    ) ,
                  ),
                  fallback: (context)=> Expanded(child: Center(child: CircularProgressIndicator(),)),

                )
              ],
            ),
          );
        });
  }

  Widget Users(colors,context,AnalCustAccount_Model CUST_Model )=>Container(
    height: 110,
    color: colors,
    child: Row(
      textDirection: TextDirection.rtl,
      children: [
        SizedBox(width: 8,),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width:  MediaQuery.of(context).size.width*.2  ,
              child: Text('${CUST_Model.CustVenCode}',maxLines: 2,textAlign: TextAlign.center, style: TextStyle(color: defultblack,height: 1.1,
                  fontSize: 11,fontWeight: FontWeight.bold),),
            ),
            SizedBox(height: 5,),
            Container(width:  MediaQuery.of(context).size.width*.23  ,
              decoration: BoxDecoration(
                color: Colors.grey[400]!.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),),
              clipBehavior: Clip.antiAlias,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 3 ,horizontal: 9),
                child: Text('${CUST_Model.Name}',textAlign: TextAlign.center,maxLines: 3, overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: defultblack,
                    fontSize: 11,fontWeight: FontWeight.bold),),

              ),
            ),
          ],
        ),
        Spacer(),
        //SizedBox(width: 11,),
        Container(width:  MediaQuery.of(context).size.width*.21  ,
          decoration: BoxDecoration(
            color: Colors.grey[400]!.withOpacity(0.5),
            borderRadius: BorderRadius.circular(12),),
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 3 ,horizontal: 9),
            child: Text('${CUST_Model.DocDate} ',textAlign: TextAlign.center,style: TextStyle(color: defultblack,
                fontSize: 11,fontWeight: FontWeight.bold),),

          ),
        ),
     //   SizedBox(height: 8),
        Spacer(),
      //  SizedBox(width: 11,),
        Container(
          width:  MediaQuery.of(context).size.width*.2  ,
          child: Text('${double.parse(CUST_Model.Balance!.toStringAsFixed(2))}',maxLines: 2,textAlign: TextAlign.center, style: TextStyle(color: defultblack,height: 1.1,
              fontSize: 12,fontWeight: FontWeight.bold),),
        ),
        Spacer(),
    //    SizedBox(width: 11,),
        if(CUST_Model.DocTypeAr != null)
        Container(
          width:  MediaQuery.of(context).size.width*.2  ,
          decoration: BoxDecoration(
            color: Colors.grey[400]!.withOpacity(0.5),
            borderRadius: BorderRadius.circular(12),),
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 3 ,horizontal: 9),
            child: Text('${CUST_Model.DocTypeAr}',textAlign: TextAlign.center,maxLines: 4, overflow: TextOverflow.ellipsis,
              style: TextStyle(color: defultblack,
                fontSize: 11,fontWeight: FontWeight.bold),),

          ),
        ),
        if(CUST_Model.DocTypeAr == '')
          Container(
            width:  MediaQuery.of(context).size.width*.2  ,
            height: 3,
            decoration: BoxDecoration(
              color: Colors.grey[400]!.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),),
            clipBehavior: Clip.antiAlias,
          ),
        SizedBox(width: 8,),
      ],
    ),);

  Future openCUST(context)=>showDialog(
      context: context,
      builder: (context)
      { var cubit =posCubit.get(context);
      return   AlertDialog(
        // alignment: Alignment.centerRight,
        contentPadding: EdgeInsets.all(2),
        content: BlocConsumer<posCubit, posStates>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = posCubit.get(context);
              return Container(
            height: MediaQuery.of(context).size.height * .3,
            width: MediaQuery.of(context).size.width * .6,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: searchcontroller,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsetsDirectional.zero,
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onTap: () async {
                        setState(() {
                          cubit.Search_CUST(CUSTNAME:searchcontroller.text);
                       });
                      },
                      onChanged: (v) {
                        setState(() {
                          cubit.Search_CUST(CUSTNAME:v);
                        });
                      },
                    ),
                  ),

                  ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => InkWell(
                        onTap: () async {
                          setState(() {
                            Cust_Model = cubit
                                .CUST_ModelListSearch[index];
                            print (Cust_Model!.CUST_VEN_ID);
                            print (Cust_Model!.NAME);
                            CUST = Cust_Model!.NAME!
                                .toString();
                            searchcontroller.text = CUST.toString() ;
                            cubit.CUST_ModelListSearch=[];
                          });
                          await cubit.getCustSuppBalancedata(LeId:LE_ID! , Name: searchcontroller.text ,context: context);
                          Navigator.pop(context);
                        },
                        child: Text(
                          cubit.CUST_ModelListSearch[index].NAME.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      ),
                      separatorBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal:50, vertical: 10),
                        child: Container(
                          height: 1,
                          width: MediaQuery.of(context).size.width * .2,
                          color: defultcolor,
                        ),
                      ),
                      itemCount: cubit.CUST_ModelListSearch.length)
                ],
              ),

          ),
              );}
        ),

      );
      });


}





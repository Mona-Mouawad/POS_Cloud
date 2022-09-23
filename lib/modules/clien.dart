import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/DataBase/getDB.dart';
import 'package:pos/cubit/cubit.dart';
import 'package:pos/cubit/states.dart';
import 'package:pos/modules/layout.dart';
import 'package:pos/modules/registerscreen.dart';
import 'package:pos/modules/remainingMClient.dart';
import 'package:pos/modules/showCustomer.dart';
import 'package:pos/shared/component.dart';
import 'package:pos/shared/style/colors.dart';
import '../shared/Content.dart';
import 'AnalysCustAccount.dart';


class clienScreen extends StatefulWidget {

  @override
  State<clienScreen> createState() => _clienScreenState();
}

class _clienScreenState extends State<clienScreen> {
  @override

  TextEditingController CUSTSEARCH=TextEditingController();
  var result ;
  double ? value ;
  String NameCust = '';
  int ? CustID ;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<posCubit,posStates>(
      listener: (context,state){},
      builder: (context,state){
        var Cubit =posCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(onPressed: (){
              NavigatorAndFinish(context , LayoutScreen());},
                icon: Icon(Icons.arrow_back_ios)),
            title: Text('العملاء',
              style:TextStyle(fontSize: 30,color: Colors.white) ,),
            actions: [],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12)),
              clipBehavior: Clip.antiAlias,
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: SingleChildScrollView(
                  child: Column(
                    //mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(image: AssetImage('images/العملاء.png'),
                        height: 80, ),
                      SizedBox(height: 30,),
                      reports(text: ' اضافه عميل جديد ',
                          function: (){
                        NavigatorTo(context, register_screen());
                          }),
                      SizedBox(height: 12,),
                      reports(text: ' عرض العملاء الحالين ',
                          function: (){
                            Cubit.Search_CUST(CUSTNAME: '');
                            NavigatorTo(context, showCustomer());
                          }),
                      SizedBox(height: 15,),
                    reports(text: 'تقرير بحساب العميل النهائى',
                          function: () async {
                            await Cubit.getFinalBalanceCustdata(LeId:LE_ID! , Name: '',context: context);
                            NavigatorTo(context, remainingMClient());
                          }),

                      // SizedBox(height: 15,),
                      // reports(text: 'حذف عميل حالى',
                      //     function: (){
                      //       DeleteCustomer(context: context,cubit: Cubit,textItem:'u',
                      //          onchange:(v){Cubit.changeDropdownDeletUser(v.toString());}  ,
                      //           ontap: () async {
                      //             await Cubit.deletePOS_CUST_VEN(ID: CustID);
                      //             NameCust = ''  ;
                      //        Navigator.pop(context);
                      //           }
                      //       );
                      //     }),
                      SizedBox(height: 15,),
                      reports(text: 'حساب العميل التحليلى',
                          function: (){
                            Cubit.CustSupp_Reversed=[];
                             NavigatorTo(context, AnalysCustAccount());
                          }),
                      SizedBox(height: 15,),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future DeleteCustomer({context,cubit, ontap ,
    required onchange , required textItem})=>showDialog(
      context: context,
      builder: (context)=>AlertDialog(backgroundColor: defultwhite ,
        content:   Column(mainAxisSize: MainAxisSize.min,
          children: [
            Text('حذف',style: TextStyle(color: defultblack),),
            SizedBox(height: 30,),
            Text('رجاع اختيار اسم',style: TextStyle(color: defultblack),),
            InkWell(onTap: ()
            {openCUST(context);},
              child: Container(//width: MediaQuery.of(context).size.width*.5 -45,height: 48,
                height: 45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.grey[200]),
                child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  textDirection: TextDirection.rtl,
                  children: [
                    SizedBox(width: 10,),
                    Icon(Icons.arrow_drop_down ),
                    SizedBox(width: 20,),
                      Text( NameCust.toString(),// textAlign: TextAlign.end,
                      textDirection: TextDirection.ltr,
                      style: TextStyle(color: defultcolor,
                          fontWeight: FontWeight.bold, fontSize: 14),),
                  ],
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 3),
            //   child: Container(width:double.infinity,
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(12),
            //         color: Colors.grey[200]),
            //     child: Row(crossAxisAlignment: CrossAxisAlignment.center,
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       textDirection: TextDirection.rtl,
            //       children: [
            //         SingleChildScrollView(
            //           child: DropdownButton<String>(
            //               menuMaxHeight: MediaQuery.of(context).size.height *.5,
            //               items:items.map((String item) {
            //                 return DropdownMenuItem<String>
            //                   (value: item,
            //                   alignment: AlignmentDirectional.centerEnd,
            //                   child: Text(item, textAlign: TextAlign.center,
            //                     textDirection: TextDirection.rtl,
            //                     style: TextStyle(color: defultcolor,
            //                         fontWeight: FontWeight.bold, fontSize: 14),),
            //                 );}).toList(),
            //               onChanged: onchange
            //
            //             // value: cubit.valDeletUser,
            //           ),
            //         ),
            //         if(textItem== 'c') Text(cubit.valDeletCasher,// textAlign: TextAlign.end,
            //           textDirection: TextDirection.ltr,
            //           style: TextStyle(color: defultcolor,
            //               fontWeight: FontWeight.bold, fontSize: 14),),
            //         if(textItem== 'u') Text(cubit.valDeletUser,// textAlign: TextAlign.end,
            //           textDirection: TextDirection.ltr,
            //           style: TextStyle(color: defultcolor,
            //               fontWeight: FontWeight.bold, fontSize: 14),),
            //         if(textItem== 's') Text(cubit.valDeletSupplier,// textAlign: TextAlign.end,
            //           textDirection: TextDirection.ltr,
            //           style: TextStyle(color: defultcolor,
            //               fontWeight: FontWeight.bold, fontSize: 14),),
            //
            //       ],
            //     ),
            //   ),
            // ),
            // Text(textItem.toString(),// textAlign: TextAlign.end,
            //   textDirection: TextDirection.ltr,
            //   style: TextStyle(color: defultcolor,
            //       fontWeight: FontWeight.bold, fontSize: 14),),
            //   ],
            // ),
            SizedBox(height: 30,),
            Row(
              textDirection: TextDirection.rtl,
              children: [
                defultButton(text: 'حذف', ontap: ontap,
                  width: MediaQuery.of(context).size.width*0.3+30,),
                SizedBox(width: 15,),
                defultButton(text: 'الغاء', ontap: (){
                  Navigator.pop(context);
                }, width: MediaQuery.of(context).size.width*0.3 -30,),
              ],
            )
          ],
        ),
      ) );

  Future openCUST(context)=>showDialog(
      context: context,
      builder: (context)
      { var cubit =posCubit.get(context);
      return   AlertDialog(
        // alignment: Alignment.centerRight,
        contentPadding: EdgeInsets.all(2),
        content: Container(
          height: MediaQuery.of(context).size.height * .3,
          width: MediaQuery.of(context).size.width * .6,
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
                      cubit.Search_CUST(CUSTNAME:CUSTSEARCH.text);
                    });
                  },
                  onChanged: (v) {
                    setState(() {
                      cubit.Search_CUST(CUSTNAME:v);
                    });
                  },
                ),
              ),
              Container( height: MediaQuery.of(context).size.height * .3 -90,
                child: ListView.separated(
                  //  shrinkWrap: true,
                    physics:ScrollPhysics(),
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        setState(() {
                          Cust_Model = cubit
                              .CUST_ModelListSearch[index];
                          NameCust = Cust_Model!.NAME! ;
                          CustID = Cust_Model!.CUST_VEN_ID! ;
                          print (Cust_Model!.CUST_VEN_ID);
                          print (Cust_Model!.NAME);
                          CUSTSEARCH.text = '';
                          cubit.CUST_ModelListSearch=[];
                          Navigator.pop(context);
                        });
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
                    itemCount: cubit.CUST_ModelListSearch.length),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      );
      });

}

Widget reports({required text,required function})=> InkWell(
  onTap: function,
  child:Stack(
    alignment: AlignmentDirectional.centerEnd,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color: defultcolor,
              borderRadius: BorderRadius.circular(12)),
          width: double.infinity,
          height: 33,
          clipBehavior: Clip.antiAlias,
          child: Center(child: Text(text,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 12),)),
        ),
      ),
      CircleAvatar(child: Icon(Icons.report,),backgroundColor: defultcolor,radius: 20,)
    ],
  ),
);
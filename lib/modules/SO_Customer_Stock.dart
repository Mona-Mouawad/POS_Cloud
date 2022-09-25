import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/DataBase/getDB.dart';
import 'package:pos/cubit/cubit.dart';
import 'package:pos/cubit/states.dart';
import 'package:pos/modules/layout.dart';
import 'package:pos/modules/registerscreen.dart';
import 'package:pos/shared/component.dart';
import 'package:pos/shared/style/colors.dart';
import '../models/SalesOrder.dart';
import '../shared/Content.dart';


class SO_Customer_Stock extends StatefulWidget {

  @override
  State<SO_Customer_Stock> createState() => _SO_Customer_StockState();
}

class _SO_Customer_StockState extends State<SO_Customer_Stock> {
  @override
//  STOCK_Model ? _STOCK_Model;
  TextEditingController CUST=TextEditingController();
  TextEditingController CUSTSEARCH=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<posCubit,posStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit=posCubit.get(context);
        return  Scaffold(
          appBar: AppBar(
           leading: IconButton(onPressed: (){
             cubit.valStock = '' ;
             NavigatorAndFinish(context , LayoutScreen());},
               icon: Icon(Icons.arrow_back_ios,color: defultwhite,)),
            title: Text('تسجيل أمر بيع لحساب عميل',maxLines: 2,
              style: TextStyle(fontSize: 16,
                  color: defultwhite),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                //SizedBox(height: 30,),
                Spacer(),
                Row(textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text('تسجيل أمر بيع لحساب عميل جديد', maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black,
                            fontWeight: FontWeight.bold, fontSize: 12, height: 1
                        ),),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          NavigatorTo(context, register_screen(Invoice:  true,));
                        },
                        child: defultButton(text: 'عميل جديد',height: 45 ,ontap:()=> NavigatorTo(context, register_screen(Invoice:  true,))
                        ),
                      ),
                    ),
                  ],),
                SizedBox(height: 20,),
                Text('اسم العميل'.toUpperCase(),
                  style: TextStyle(fontSize: 12,
                      color: Colors.black54,fontWeight:FontWeight.bold,height: 1
                  ),
                ),
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
                        if(Cust_Model != null )
                          Text( Cust_Model!.NAME.toString(),// textAlign: TextAlign.end,
                            textDirection: TextDirection.ltr,
                            style: TextStyle(color: defultcolor,
                                fontWeight: FontWeight.bold, fontSize: 12),),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                Text('المخزن'.toUpperCase(),
                  style: TextStyle(fontSize: 12,
                      color: Colors.black54,fontWeight:FontWeight.bold,height: 1.1
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(width:double.infinity, alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.grey[200]),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    textDirection: TextDirection.rtl,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      DropdownButton<String>(
                        menuMaxHeight: 120, // value: '',//cubit.valStock,
                        items:STOCK_ModelName.map<DropdownMenuItem<String>>((String item) {
                          return DropdownMenuItem<String>
                            (value: item,
                            alignment: AlignmentDirectional.centerEnd,
                            child: Text(item, textAlign: TextAlign.center,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(color:defultcolor,
                                  fontWeight: FontWeight.bold, fontSize: 14),),
                          );}).toList(),
                        onChanged: (v) {
                          cubit.changevalStockDropdown(v.toString());
                        },elevation: 0,borderRadius: BorderRadius.circular(20),underline: Container(),
                        //  itemHeight:48,
                        value: cubit.valStock.toString().isNotEmpty ? cubit.valStock : null,
                      ),
                      // Text(cubit.valStock.toString(),// textAlign: TextAlign.end,
                      //   textDirection: TextDirection.ltr,
                      //   style: TextStyle(color: defultcolor,
                      //       fontWeight: FontWeight.bold, fontSize: 12),),
                      Spacer(),
                    ],
                  ),
                ),
                Spacer(flex: 1),
                defultButton(text: 'الذهاب الي الاصناف',
                    ontap: (){
                      if(cubit.valStock != '' && Cust_Model!.NAME != null)
                      {
                        Cache.play('m.mp3',mode: PlayerMode.LOW_LATENCY) ;
                        print(Cust_Model!.CUST_VEN_ID);
                        print(cubit.V_STOCKID );
                        NavigatorTo(context, SalesOrders());
                      }
                    }
                ),

                Spacer(flex: 2),


              ],
            ),
          ),

        );

      },

    );
  }

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

                ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        setState(() {
                          Cust_Model = cubit
                              .CUST_ModelListSearch[index];
                          print (Cust_Model!.CUST_VEN_ID);
                          print (Cust_Model!.NAME);
                          CUST.text = Cust_Model!.NAME!
                              .toString();
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
                    itemCount: cubit.CUST_ModelListSearch.length)
              ],
            ),
          ),
        ),
      );
      });

}
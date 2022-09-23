import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/cubit/cubit.dart';
import 'package:pos/cubit/states.dart';
import 'package:pos/modules/Products_In_Stock.dart';
import 'package:pos/modules/Products_Sold_Out_Soon.dart';
import 'package:pos/shared/component.dart';
import 'package:pos/shared/style/colors.dart';


class Stock extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<posCubit,posStates>(
      listener: (context,state){},
      builder: (context,state){
        var Cubit =posCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('المخزن',
              style:TextStyle(fontSize: 22,color: Colors.white) ,),
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
                padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 0),
                child: Column(
                  //mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(flex: 1),
                    Image(image: AssetImage('images/المخزن.png'),height: 130,),
                  //  SizedBox(height: 10,),
                    // reports(text: 'اضافه منتج جديد',
                    //     function: (){
                    //   NavigatorTo(context, AddProduct());
                    //     }),
                  //  SizedBox(height: 15,),
                    Spacer(flex: 2),
                    reports(text: 'عرض المنتجات',
                        function: (){
                          Cubit.valStock_Details ='' ;
                          Cubit.Stock_Details_ListSearch=[];
                          NavigatorTo(context, Products_In_Stock());
                        }),
                    SizedBox(height: 12,),
                    reports(text: 'جرد المخزن بالكمية',
                        function: (){
                          Cubit.valStock_Details ='' ;
                          Cubit.Stock_Details_ListSearch=[];
                          NavigatorTo(context, Products_Sold_Out_Soon());
                        }),
                    // SizedBox(height: 15,),
                    // reports(text: 'جرد المنتجات',
                    //     function: (){
                    //       Cubit.valStock_Details='' ;
                    //       Cubit.Stock_Details_ListSearch=[];
                    //       NavigatorTo(context, ProductsInventory());
                    //     }),
                   // SizedBox(height: 15,),
                    // reports(text: 'اضافة تصنيف جديد',
                    //     function: (){
                    //       NavigatorTo(context, AddCategories());
                    //     }),
                  //  SizedBox(height: 15,),
                    Spacer(flex: 6),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
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
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/cubit/cubit.dart';
import 'package:pos/cubit/states.dart';
import 'package:pos/models/ITEM_Model.dart';
import 'package:pos/models/InvoiceItemModel.dart';
import 'package:pos/shared/style/colors.dart';

class InvoiceItems extends StatelessWidget {


  ITEM_Model? ITEMmodel;
  Color? colors;
  bool? cond = true;


  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocConsumer<posCubit, posStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = posCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              // leading: IconButton(icon:Icon (Icons.arrow_back_ios) ,onPressed: (){
              //   NavigatorAndFinish(context, LayoutScreen());
              // }),
              title: Text(
                "فاتورة بيع",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            body: Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                Container(
                  color: bar,
                  height: 40,
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      // SizedBox(
                      //   width: 10,
                      // ),
                      // Text(
                      //   'صوره المنتج',
                      //   style: TextStyle(
                      //       color: Colors.white,
                      //       fontSize: 10,
                      //       fontWeight: FontWeight.bold),
                      // ),
                      // SizedBox(width: 15,),
                      Container(
                        width: MediaQuery.of(context).size.width *.4,
                        child: Center(
                          child: Text(
                            'المنتج',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Spacer(),
                      Text(
                        'السعر',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                     Spacer(),
                      Text(
                        'الكميه',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                     Spacer(),
                      Text(
                        'الاجمالي',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: BuildCondition(
                    condition: cubit.InvoiceItemsList.length > 0,
                    builder: (context) => ListView.separated(
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        if (index % 2 == 0) {
                          colors =list;
                        } else {
                          colors = list2 ;
                        }
                        return Items(
                            colors: colors,
                            context: context,
                            cubit: cubit,
                            ITEMmodel: cubit.InvoiceItemsList[index]);
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        height: 3,
                      ),
                      itemCount: cubit.InvoiceItemsList.length,
                    ),
                    fallback: (context) => Container(),
                  ),
                ),

              ],
            ),
          );
        });
  }


  Widget Items({colors, context, cubit, InvoiceItemModel? ITEMmodel}) =>
      Container(
        height: 75,
        color: colors,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          textDirection: TextDirection.rtl,
          children: [
            // SizedBox(
            //   width: 10,
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 5),
            //   child: Stack(
            //     alignment: Alignment.center,
            //     children: [
            //       CircleAvatar(
            //         radius: 28,
            //         backgroundColor: Colors.black,
            //       ),
            //       CircleAvatar(
            //         radius: 26,
            //         backgroundImage: AssetImage('images/images.png'),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(
              width: 10,
            ),
            Expanded(
             // width: MediaQuery.of(context).size.width*.4,
              child: Text(
                ITEMmodel!.ITEM_NAME!,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: defultcolor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              width: 55,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              clipBehavior: Clip.antiAlias,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  ITEMmodel.Price!.toString(),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                      color: defultcolor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Container(
              width: 50,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              clipBehavior: Clip.antiAlias,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                     "${ITEMmodel.UomQuantity ?? '0'} x  ${ITEMmodel.StandConvFactor}",textAlign: TextAlign.center, //textDirection: TextDirection.rtl,
                     // '1000',
                      maxLines: 2,
                      style: TextStyle(
                          color: defultcolor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    // Text(
                    //   "${ITEMmodel.UomName}",textAlign: TextAlign.center,
                    //   // '1000',
                    //   maxLines: 2,
                    //   style: TextStyle(
                    //       color: defultcolor,
                    //       fontSize: 12,
                    //       fontWeight: FontWeight.bold),
                    // ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width *.17 ,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              clipBehavior: Clip.antiAlias,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 2),
                child: Text(
                  '${ITEMmodel.TOTAL}',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                      color: defultcolor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
          ],
        ),
      );

}

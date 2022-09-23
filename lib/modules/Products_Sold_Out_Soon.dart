import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/DataBase/getDB.dart';
import 'package:pos/cubit/cubit.dart';
import 'package:pos/cubit/states.dart';
import 'package:pos/models/Stock_Details_Model.dart';
import 'package:pos/shared/component.dart';
import 'package:pos/shared/style/colors.dart';

import '../DataBase/DataBase.dart';

class Products_Sold_Out_Soon extends StatefulWidget{

  @override
  State<StatefulWidget> createState() =>_Products_Sold_Out_Soon();
}
class _Products_Sold_Out_Soon extends State<Products_Sold_Out_Soon>
{
  TextEditingController searchcontroller = TextEditingController();
  TextEditingController Stockcontroller = TextEditingController();
  Color? colors;
  bool ? cond =true;

  Widget build(BuildContext context) {

    // TODO: implement build
    return BlocConsumer<posCubit, posStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = posCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "منتجات تنفذ قريبا من المخزن",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),maxLines: 2,textAlign: TextAlign.center,overflow: TextOverflow.ellipsis,
              ),
            ),
            body: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(width:MediaQuery.of(context).size.width*.6+22,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.grey[200]),
                      child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        textDirection: TextDirection.rtl,
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          DropdownButton<String>(
                            menuMaxHeight: 120, underline: Container(),// value: '',//cubit.valStock_Details,
                            items:STOCK_ModelName.map<DropdownMenuItem<String>>((String item) {
                              return DropdownMenuItem<String>
                                (value: item,
                                alignment: AlignmentDirectional.centerEnd,
                                child: Text(item, textAlign: TextAlign.center,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(color: defultcolor,
                                      fontWeight: FontWeight.bold, fontSize: 12),),
                              );}).toList(),
                            onChanged: (v) async {
                              await  getStock_Details(database: database , StockName: v.toString(),context: context);
                             // cubit.changevalStock_DetailsDropdown(v.toString());
                            },
                            itemHeight:48,
                            value: cubit.valStock_Details.toString().isNotEmpty ? cubit.valStock_Details : null,                          ),
                          // Text(cubit.valStock_Details.toString(),// textAlign: TextAlign.end,
                          //   textDirection: TextDirection.ltr,
                          //   style: TextStyle(color: defultcolor,
                          //       fontWeight: FontWeight.bold, fontSize: 14),),
                          // Spacer(),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: defultTextField(
                    height: 48,
                    context: context,
                    controller: searchcontroller,
                    hintText: 'ابحث عن المنتج ',
                    hintcolor: Colors.grey,
                    prefix: Icons.search,
                    Texttcolor: defultcolor,
                    onchange: (v) {
                      cubit.Search_ItemsInStock(StockName: cubit.valStock_Details ,Name: v);
                    },
                    onsubmit: (v) {},
                    width: MediaQuery.of(context).size.width -130,
                    ontap: (){},
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  color: bar,
                  height: 35,
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      SizedBox(
                        width: 10,
                      ),

                      Expanded(
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
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Text(
                          'الكميه',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ),
                BuildCondition(
                  condition: cubit.Stock_Details_ListSearch.length >0,
                  builder: (context) => Expanded(
                    child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        if (index % 2 == 0) {
                          colors = list;
                        } else {
                          colors = list2;
                        }
                        return Items(colors,context,cubit,cubit.Stock_Details_ListSearch[index]);
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        height: 3,
                      ),
                      itemCount: cubit.Stock_Details_ListSearch.length,
                    ),
                  ),
                  fallback: (context) => Expanded(
                    child: Center(
                      child: Text('ابحث عن اسم المخزن'.toUpperCase(),
                        style: TextStyle(
                            color: Colors.grey,fontWeight:FontWeight.bold,fontSize: 17
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

          );
        });
  }

  Widget Items(colors,context,cubit,Stock_Details_Model ITEM_Model) => Container(
    //height: 75,
    color: colors,
    child: InkWell(onTap: (){},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          textDirection: TextDirection.rtl,
          children: [
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                '${ITEM_Model.ItemName}',
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: defultblack, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Padding(
                padding:
                const EdgeInsets.all(4.0),
                child: Center(
                  child: Text(
                    '${double.parse(ITEM_Model.Quantity.toString()).roundToDouble()}',textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(
                        color: defultblack,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),

            SizedBox(
              width: 15,

            ),
          ],
        ),
      ),
    ),
  );

}






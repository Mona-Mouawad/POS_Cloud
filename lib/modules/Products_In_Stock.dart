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

class Products_In_Stock extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Products_In_Stock();
}

class _Products_In_Stock extends State<Products_In_Stock> {
  TextEditingController searchcontroller = TextEditingController();
  TextEditingController Stockcontroller = TextEditingController();
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
              title: Text(
                "المنتجات المتوفرة فى المخزن",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              // actions: [
              //   IconButton(
              //     onPressed: () {
              //       DateDialog(context: context, cubit: cubit);
              //     },
              //     icon: Icon(Icons.date_range_rounded),
              //   )
              // ],
            ),
            body: Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                Text(
                  '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: defultblack,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                ),
                SizedBox(
                  height: 12,
                ),
                // Row(
                //   mainAxisSize: MainAxisSize.min,
                //   children: [
                //
                //     Container(width:MediaQuery.of(context).size.width*.6+22,
                //       decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(16),
                //           color: Colors.grey[200]),
                //       child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         textDirection: TextDirection.rtl,
                //         children: [
                //           SizedBox(
                //             width: 20,
                //           ),
                //           DropdownButton<String>(
                //             menuMaxHeight: 120, // value: '',//cubit.valStock_Details,
                //             items:STOCK_ModelName.map<DropdownMenuItem<String>>((String item) {
                //               return DropdownMenuItem<String>
                //                 (value: item,
                //                 alignment: AlignmentDirectional.centerEnd,
                //                 child: Text(item, textAlign: TextAlign.center,
                //                   textDirection: TextDirection.rtl,
                //                   style: TextStyle(color: defultcolor,
                //                       fontWeight: FontWeight.bold, fontSize: 15),),
                //               );}).toList(),
                //             onChanged: (v) {
                //               cubit.changevalStock_DetailsDropdown(v.toString());
                //             },
                //             itemHeight:48,
                //          value: cubit.valStock_Details.toString().isNotEmpty ? cubit.valStock_Details : null,
                //           ),
                //           // Text(cubit.valStock_Details.toString(),// textAlign: TextAlign.end,
                //           //   textDirection: TextDirection.ltr,
                //           //   style: TextStyle(color: defultcolor,
                //           //       fontWeight: FontWeight.bold, fontSize: 12),),
                //           // Spacer(),
                //         ],
                //       ),
                //     ),
                //     SizedBox(
                //       width: 24,
                //     ),
                //      Text('المخزن'.toUpperCase(),
                //       style: TextStyle(
                //           color: defultblack,fontWeight:FontWeight.bold,fontSize: 17
                //       ),
                //     ),
                //     SizedBox(
                //       width: 10,
                //     ),
                //   ],
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                // Row(
                //   mainAxisSize: MainAxisSize.min,
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.only(left: 15.0),
                //       child: defultTextField(
                //         height: 48,
                //         context: context,
                //         controller: searchcontroller,
                //         hintText: 'ابحث عن المنتج ',
                //         hintcolor: Colors.grey,
                //         prefix: Icons.search,
                //         Texttcolor: defultcolor,
                //         onchange: (v) {
                //           cubit.Search_ItemsInStock(StockName: cubit.valStock_Details ,Name: v);
                //         },
                //         onsubmit: (v) {
                //           cubit.Search_ItemsInStock(StockName: cubit.valStock_Details ,Name: v);
                //         },
                //         width: MediaQuery.of(context).size.width - 130,
                //         ontap: () {},
                //       ),
                //     ),
                //     MaterialButton(
                //         onPressed: () => Scan(),
                //         child: Image(
                //           image: AssetImage('images/barcode.jpg'),
                //           height: 48,
                //           width: 60,
                //         ))
                //   ],
                // ),
                // SizedBox(
                //   height: 12,
                // ),
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
                            menuMaxHeight: 120, // value: '',//cubit.valStock_Details,
                            items:STOCK_ModelName.map<DropdownMenuItem<String>>((String item) {
                              return DropdownMenuItem<String>
                                (value: item,
                                alignment: AlignmentDirectional.centerEnd,
                                child: Text(item, textAlign: TextAlign.center,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(color: defultcolor,
                                      fontWeight: FontWeight.bold, fontSize: 13),),
                              );}).toList(),
                            onChanged: (v) async {
                              await  getStock_Details(database: database , StockName: v.toString(),context: context);
                             // cubit.changevalStock_DetailsDropdown(v.toString());
                            },
                            itemHeight:48,underline: Container(),
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
                      Container(width: MediaQuery.of(context).size.width *.3 ,
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
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'الكميه',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      ),

                      Container( width: MediaQuery.of(context).size.width*0.2 ,
                        child: Center(
                          child: Text(
                            'الاجمالي',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                    ],
                  ),
                ),
                BuildCondition(
                    condition: cubit.Stock_Details_ListSearch.length > 0,
                    builder: (context) => Expanded(
                          child: ListView.separated(
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              if (index % 2 == 0) {
                                colors = list;
                              } else {
                                colors = list2;

                              }
                              return recipts(colors, context, cubit,
                                  cubit.Stock_Details_ListSearch[index]);
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
                              color: Colors.black54,fontWeight:FontWeight.bold,fontSize: 13
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          );
        });
  }

  Widget recipts(colors, context, cubit, Stock_Details_Model ITEM_Model) {
    double result =( ITEM_Model.SalesPrice1 ) * (ITEM_Model.Quantity);
    return Container(
      height: 75,
      color: colors,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        textDirection: TextDirection.rtl,
        children: [
          SizedBox(
            width: 10,
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 5),
          //   child: Stack(
          //     alignment: Alignment.center,
          //     children: [
          //       CircleAvatar(
          //         radius: 20,
          //         backgroundColor: Colors.black,
          //       ),
          //       CircleAvatar(
          //         radius: 18,
          //         backgroundImage: AssetImage('images/images.png'),
          //       ),
          //     ],
          //   ),
          // ),
          // SizedBox(
          //   width: 5,
          // ),
          Container(width: MediaQuery.of(context).size.width *.3 ,
            child: Text(
              '${ITEM_Model.ItemName}',
             // 'gggggggggggggg ggggggggggb hhhhhh jjjjjjj ggggggg',
              textDirection: TextDirection.rtl, overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,maxLines: 4,
              style: TextStyle(
                  color: defultblack,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Spacer(),
          SizedBox(
            width: 8,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 9),
              child: Text(
                '${ITEM_Model.SalesPrice1}',
                maxLines: 2,
                style: TextStyle(
                    color: defultcolor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 9),
              child: Text(
                '${double.parse(ITEM_Model.Quantity.toStringAsFixed(1))}',
                maxLines: 2,
                style: TextStyle(
                    color: defultcolor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width*0.22 ,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
              child: Text(
                '${double.parse(result.toStringAsFixed(2))}',textAlign: TextAlign.center,   //double.parse(itemModel.Discount!.toStringAsFixed(2))
                maxLines: 2,
                style: TextStyle(
                    color: defultcolor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            width: 12,
          ),
        ],
      ),
    );
  }

}

import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/DataBase/getDB.dart';
import 'package:pos/cubit/cubit.dart';
import 'package:pos/cubit/states.dart';
import 'package:pos/models/InvoiceItemModel.dart';
import 'package:pos/shared/style/colors.dart';

class CategoriesScreen extends StatelessWidget {
   @override
  Widget build(BuildContext context) {
    return BlocConsumer<posCubit, posStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = posCubit.get(context);
        return Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: Padding(
                padding: const EdgeInsets.only(
                    right: 1, left: 15, top: 5, bottom: 5),
                child: MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: Colors.redAccent,
                    height: 50,
                    child: Center(
                        child: Text('X',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)))),
              ),
              actions: [
                Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    SizedBox(width: 10),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      textDirection: TextDirection.rtl,
                      children: [
                        Text(
                          'اسم التصنيف  ',
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 10),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 100,
                          height: 30,
                          decoration: BoxDecoration(
                              color: TTF,
                              borderRadius: BorderRadius.circular(8)),
                          clipBehavior: Clip.antiAlias,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            textDirection: TextDirection.rtl,
                            children: [
                              SizedBox(width: 20),
                              DropdownButton<String>(
                                items: ITEM_GROUP_Names.map((String item) {
                                  return DropdownMenuItem<String>(
                                    value: item,
                                    alignment: AlignmentDirectional.centerEnd,
                                    child: Text(
                                      item,
                                      textAlign: TextAlign.center,
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                          color: defultcolor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (v) {
                                  cubit.changeDropdownCateg(v.toString());
                                },
                                value: cubit.valCateg.isNotEmpty ? cubit.valCateg.toString() : null ,
                              ),
                              // Text(
                              //   cubit.valCateg.toString(),
                              //   // textAlign: TextAlign.end,
                              //   textDirection: TextDirection.ltr,
                              //   style: TextStyle(
                              //       color: defultcolor,
                              //       fontWeight: FontWeight.bold,
                              //       fontSize: 13),
                              // ),
                              Spacer(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    BuildCondition(
                      condition:cubit.ITEM_ModelListGoup.length > 0,
                      fallback: (context) => Container(),
                      builder: (context) => GridView.count(
                        crossAxisCount: 2,
                       //  mainAxisSpacing: 10,
                        crossAxisSpacing: 20,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        childAspectRatio: 1 / 1.25,
                        children: List.generate(
                            cubit.ITEM_ModelListGoup.length,
                            (index) =>
                                buildI(context, cubit.ITEM_ModelListGoup[index])),
                      ),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}

Widget buildI(context, InvoiceItemModel ITEM_Model) => InkWell(
      onTap: () {
        Navigator.pop(context);
        posCubit.get(context).SearchInInvoiceItems(ITEM_Model, context);
      },
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.topStart,
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Image(
                    image: AssetImage('images/images.png'),
                    fit: BoxFit.cover,
                    height: 100,
                  ),
                ),
              ),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.red,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      '${ITEM_Model.SALES_PRICE1??0}',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        height: 1,
                        color: Colors.white,
                      ),
                    ),
                  )),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            '${ITEM_Model.ITEM_NAME}',
            maxLines: 2,textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(height: 1, color: Colors.black, fontSize: 12),
          ),
        ],
      ),
    );

import 'package:audioplayers/audioplayers.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/cubit/cubit.dart';
import 'package:pos/cubit/states.dart';
import 'package:pos/models/InvoiceItemModel.dart';
import 'package:pos/shared/style/colors.dart';
import '../shared/Content.dart';

Color? colors;
TextEditingController searchcontroller = TextEditingController();

Future openSearchItem({context, cubit, required StockID}) => showDialog(
    context: context,
    builder: (context) => BlocConsumer<posCubit, posStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = posCubit.get(context);
          return AlertDialog(
              alignment: Alignment.topCenter,
              contentPadding: EdgeInsets.only(top: 5),
              content: Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height * 0.3,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: searchcontroller,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsetsDirectional.zero,
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onFieldSubmitted: (v) {
                          cubit.Search_ItemsNames(Name: v);
                        },
                        onChanged: (v) {
                          cubit.Search_ItemsNames(Name: v);
                        },
                      ),
                    ),
                    SizedBox(height: 2),
                    BuildCondition(
                        condition: cubit.Search_ItemsList.length > 0,
                        builder: (context) => Expanded(
                              child: ListView.separated(
                                itemBuilder: (context, index) {
                                  if (index % 2 == 0) {
                                    colors = list2;
                                  } else {
                                    colors = list;
                                  }
                                  return SearchItem(
                                      ITEMmodel: cubit.Search_ItemsList[index],
                                      colors: colors,
                                      context: context);
                                },
                                separatorBuilder: (context, index) => SizedBox(
                                  height: 1,
                                ),
                                itemCount: cubit.Search_ItemsList.length,
                              ),
                            ),
                        fallback: (context) => Container(
                              height: 2,
                            )),
                  ],
                ),
              ));
        }));

Widget SearchItem({colors, context, InvoiceItemModel? ITEMmodel}) => InkWell(
      onTap: () {
        Navigator.pop(context);
        posCubit.get(context).SearchInInvoiceItems(ITEMmodel, context);
        Cache.play('m.mp3',mode: PlayerMode.LOW_LATENCY) ;
        searchcontroller.text = '';
      },
      child: Container(
          color: colors,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              ITEMmodel!.ITEM_NAME!,
              maxLines: 2,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                  color: defultcolor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          )),
    );

Future openmessageMissItem(context) => showDialog(
    context: context,
    builder: (context) {
      var cubit = posCubit.get(context);
      return AlertDialog(
        contentPadding: EdgeInsets.all(8),
        content: Text(
          'هذه المنتج موجودة بالفعل',
          textAlign: TextAlign.center,
          maxLines: 2,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
        ),
      );
    });

import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/cubit/cubit.dart';
import 'package:pos/cubit/states.dart';
import 'package:pos/modules/Login.dart';
import 'package:pos/shared/component.dart';
import 'package:pos/shared/helper/cach_Helper.dart';
import 'package:pos/shared/style/colors.dart';
import '../Api/get.dart';
import '../DataBase/Delet.dart';
import '../shared/Content.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<posCubit, posStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = posCubit.get(context);
        var itemsValue = ['جنيه', 'ريال', 'درهم', 'دينار', 'ليره'];
        return Scaffold(
          appBar: AppBar(
            // centerTitle: true,
            title: Text(
              "الاعدادات",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Container(
                        //   width: double.infinity,
                        //   height: 50,
                        //   decoration: BoxDecoration(
                        //       color: TTF,
                        //       borderRadius: BorderRadius.circular(12)),
                        //   clipBehavior: Clip.antiAlias,
                        //   child: InkWell(
                        //     onTap: () {
                        //       NavigatorTo(context, InvoiceSetting());
                        //     },
                        //     child: Row(
                        //       crossAxisAlignment: CrossAxisAlignment.center,
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       textDirection: TextDirection.rtl,
                        //       children: [
                        //         Container(
                        //           width: (MediaQuery.of(context).size.width *
                        //                   0.6) -
                        //               40,
                        //           child: Center(
                        //             child: Text(
                        //               'اعدادات الفواتير',
                        //               // textAlign: TextAlign.end,
                        //               textDirection: TextDirection.ltr,
                        //               style: TextStyle(
                        //                   color: defultcolor,
                        //                   fontWeight: FontWeight.bold,
                        //                   fontSize: 12),
                        //             ),
                        //           ),
                        //         ),
                        //         Spacer(),
                        //         Icon(
                        //           Icons.arrow_back_ios,
                        //         ),
                        //         //arrow_left_outlined
                        //         SizedBox(
                        //           width: 20,
                        //         )
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          height: 22,
                        ),
                        Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                              color: TTF,
                              borderRadius: BorderRadius.circular(12)),
                          clipBehavior: Clip.antiAlias,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            textDirection: TextDirection.rtl,
                            children: [
                              Container(
                                width:
                                    (MediaQuery.of(context).size.width * 0.5) -
                                        40,
                                child: Center(
                                  child: Text(
                                    'اللغه', // textAlign: TextAlign.end,
                                    textDirection: TextDirection.ltr,
                                    style: TextStyle(
                                        color: defultcolor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                ),
                              ),
                              Spacer(),
                              Container(
                                width:
                                    (MediaQuery.of(context).size.width * 0.5) -
                                        40,
                                child: Center(
                                  child: Text(
                                    'العربية', // textAlign: TextAlign.end,
                                    textDirection: TextDirection.ltr,
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // SizedBox(
                        //   height: 22,
                        // ),
                        // Container(
                        //   width: double.infinity,
                        //   height: 50,
                        //   decoration: BoxDecoration(
                        //       color: TTF,
                        //       borderRadius: BorderRadius.circular(12)),
                        //   clipBehavior: Clip.antiAlias,
                        //   child: Row(
                        //     crossAxisAlignment: CrossAxisAlignment.center,
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     textDirection: TextDirection.rtl,
                        //     children: [
                        //       Container(
                        //         width:
                        //             (MediaQuery.of(context).size.width * 0.5) -
                        //                 40,
                        //         child: Center(
                        //           child: Text(
                        //             'العمله', // textAlign: TextAlign.end,
                        //             textDirection: TextDirection.ltr,
                        //             style: TextStyle(
                        //                 color: defultcolor,
                        //                 fontWeight: FontWeight.bold,
                        //                 fontSize: 12),
                        //           ),
                        //         ),
                        //       ),
                        //       Padding(
                        //         padding:
                        //             const EdgeInsets.symmetric(vertical: 3),
                        //         child: Container(
                        //           width: (MediaQuery.of(context).size.width *
                        //                   0.5) -
                        //               38,
                        //           decoration: BoxDecoration(
                        //               borderRadius: BorderRadius.circular(12),
                        //               color: Colors.grey[200]),
                        //           child: Row(
                        //             crossAxisAlignment:
                        //                 CrossAxisAlignment.center,
                        //             mainAxisAlignment: MainAxisAlignment.center,
                        //             textDirection: TextDirection.rtl,
                        //             children: [
                        //               DropdownButton<String>(
                        //                 menuMaxHeight: 200,
                        //                 underline: Container(),
                        //                 items: itemsValue.map((String item) {
                        //                   return DropdownMenuItem<String>(
                        //                     value: item,
                        //                     alignment:
                        //                         AlignmentDirectional.centerEnd,
                        //                     child: Text(
                        //                       item,
                        //                       textAlign: TextAlign.center,
                        //                       textDirection: TextDirection.rtl,
                        //                       style: TextStyle(
                        //                           color: defultcolor,
                        //                           fontWeight: FontWeight.bold,
                        //                           fontSize: 12),
                        //                     ),
                        //                   );
                        //                 }).toList(),
                        //                 onChanged: (v) {
                        //                   cubit.changeDropdownCurrency(
                        //                       v.toString());
                        //                 },
                        //                 //     value: cubit.valCurrency.toString().isNotEmpty ? cubit.valCurrency.toString() : '',
                        //               ),
                        //               Text(
                        //                 cubit.valCurrency.toString(),
                        //                 // textAlign: TextAlign.end,
                        //                 textDirection: TextDirection.ltr,
                        //                 style: TextStyle(
                        //                     color: defultcolor,
                        //                     fontWeight: FontWeight.bold,
                        //                     fontSize: 12),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //       Spacer(),
                        //     ],
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 22,
                        // ),
                        SizedBox(
                          height: 22,
                        ),
                        Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                              color: TTF,
                              borderRadius: BorderRadius.circular(12)),
                          clipBehavior: Clip.antiAlias,
                          child: InkWell(
                            onTap: () {
                              deleteDataBase(context);
                              Cach_helper.RemoveData(key: 'UserId');
                              UserId = null;
                              device = null;
                              Active = 0;
                              Future.delayed(Duration(seconds: 1), () {
                                NavigatorAndFinish(context, loginScreen());
                              });
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              textDirection: TextDirection.rtl,
                              children: [
                                Container(
                                  width: (MediaQuery.of(context).size.width *
                                          0.6) -
                                      40,
                                  child: Center(
                                    child: Text(
                                      'حذف بيانات التطبيق ؟',
                                      // textAlign: TextAlign.end,
                                      textDirection: TextDirection.ltr,
                                      style: TextStyle(
                                          color: defultcolor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Icon(Icons.delete),
                                //arrow_left_outlined
                                SizedBox(
                                  width: 20,
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 22,
                        ),
                        Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                              color: TTF,
                              borderRadius: BorderRadius.circular(12)),
                          clipBehavior: Clip.antiAlias,
                          child: InkWell(
                            onTap: () {
                              Cach_helper.RemoveData(key: 'UserId');
                              UserId = null;
                              device = null;
                              Active = 0;
                              Future.delayed(Duration(microseconds: 2), () {
                                NavigatorAndFinish(context, loginScreen());
                              });
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              textDirection: TextDirection.rtl,
                              children: [
                                Container(
                                  width: (MediaQuery.of(context).size.width *
                                          0.6) -
                                      40,
                                  child: Center(
                                    child: Text(
                                      'تسجيل خروج ',
                                      // textAlign: TextAlign.end,
                                      textDirection: TextDirection.ltr,
                                      style: TextStyle(
                                          color: defultcolor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Icon(Icons.logout),
                                //arrow_left_outlined
                                SizedBox(
                                  width: 20,
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 22,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          //  ),
        );
      },
    );
  }
}

Future openmessageDeleteSuccess(context) => showDialog(
    context: context,
    builder: (context) => AlertDialog(
          content: Text(
            'تم حذف البيانات بنجاح',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ));

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/cubit/cubit.dart';
import 'package:pos/cubit/states.dart';
import 'package:pos/shared/component.dart';
import 'package:pos/shared/style/colors.dart';

class AddCategories extends StatefulWidget{

  @override
  State<StatefulWidget> createState() =>_AddCategories();
}
class _AddCategories extends State<AddCategories>
{
  TextEditingController GROUP_NAME=TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    double width= MediaQuery.of(context).size.width;

    return BlocConsumer<posCubit,posStates>(
        listener:(context,state){} ,
        builder: (context,state)
        {
          var cubit = posCubit.get(context);
          return Scaffold(
         //   backgroundColor: Colors.grey[100],
            appBar: AppBar(
              title: Text('اضافة تصنيف جديد',
                style:TextStyle(fontSize: 21,color: Colors.white) ,),
            ),
            body: SingleChildScrollView(
              child: Column(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 20,),
                            Row(
                              children: [
                                Spacer(),
                                Text('اسم التصنيف',
                                  style: TextStyle(color: defultblack,
                                      fontWeight: FontWeight.bold, fontSize: 15, height: 1
                                  ),),
                                SizedBox(width: 15)
                              ],
                            ),
                            SizedBox(height: 7,),
                            defultTextField( width: width - 30,
                                context: context, //controller: remaining,
                                type: TextInputType.text,
                               controller: GROUP_NAME),

                            SizedBox(height: 22,),

                            defultButton(text: 'حفظ التصنيف', ontap: (){

                            // setState(() async {
                            //
                            //   if(GROUP_NAME.text !='' && GROUP_NAME.text != null)
                            //     { await insertGroup(GROUP_NAME: GROUP_NAME.text );
                            //
                            //       if(insertGroupS)
                            //       {
                            //         GROUP_NAME.text ='';
                            //         openmessageSuccess(context);
                            //       }
                            //       else {openmessageNull(context);}
                            //   }
                            //   else{openmessageNull(context);}
                            // });
                            },
                              width:width *.7, ),
                          ],
                        ),

                      ),
                    ),
                  ),
                  SizedBox(height: 5,),
                Container(color: Colors.white, width:width *.9,height: 2,)

                ],
              ),
            ),
          );
        });
  }

  Future openmessageNull(context)=>showDialog(
      context: context,
      builder: (context)=>AlertDialog(
        content: Text(
            'لم يتم اضافه تصنيف',textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: Colors.redAccent ),

        ),
      ) );

  Future openmessageSuccess(context)=>showDialog(
      context: context,
      builder: (context)=>AlertDialog(
        content: Text(
          'تم حفظ التصنيف بنجاح',textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16 ),

        ),
      ) );
}

import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/cubit/cubit.dart';
import 'package:pos/cubit/states.dart';
import 'package:pos/shared/component.dart';
import 'package:pos/shared/style/colors.dart';

class InvoiceSetting extends StatelessWidget {

  TextEditingController namecontroller=TextEditingController();
  TextEditingController phonecontroller=TextEditingController();
  TextEditingController addreescontroller=TextEditingController();
  TextEditingController notes=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<posCubit,posStates>(
      listener: (context,state){},
        builder: (context,state){
          var cubit=posCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              // centerTitle: true,
              title: Text("اعدات الفواتير",
                style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                        autovalidateMode: AutovalidateMode.always,
                        //key: registerKey,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Center(
                                child:Text('لوجو الشركه',
                                  style: Theme.of(context).textTheme.headline6!.copyWith(
                                      color: Colors.grey,fontWeight:FontWeight.bold,height: 1.2,fontSize: 14
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              Center(
                                child:InkWell(onTap: ()
                                {openFollowItem(context,cubit);},
                                  child: Stack(alignment: Alignment.topLeft,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Stack(alignment: Alignment.center,
                                          children: [
                                            CircleAvatar( radius: 38,backgroundColor: Colors.grey,
                                            ) ,
                                            CircleAvatar( radius: 35,
                                                backgroundImage: AssetImage('images/images.png'),

                                            ) ,
                                          ],
                                        ),
                                      ),
                                      CircleAvatar(child: Icon( Icons.camera_enhance,size: 28,),radius:17 ,backgroundColor: Colors.grey[200],)
                                    ],
                                  ),
                                )
                              ),
                              SizedBox(height: 5,),
                              Text('اسم الشركه تظهر فوق فاتوه المبيعات',
                                style: Theme.of(context).textTheme.headline6!.copyWith(
                                    color: text_1,fontWeight:FontWeight.bold,height: 1.2,fontSize: 12
                                ),
                              ),
                              defultTextField(
                                context: context,
                                // vaildate: (value)
                                // {
                                //   if(value!.isEmpty){
                                //     return'من فضلك ادخل اسم العميل';
                                //   }
                                // },
                                Texttcolor: defultcolor,
                                CursorColor: defultcolor,
                                type: TextInputType.name,
                                controller: namecontroller,
                              ),
                              SizedBox(height: 20,),
                              Text('الهاتف المحمول'.toUpperCase(),
                                style: Theme.of(context).textTheme.headline6!.copyWith(
                                    color: text_1,fontWeight:FontWeight.bold,height: 1.2,fontSize: 12

                                ),
                              ),
                              defultTextField(
                                  context: context,
                                  Texttcolor: defultcolor,
                                  CursorColor: defultcolor,
                                  // vaildate: (value)
                                  // {
                                  //   if(value!.isEmpty){
                                  //     return'من فضلك ادخل رقم الهاتف';
                                  //   }
                                  // },
                                  type: TextInputType.phone,
                                  controller: phonecontroller,
                                  onsubmit: (value){}

                              ),
                              SizedBox(height: 20,),
                              Text('عنوان الشركه'.toUpperCase(),
                                style: Theme.of(context).textTheme.headline6!.copyWith(
                                    color: text_1,fontWeight:FontWeight.bold,height: 1.2,fontSize: 12

                                ),
                              ),
                              defultTextField(
                                context: context,
                                Texttcolor: defultcolor,
                                CursorColor: defultcolor,
                                type: TextInputType.text,
                                controller: addreescontroller,
                              ),
                              SizedBox(height: 20,),

                              Text(' ملاحظات تكيب اخر الفاتوره',
                                style: Theme.of(context).textTheme.headline6!.copyWith(
                                    color: text_1,fontWeight:FontWeight.bold,height: 1.2,fontSize: 12

                                ),
                              ),
                              defultTextField(
                                context: context,
                                Texttcolor: defultcolor,
                                CursorColor: defultcolor,
                                type: TextInputType.text,
                                controller: notes,

                              ),
                              SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BuildCondition(
                                    condition: true,
                                    builder: (context)=>Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(colors: buttonColor),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: MaterialButton(
                                            child:Text ('حفظ البيانات',
                                              style: TextStyle(color: Colors.white,
                                                  fontWeight: FontWeight.bold,fontSize: 30
                                              ),),
                                            onPressed: (){
                                              // if(registerKey.currentState!.validate())
                                              // { //NavigatorAndFinish(context, home_screen());
                                              // }
                                            }),
                                      ),
                                    ),
                                    fallback:(context)=> Center(child: CircularProgressIndicator()),

                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
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

  Future openFollowItem(context,cubit)=>showDialog(
      context: context,
      builder: (context)=>AlertDialog(backgroundColor:Colors.black45 ,
        content:  SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
            defultButton(text: 'استخدم الكاميرا',width: MediaQuery.of(context).size.width *0.55 ,  ontap: ()async{
              await posCubit.get(context).getlogoImageCamera();
            }),
              SizedBox(height: 10,),
              defultButton(text: 'فتح معرض الصور',width: MediaQuery.of(context).size.width *0.55 ,  ontap: ()async{
                await posCubit.get(context).getlogoImageCallery();
              }),
            ],
          ),
        ),
      ) );
}
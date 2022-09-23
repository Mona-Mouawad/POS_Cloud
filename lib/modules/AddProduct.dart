import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/DataBase/getDB.dart';
import 'package:pos/cubit/cubit.dart';
import 'package:pos/cubit/states.dart';
import 'package:pos/shared/component.dart';
import 'package:pos/shared/style/colors.dart';

class AddProduct extends StatefulWidget{

  @override
  State<StatefulWidget> createState() =>_AddProduct();
}
class _AddProduct extends State<AddProduct>
{

  // var registerKey =GlobalKey<FormState>();
  TextEditingController brCodecontroller=TextEditingController();
  TextEditingController namecontroller=TextEditingController();
  TextEditingController notes=TextEditingController();
  TextEditingController pricecontroller=TextEditingController();
  TextEditingController price_1controller=TextEditingController();
  TextEditingController price_2controller=TextEditingController();
  TextEditingController price_3controller=TextEditingController();
  TextEditingController quantitycontroller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<posCubit,posStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit=posCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            // centerTitle: true,
            title: Text("اضافة منتج جديد",
              style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14)),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                      autovalidateMode: AutovalidateMode.always,
                      //key: registerKey,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(height: 10,),
                            Center(
                                child:InkWell(onTap: ()
                                {openImage(context,cubit);},
                                  child: Stack(alignment: Alignment.topLeft,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Stack(alignment: Alignment.center,
                                          children: [
                                            CircleAvatar( radius: 38,backgroundColor: Colors.grey[400],
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
                        Center(
                          child: Container(
                              width: MediaQuery.of(context).size.width*.7,
                              height: 70,
                              decoration: BoxDecoration(
                                  border:Border.all(color: Colors.black,width: 1,style: BorderStyle.solid)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 3),
                                child: Image(image:AssetImage('images/barcode2.jpg') ,)
                              )),
                        ),
                            SizedBox(height: 20,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              textDirection: TextDirection.rtl,
                              children: [
                                Image(image:AssetImage('images/barcode.jpg') ,width:MediaQuery.of(context).size.width*.2 -50 ,),
                                SizedBox(width: 10,),
                                defultTextField(
                                  context: context,
                                  Texttcolor: defultcolor,
                                  CursorColor: defultcolor,
                                  type: TextInputType.number,
                                  controller: brCodecontroller,
                                  hintText: '10002',
                                  width: MediaQuery.of(context).size.width*.6-20 ,
                                ),SizedBox(width: 2,),
                               // IconButton(onPressed: (){}, icon: Icon(Icons.print),color: defultcolor,iconSize: 20,),
                              ],
                            ),
                            SizedBox(height: 20,),
                            Text('اسم المنتج بالمواصفات تقصيلى',
                              style: Theme.of(context).textTheme.headline6!.copyWith(
                                  color: text_1,fontWeight:FontWeight.bold,height: 1.2,fontSize: 12
                              ),
                            ),
                            defultTextField(
                              context: context,
                              Texttcolor: defultcolor,
                              CursorColor: defultcolor,
                              type: TextInputType.name,
                              controller: namecontroller,
                            ),
                            SizedBox(height: 20,),
                            Text('ملاحظات على المنتج   '.toUpperCase(),
                              style: Theme.of(context).textTheme.headline6!.copyWith(
                                  color: text_1,fontWeight:FontWeight.bold,height: 1.2,fontSize: 12,
                              ),
                            ),
                            defultTextField(
                                context: context,
                                Texttcolor: defultcolor,
                                CursorColor: defultcolor,
                                type: TextInputType.text,
                                controller: notes,
                                onsubmit: (value){}
                            ),
                            SizedBox(height: 20,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              textDirection: TextDirection.rtl,
                              children: [
                                Column( mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text('التصنيف'.toUpperCase(),
                                      style: Theme.of(context).textTheme.headline6!.copyWith(
                                          color: text_1,fontWeight:FontWeight.bold,height: 1.2,fontSize: 12

                                      ),
                                    ),
                                    Container(width:(MediaQuery.of(context).size.width*0.7)-38,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(14),
                                          color: Colors.grey[200]),
                                      child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        textDirection: TextDirection.rtl,
                                        children: [
                                          SizedBox(width: 10,),
                                          DropdownButton<String>(
                                            menuMaxHeight: 180,
                                            items:ITEM_GROUP_Names.map((String item) {
                                              return DropdownMenuItem<String>
                                                (value: item,
                                                alignment: AlignmentDirectional.centerEnd,
                                                child: Text(item, textAlign: TextAlign.end,
                                                  textDirection: TextDirection.ltr,
                                                  style: TextStyle(color: defultcolor,
                                                      fontWeight: FontWeight.bold, fontSize: 12),),
                                              );}).toList(),
                                            onChanged: (v) {
                                              cubit.changeDropdownCateg(v.toString());
                                            },
                                            value: cubit.valCateg.toString().isNotEmpty ? cubit.valCateg : null,
                                          ),

                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                                SizedBox(width: 10,),
                                // Column( mainAxisSize: MainAxisSize.min,
                                //   crossAxisAlignment: CrossAxisAlignment.end,
                                //   children: [
                                //     Text('سعر الشراء'.toUpperCase(),
                                //       style: Theme.of(context).textTheme.headline6!.copyWith(
                                //           color: text_1,fontWeight:FontWeight.bold,height: 1.2,fontSize: 12
                                //
                                //       ),
                                //     ),
                                //     defultTextField(
                                //       context: context,height: 50,
                                //       Texttcolor: defultcolor,
                                //       CursorColor: defultcolor,
                                //       type: TextInputType.number,
                                //       controller: pricecontroller,
                                //       width: MediaQuery.of(context).size.width*.5 -45,
                                //     ),
                                //   ],
                                // )
                              ],
                            ),
                            SizedBox(height: 20,),
                            Text('سعر البيع 1'.toUpperCase(),
                              style: Theme.of(context).textTheme.headline6!.copyWith(
                                  color: text_1,fontWeight:FontWeight.bold,height: 1.2,fontSize: 12

                              ),
                            ),
                            defultTextField(
                              context: context,
                              Texttcolor: defultcolor,
                              CursorColor: defultcolor,
                              type: TextInputType.number,
                              controller: price_1controller,
                            ),
                            SizedBox(height: 20,),
                            Text('سعر البيع 2'.toUpperCase(),
                              style: Theme.of(context).textTheme.headline6!.copyWith(
                                  color: text_1,fontWeight:FontWeight.bold,height: 1.2,fontSize: 12

                              ),
                            ),
                            defultTextField(
                              context: context,
                              Texttcolor: defultcolor,
                              CursorColor: defultcolor,
                              type: TextInputType.number,
                              controller: price_2controller,
                            ),
                            SizedBox(height: 20,),
                            Text('سعر البيع 3'.toUpperCase(),
                              style: Theme.of(context).textTheme.headline6!.copyWith(
                                  color: text_1,fontWeight:FontWeight.bold,height: 1.2,fontSize: 12  ),
                            ),
                            defultTextField(
                              context: context,
                              Texttcolor: defultcolor,
                              CursorColor: defultcolor,
                              type: TextInputType.number,
                              controller: price_3controller,
                            ),
                            SizedBox(height: 20,),

                            Text('الكمية المتاحة فى المخزن',
                              style: Theme.of(context).textTheme.headline6!.copyWith(
                                  color: text_1,fontWeight:FontWeight.bold,height: 1.2,fontSize: 12

                              ),
                            ),
                            defultTextField(
                              context: context,
                              Texttcolor: defultcolor,
                              CursorColor: defultcolor,
                              type: TextInputType.number,
                              controller: quantitycontroller,

                            ),
                            // Row(
                            //   crossAxisAlignment: CrossAxisAlignment.center,
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   textDirection: TextDirection.rtl,
                            //   children: [
                            //     Spacer(),
                            //     Container(
                            //         width: 120,
                            //         child: Text(
                            //           'معادله رياضيه',
                            //           textAlign: TextAlign.center,
                            //           style: TextStyle(color: Colors.grey[600],
                            //               fontWeight: FontWeight.bold, fontSize: 12),
                            //         )),
                            //     Spacer(),
                            //     Checkbox(
                            //       value: cubit.checkProduct,
                            //       onChanged: (bool? v) {
                            //         cubit.changeProductCheck();
                            //       },
                            //       activeColor: defultcolor,
                            //     ),
                            //   ],
                            // ),
                            SizedBox(height: 30,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BuildCondition(
                                  condition: true,
                                  builder: (context)=>Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: buttonColor),
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      child: MaterialButton(
                                          child:Text ('حفظ البيانات',
                                            style: TextStyle(color: Colors.white,
                                                fontWeight: FontWeight.bold,fontSize: 30
                                            ),),
                                          onPressed: (){
  //                                           setState(() async {
  //                                             if(namecontroller.text !='' && namecontroller.text != null && quantitycontroller.text !=null
  //                                             && price_1controller.text !=''&& price_1controller.text !=null && quantitycontroller.text != ''
  //                                                 && price_2controller.text !=''&& price_2controller.text !=null && price_3controller.text != ''
  //                                             && int.parse(price_1controller.text) > 0 && int.parse(price_2controller.text) > 0 && int.parse(price_3controller.text) > 0
  // )
  //                                             {
  //                                               print(brCodecontroller.text);
  //                                             await  insertItems(ITEM_NAME:namecontroller.text,
  //                                                 BARCODE: brCodecontroller.text ,
  //                                                   NODES:notes.text,
  //                                                 QUANTITY :int.parse(quantitycontroller.text ) ,
  //                                                  SALES_PRICE1: double.parse(price_1controller.text) ,
  //                                                  SALES_PRICE2: price_2controller.text ,
  //                                                  SALES_PRICE3: price_3controller.text ,
  //                                                 GROUP_ID: GROUP_ID,
  //                                               LE_ID:LE_ID ,
  //                                               status:'new'  ,
  //                                               UserId:UserId!  ,
  //                                               );
  //                                               if(insertItemsS){
  //                                                 namecontroller.text ='' ;
  //                                                 brCodecontroller.text ='' ;
  //                                                 notes.text ='' ;
  //                                                 quantitycontroller.text ='' ;
  //                                                 price_1controller.text ='' ;
  //                                                 price_2controller.text ='' ;
  //                                                 price_3controller.text ='' ;
  //                                                 openmessageSuccess(context);
  //                                               }
  //                                               else{
  //                                                 openmessageNull(context);
  //                                               }
  //                                             }
  //                                             else{
  //                                               openmessageNull(context);
  //                                             }
  //                                           });
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

  Future openImage(context,cubit)=>showDialog(
      context: context,
      builder: (context)=>AlertDialog(backgroundColor:Colors.black45 ,
        content:  SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              defultButton(text: 'استخدم الكاميرا',width: MediaQuery.of(context).size.width *0.55 ,  ontap: ()async{
                await posCubit.get(context).getProductImageCamera();
              }),
              SizedBox(height: 10,),
              defultButton(text: 'فتح معرض الصور',width: MediaQuery.of(context).size.width *0.55 ,  ontap: ()async{
                await posCubit.get(context).getProductImageCallery();
              }),
            ],
          ),
        ),
      ) );

  Future openmessageNull(context)=>showDialog(
      context: context,
      builder: (context)=>AlertDialog(contentPadding: EdgeInsets.zero,
        content: Text(
          'لم يتم اضافه المنتج , من فضلك ادخل البيانات صحيحة',textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: Colors.redAccent ),

        ),
      ) );

  Future openmessageSuccess(context)=>showDialog(
      context: context,
      builder: (context)=>AlertDialog(
        content: Text(
          'تم حفظ المنتج بنجاح',textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16 ),

        ),
      ) );
}
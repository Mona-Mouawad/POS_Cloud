import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/DataBase/getDB.dart';
import 'package:pos/cubit/cubit.dart';
import 'package:pos/cubit/states.dart';
import 'package:pos/shared/component.dart';
import 'package:pos/shared/style/colors.dart';

import '../DataBase/INSERTS.dart';

class ProductsInventory extends StatefulWidget{

  @override
  State<StatefulWidget> createState() =>_ProductsInventory();
}
class _ProductsInventory extends State<ProductsInventory>
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
            backgroundColor:Colors.grey[200] ,
            appBar: AppBar(
              title: Text(
                "جرد المنتجات",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(  decoration: BoxDecoration(  borderRadius: BorderRadius.circular(12),
                color: Colors.white,),
                clipBehavior: Clip.antiAlias,
                child: Column(mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      '${DateTime.now().day} / ${DateTime.now().month} / ${DateTime.now().year}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                    SizedBox(
                      height: 15,
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
                                menuMaxHeight: 120,underline: Container(), // value: '',//cubit.valStock_Details,
                                items:STOCK_ModelName.map<DropdownMenuItem<String>>((String item) {
                                  return DropdownMenuItem<String>
                                    (value: item,
                                    alignment: AlignmentDirectional.centerEnd,
                                    child: Text(item, textAlign: TextAlign.center,
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(color: defultcolor,
                                          fontWeight: FontWeight.bold, fontSize: 15),),
                                  );}).toList(),
                                onChanged: (v) {
                                  cubit.changevalStockDropdown(v.toString());
                                },
                                itemHeight:48,
                                value: cubit.valStock.toString().isNotEmpty ? cubit.valStock : null,
                              ),
                              // Text(cubit.valStock.toString(),// textAlign: TextAlign.end,
                              //   textDirection: TextDirection.ltr,
                              //   style: TextStyle(color: defultcolor,
                              //       fontWeight: FontWeight.bold, fontSize: 14),),
                              // Spacer(),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 24,
                        ),
                        Text('المخزن'.toUpperCase(),
                          style: TextStyle(
                              color: defultblack,fontWeight:FontWeight.bold,fontSize: 13
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: defultTextField(
                            height: 48,
                            context: context,
                            controller: searchcontroller,
                            hintText: 'الكمية ',
                            hintcolor: Colors.grey,
                            Texttcolor: defultcolor,
                            type: TextInputType.number,
                            width: MediaQuery.of(context).size.width - 130,
                          ),
                        ),
                        MaterialButton(
                            onPressed: () => Scan(),
                            child: Image(
                              image: AssetImage('images/barcode.jpg'),
                              height: 48,
                              width: 60,
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    defultButton(text: 'حفظ',width: MediaQuery.of(context).size.width *0.55 ,  ontap: ()async{
                      if(dataS != '' && searchcontroller.text != '' && cubit.valStock != '') {
                        await insertInventoryCount(
                            Quantity:int.parse(searchcontroller.text),
                            StockId:cubit.V_STOCKID,
                            Barcode: dataS,
                            InventoryCountDate: DateTime.now().toString()
                        );
                        if(insertInvCount)
                          {
                            dataS = '' ; searchcontroller.text = '' ; cubit.valStock = '';cubit.V_STOCKID=null; cubit.valStock = '';
                            openmessageSuccess(context);
                          }
                      }
                      else { openmessageNull(context); }
                    }),
                    SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),
            ),

          );
        });
  }

  Future openmessageNull(context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(
          'لم يتم الحفظ , من فضلك اكمل البيانات',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: Colors.redAccent),
        ),
      ));

  Future openmessageSuccess(context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(
          'تم الحفظ ',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ));


  String dataS="";
  Scan()async
  {    var cubit = posCubit.get(context);
  await FlutterBarcodeScanner.scanBarcode(
        '#343168', 'cancel', true, ScanMode.BARCODE).then(
            (value)=>setState(() {
          dataS = value;
          print(dataS);
        }));
  }

  String dataQr="";
  ScanQr()async
  {    var cubit = posCubit.get(context);
  await FlutterBarcodeScanner.scanBarcode(
      '#343168', 'cancel', true, ScanMode.QR).then(
          (value)=>setState(() {
        dataS = value;
        cubit.Search_ItemsInStock(Name: dataS ,StockName: cubit.valStock_Details );
        print(dataS);
      }));
  }

  Future openFollowSCAN()=>showDialog(
      context: context,
      builder: (context)=>AlertDialog(backgroundColor:Colors.black45 ,
        content:  SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              defultButton(text: 'استخدم باركود',width: MediaQuery.of(context).size.width *0.55 ,  ontap: ()async{
                await Scan();
              }),
              SizedBox(height: 10,),
              defultButton(text: 'استخدم QR',width: MediaQuery.of(context).size.width *0.55 ,  ontap: ()async{
                await ScanQr();
              }),
            ],
          ),
        ),
      ) );
}






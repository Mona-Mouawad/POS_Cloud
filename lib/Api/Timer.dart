import 'dart:async';
import '../shared/Content.dart';
import '../shared/location.dart';
import 'Post.dart';
import 'get.dart';

GetFromAPI_Timer ({ required LeId })
async { //final  isConnected =await InternetConnectionChecker().connectionStatus;
  Timer.periodic(const Duration(hours: 24 ), (timer) async {
    await  CheckConnection();
    if (ConnectionStatus)
    {
    await getItemdata(LeId: LeId ) ;
    await  getGroupItemdata(LeId: LeId );
  //  await  getCustVendata(LeId: LeId );
    await  getExpensedata(LeId: LeId );
    await  getCashTransferOutdata(LeId: LeId );
    await  getCashTransferIndata(LeId: LeId );
    }
     });

  Timer.periodic(const Duration(days: 7 ), (timer1)async {
    await  CheckConnection();
    if (ConnectionStatus) {
      await  getTreasurydata(LeId: LeId,UserId: UserId! );
      await  getStockdata(LeId: LeId ,UserId: UserId! );

    }
});

  Timer.periodic(const Duration(days: 30 ), (timer2) async {
    await  CheckConnection();
    if (ConnectionStatus) {
      await  getCitydata(LeId: LeId );
      await  getPaymentMethoddata(LeId: LeId );
      await  getCityRegionedata(LeId: LeId );
    }
  });

  // Timer.periodic(const Duration(days: 1 ), (timer3) async {
  //
  // });

}


PostToAPI_Timer ()
async {
 // final  isConnected =await InternetConnectionChecker().connectionStatus;
  Timer.periodic(const Duration(hours: 1 ), (timer4) async {
    await  CheckConnection();
    if (ConnectionStatus) {
      await getdevicedata(deviceId:deviceId! ,UserId: UserId! );
      if(device!.Active == 1)
      {
        await CashInOut_Post();
        await INVOICE_Post();
        await InvoiceItem_Post();
        await CUST_VEN_Post();
        await Gps_Post();
      }
    }
  });

  Timer.periodic(const Duration(minutes: 15 ), (timer5) async {

    await  CheckConnection();
    if (ConnectionStatus) {
      await storeLocation() ;
    }
  });

  // Timer.periodic(const Duration(hours: 1 ), (timer5) async {
  //   await  CheckConnection();
  //   if (ConnectionStatus) {
  //     await getdevicedata(deviceId:deviceId!,UserId: UserId!  );
  //   if(device!.Active == 1)
  //     {
  //
  //     }
  //   }
  // });

}

import 'package:pos/DataBase/DataBase.dart';
import 'package:pos/shared/helper/cach_Helper.dart';
import '../Api/get.dart';
import '../modules/Settings.dart';
import '../shared/Content.dart';
import 'getDB.dart';


deleteDataBase(context)async
{
 await database.transaction((txn)async {
    await txn.delete('MobPosUser');
    await txn.delete('MobPosStock');
    await txn.delete('MobPosCustVen');
    await txn.delete('MobPosTreasury');
    await txn.delete('MobPosItem');
    await txn.delete('MobPosItemGroup');
    await txn.delete('MobPosInvoice');
    await txn.delete('MobPosInvoiceItem');
    await txn.delete('MobPosCity');
    await txn.delete('MobPosCityRegion');
    await txn.delete('MobPosPaymentMethod');
    await txn.delete('MobPosExpense');
    await txn.delete('MobPosInvTransferIn');
    await txn.delete('MobPosInvTransferOut');
    await txn.delete('MobPosCashTransferIn');
    await txn.delete('MobPosCashTransferOut');
    await txn.delete('MobPosCashInOut');
    await txn.delete('MobPosAccessButton');
    await txn.delete('MobPosGps');
    await txn.delete('MobPosUsrSec');
    await txn.delete('MobPosStockInOut');
    await txn.delete('MobPosInv_Uom');
    Cach_helper.RemoveData(key: 'USER_NAME');
    Cach_helper.RemoveData(key: 'LeName');
    Cach_helper.RemoveData(key: 'LeId');
    Cach_helper.RemoveData(key: 'LE_ID');
    Cach_helper.RemoveData(key: 'UserId');
    Cach_helper.RemoveData(key: 'S_D');
  //  Cach_helper.RemoveData(key: 'deviceId');
    Cach_helper.RemoveData(key: 'Active');
    LeName = null ;
    UserId = null;
    LE_ID = null ;
    device = null ;
    Active = 0 ;
  }).then((value) {
     GetAllData_DB();
   openmessageDeleteSuccess(context);
       print('///////////////********************************');

 });

}

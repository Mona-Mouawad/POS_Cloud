
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:device_info/device_info.dart';
import 'package:pos/shared/helper/cach_Helper.dart';
import '../Api/Post.dart';
import '../Api/get.dart';
import '../models/device.dart';
import 'helper/Dio_Helper.dart';


int? UserId;
int? Active = 1 ;
bool S_D = false;
bool serviceEnabled = false;
int ? LE_ID ;
String? LeName;
String? deviceId;
String? USER_NAME;
var local ;

//var ConnectionType = 'LOCAL' ; //  NET / LOCAL
bool ConnectionStatus = false;

CheckConnection()
async {
//if(ConnectionType == 'LOCAL') {
    Dio_Helper.getData(url: '${URl}SmUser?finder=RowFinder')
        .then((value) async {
      print('value.statusCode    ' + value.statusCode.toString());
      local = value.statusCode;
      ConnectionStatus = true;
    }).catchError((Error) {
      print("eee   " + Error.toString());
      ConnectionStatus = false;
    });
//  }
//
// if(ConnectionType == 'NET') {
//     final isConnected = await InternetConnectionChecker().connectionStatus;
//     if (isConnected == InternetConnectionStatus.connected) {
//       ConnectionStatus = true;
//     }
//     else ConnectionStatus = false;
//   }
}


AudioPlayer audioPlayer = AudioPlayer();
 AudioCache Cache =AudioCache();

play() async {
  int result = await audioPlayer.play('m.wav');
  if (result == 1) {
    // success
  }
}

Device_Model ? UsrSec  ;

getInf({
  context,
}) async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    print('Running on id ${androidInfo.id}'); // e.g. "Moto G (4)"
    print('Running on androidId ${androidInfo.androidId}'); // e.g. "Moto G (4)"
    print('Running on device ${androidInfo.device}'); // e.g. "Moto G (4)"

    Cach_helper.SaveData(key: 'deviceId', value: androidInfo.androidId);
    deviceId = androidInfo.androidId ;
  }
  else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    print('Running on ${iosInfo.utsname.machine}');
    Cach_helper.SaveData(key: 'deviceId', value: iosInfo.identifierForVendor);
    deviceId = iosInfo.identifierForVendor ;
    // await insertUsrSec(
    //   DeviceId: deviceId ,
    //   UserId:UserId ,
    //   Active:0 ,
    //   context:   context
    // );
  }

if(UserId != null && ConnectionStatus)
  {

    await getdevicedata(deviceId: deviceId!, UserId: UserId!);
    if (context != null) {
      UsrSec = Device_Model(
        DeviceId: deviceId,
        UserId: UserId,
        LeId: LE_ID,
        Active: 0,
      );
      await UserSec_Post();
    }
  }

  // await insertUsrSec(
  //   DeviceId: deviceId ,
  //   UserId:UserId ,
  //   Active:0 ,
  // );
}
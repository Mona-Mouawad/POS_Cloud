import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:pos/shared/Content.dart';
import '../DataBase/INSERTS.dart';
import 'helper/cach_Helper.dart';


Location location = new Location();

//bool serviceEnabled = false;
PermissionStatus? _permissionGranted;
LocationData? _locationData;

storeLocation() async {
  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      return;
    }
    if(serviceEnabled)
      Cach_helper.SaveData(key: "serviceEnabled", value: true) ;
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return;
    }
  }

  _locationData = await location.getLocation();

  location.getLocation().then((LocationData currentLocation) async {
    print("    latitude     " + currentLocation.latitude.toString() );
    print("    longitude    " + currentLocation.longitude.toString() );
    print( currentLocation.longitude );
await  insertGps(UserId: UserId,DeviceId:deviceId , Tim: DateFormat('dd/MM/yyyy hh:mm:ss a').format(DateTime.now()),
X:currentLocation.latitude.toString() ,Y: currentLocation.longitude.toString() );
  });
}

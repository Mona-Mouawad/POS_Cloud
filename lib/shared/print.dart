import 'dart:io';
import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';
import 'package:image/image.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pos/cubit/cubit.dart';
import 'package:pos/modules/layout.dart';
import 'package:flutter_bluetooth_basic/flutter_bluetooth_basic.dart';

List<int> bytes = [];
late final  generator ;
//BluetoothManager bluetoothManager = BluetoothManager.instance;
// PrinterBluetoothManager printerManager = PrinterBluetoothManager();
// BlueThermalPrinter  printerManager = BlueThermalPrinter.instance;

image({byte, required context }) async {
  final dir = await getTemporaryDirectory();
  final pathName = '${dir.path}/print_tmp.png';
  final qrFile = File(pathName);
  final imgFile = await qrFile.writeAsBytes(byte!.buffer.asUint8List());
  final img = decodeImage(imgFile.readAsBytesSync());
  final profile = await CapabilityProfile.load();
  if(posCubit.get(context).RPrint == 1) {
    generator = Generator(PaperSize.mm80, profile);
  }
  else {
    generator = Generator(PaperSize.mm58, profile);
  }
  bytes += generator.image(img!);
  bytes += generator.feed(2);
  bytes += generator.cut();
//  final result = await printerManager.printTicket(bytes);

   await bluetooth.printImageBytes(byte);
  print('ooooooooooooooooooooooooooooooooooooo           $img');
}

// void initState() {
//   if (Platform.isAndroid) {
//     bluetoothManager.state.listen((val) {
//       print('state = $val');
//       if (!mounted) return;
//       if (val == 12) {
//         print('on');
//         initPrinter();
//       } else if (val == 10) {
//         print('off');
//         setState(() => _devicesMsg = 'Bluetooth Disconnect!');
//       }
//     });
//   } else {
//     initPrinter();
//   }
// }

// printer() async
// {
//   const PaperSize paper = PaperSize.mm80;
//   final profile = await CapabilityProfile.load();
//
//   final printer = NetworkPrinter(paper, profile);
//
//   final PosPrintResult res = await
//   printer.connect('192.168.0.123', port: 9100);
//
//   if
//   (
//   res == PosPrintResult.success) {
//     testReceipt(printer);
//     printer.disconnect();
//   }
//
//   print
//     ('Print result:${res.msg}'
//   );
// }
///
// Future<void> _startPrint(PrinterBluetooth printer) async {
//
//   final result = await printerManager.printTicket(await _ticket(PaperSize.mm80));
//   showDialog(
//     context: context,
//     builder: (_) => AlertDialog(
//       content: Text(result.msg),
//     ),
//   );
// }
// _ticket(PaperSize paper) async {
//   final ticket = (paper);
//
// }
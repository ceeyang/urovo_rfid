import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:urovo_rfid/urovo_rfid_method_channel.dart';

void main() {
  MethodChannelUrovoRfid platform = MethodChannelUrovoRfid();
  const MethodChannel channel = MethodChannel('urovo_rfid');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

}

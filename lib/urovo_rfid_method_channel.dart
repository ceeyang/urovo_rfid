import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'urovo_rfid_platform_interface.dart';

/// An implementation of [UrovoRfidPlatform] that uses method channels.
class MethodChannelUrovoRfid extends UrovoRfidPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('urovo_rfid');

  @override
  Future<void> init() async {
    await methodChannel.invokeMethod("init");
  }

  @override
  Future<void> release() async {
    await methodChannel.invokeMethod("release");
  }

  @override
  Future<int?> startInventory(int session) async {
    Map<String, dynamic> param = <String, dynamic>{};
    param['session'] = session;
    return await methodChannel.invokeMethod<int>('startInventory', param);
  }

  @override
  Future<int?> stopInventory() async {
    return await methodChannel.invokeMethod<int>('stopInventory');
  }

  @override
  Future<int?> iso180006BWriteTag(Uint8List btAryUID, int btWordAdd,
      int btWordCnt, Uint8List btAryBuffer) async {
    Map<String, dynamic> param = <String, dynamic>{};
    param['btAryUID'] = btAryUID;
    param['btWordAdd'] = btWordAdd;
    param['btWordCnt'] = btWordCnt;
    param['btAryBuffer'] = btAryBuffer;
    return await methodChannel.invokeMethod<int>('iso180006BWriteTag', param);
  }

  @override
  Future<int?> iso180006BReadTag(
      Uint8List btAryUID, int btWordAdd, int btWordCnt) async {
    Map<String, dynamic> param = <String, dynamic>{};
    param['btAryUID'] = btAryUID;
    param['btWordAdd'] = btWordAdd;
    param['btWordCnt'] = btWordCnt;
    return await methodChannel.invokeMethod<int>('iso180006BReadTag', param);
  }

  @override
  Future<int?> iso180006BQueryLockTag(Uint8List btAryUID, int btWordAdd) async {
    Map<String, dynamic> param = <String, dynamic>{};
    param['btAryUID'] = btAryUID;
    param['btWordAdd'] = btWordAdd;
    return await methodChannel.invokeMethod<int>(
        'iso180006BQueryLockTag', param);
  }

  @override
  Future<int?> iso180006BLockTag(Uint8List btAryUID, int btWordAdd) async {
    Map<String, dynamic> param = <String, dynamic>{};
    param['btAryUID'] = btAryUID;
    param['btWordAdd'] = btWordAdd;
    return await methodChannel.invokeMethod<int>('iso180006BLockTag', param);
  }

  @override
  Future<int?> iso180006BInventory() async {
    return await methodChannel.invokeMethod<int>('iso180006BInventory');
  }

  @override
  Future<String?> getReaderTemperature() async {
    return await methodChannel.invokeMethod<String>('getReaderTemperature');
  }

  @override
  Future<int?> getReaderType() async {
    return await methodChannel.invokeMethod<int>('getReaderType');
  }

  @override
  Future<int?> getRange() async {
    return await methodChannel.invokeMethod<int>('getRange');
  }

  @override
  Future<int?> setRange(int range) async {
    Map<String, dynamic> param = <String, dynamic>{};
    param['range'] = range;
    return await methodChannel.invokeMethod<int>('setRange', param);
  }

  @override
  Future<int?> setProfile(int param) async {
    Map<String, dynamic> p = <String, dynamic>{};
    p['param'] = param;
    return await methodChannel.invokeMethod<int>('setProfile', p);
  }

  @override
  Future<String?> getCustomRegion() async {
    return await methodChannel.invokeMethod<String>('getCustomRegion');
  }

  @override
  Future<int?> setCustomRegion(
      int flags, int freSpace, int freNum, int startFre) async {
    Map<String, dynamic> param = <String, dynamic>{};
    param['flags'] = flags;
    param['freSpace'] = freSpace;
    param['freNum'] = freNum;
    param['startFre'] = startFre;
    return await methodChannel.invokeMethod<int>('getCustomRegion', param);
  }

  @override
  Future<String?> getDeviceId() async {
    return await methodChannel.invokeMethod<String>('getDeviceId');
  }

  @override
  Future<void> setInventoryParameter(String params) async {
    Map<String, dynamic> param = <String, dynamic>{};
    param['params'] = params;
    return await methodChannel.invokeMethod('setInventoryParameter', param);
  }

  @override
  Future<void> scanRfid() async {
    return await methodChannel.invokeMethod('scanRfid');
  }

  @override
  Future<void> startRead() async {
    return await methodChannel.invokeMethod('startRead');
  }

  @override
  Future<int?> getScanInterval() async {
    return await methodChannel.invokeMethod<int>('getScanInterval');
  }

  @override
  Future<int?> setScanInterval(int interval) async {
    return await methodChannel.invokeMethod<int>('setScanInterval');
  }

  @override
  Future<String?> getModuleFirmware() async {
    return await methodChannel.invokeMethod<String>('getModuleFirmware');
  }

  @override
  Future<void> clearMask() async {
    return await methodChannel.invokeMethod('clearMask');
  }

  @override
  Future<void> addMask(int mem, int startAddress, int len, String data) async {
    Map<String, dynamic> param = <String, dynamic>{};
    param['mem'] = mem;
    param['startAddress'] = startAddress;
    param['len'] = len;
    param['data'] = data;

    return await methodChannel.invokeMethod('addMask', param);
  }

  @override
  Future<String?> getFrequencyRegion() async {
    return await methodChannel.invokeMethod('getFrequencyRegion');
  }

  @override
  Future<int?> setFrequencyRegion(
      int btRegion, int btStartRegion, int btEndRegion) async {
    Map<String, dynamic> param = <String, dynamic>{};
    param['btRegion'] = btRegion;
    param['btStartRegion'] = btStartRegion;
    param['btEndRegion'] = btEndRegion;

    return await methodChannel.invokeMethod<int>('setFrequencyRegion', param);
  }

  @override
  Future<int?> getOutputPower() async {
    return await methodChannel.invokeMethod<int>('getOutputPower');
  }

  @override
  Future<int?> setOutputPower(int power) async {
    Map<String, dynamic> param = <String, dynamic>{};
    param['power'] = power;
    return await methodChannel.invokeMethod<int>('setOutputPower', param);
  }

  @override
  Future<String?> getFirmwareVersion() async {
    return await methodChannel.invokeMethod<String>('getFirmwareVersion');
  }

  @override
  Future<int?> getQueryMode() async {
    return await methodChannel.invokeMethod<int>('getQueryMode');
  }

  @override
  Future<void> setQueryMode(int mode) async {
    Map<String, dynamic> param = <String, dynamic>{};
    param['mode'] = mode;
    return await methodChannel.invokeMethod('setQueryMode', param);
  }

  @override
  Future<int?> lockbyTID(int tidlen, Uint8List tid, int btMemBank,
      int btLockType, Uint8List btAryPassWord) async {
    Map<String, dynamic> param = <String, dynamic>{};
    param['tidlen'] = tidlen;
    param['tid'] = tid;
    param['btMemBank'] = btMemBank;
    param['btLockType'] = btLockType;
    param['btAryPassWord'] = btAryPassWord;
    return await methodChannel.invokeMethod<int>('lockbyTID', param);
  }

  @override
  Future<int?> lockTag(String epc, Uint8List btAryPassWord, int btMemBank,
      int btLockType) async {
    Map<String, dynamic> param = <String, dynamic>{};
    param['epc'] = epc;
    param['btAryPassWord'] = btAryPassWord;
    param['btMemBank'] = btMemBank;
    param['btLockType'] = btLockType;
    return await methodChannel.invokeMethod<int>('lockTag', param);
  }

  @override
  Future<int?> killbyTID(int tidlen, Uint8List tid, Uint8List btAryPassWord) async {
    Map<String, dynamic> param = <String, dynamic>{};
    param['tidlen'] = tidlen;
    param['tid'] = tid;
    param['btAryPassWord'] = btAryPassWord;
    return await methodChannel.invokeMethod<int>('killbyTID', param);
  }

  @override
  Future<int?> killTag(String epc, Uint8List btAryPassWord) async {
    Map<String, dynamic> param = <String, dynamic>{};
    param['epc'] = epc;
    param['btAryPassWord'] = btAryPassWord;
    return await methodChannel.invokeMethod<int>('killTag', param);
  }

  @override
  Future<int?> WriteEPC(int epcLen, Uint8List epc, Uint8List password) async {
    Map<String, dynamic> param = <String, dynamic>{};
    param['epc'] = epc;
    param['epcLen'] = epcLen;
    param['password'] = password;
    return await methodChannel.invokeMethod<int>('WriteEPC', param);
  }

  @override
  Future<int?> writeTagByTid(String tidStr, int mem, int wordPtr,
      Uint8List password, String data) async {
    Map<String, dynamic> param = <String, dynamic>{};
    param['tidStr'] = tidStr;
    param['mem'] = mem;
    param['wordPtr'] = wordPtr;
    param['password'] = password;
    param['data'] = data;

    return await methodChannel.invokeMethod<int>('writeTagByTid', param);
  }

  @override
  Future<int?> writeTag(String epc, Uint8List btAryPassWord, int btMemBank,
      int btWordAdd, int btWordCnt, Uint8List btAryData) async {
    Map<String, dynamic> param = <String, dynamic>{};
    param['epc'] = epc;
    param['btAryPassWord'] = btAryPassWord;
    param['btMemBank'] = btMemBank;
    param['btWordAdd'] = btWordAdd;
    param['btWordCnt'] = btWordCnt;
    param['btAryData'] = btAryData;

    return await methodChannel.invokeMethod<int>('writeTag', param);
  }

  @override
  Future<int?> inventorySingle() async {
    return await methodChannel.invokeMethod<int>('inventorySingle');
  }

  @override
  Future<String?> readDataByTid(
      String tidStr, int mem, int wordPtr, int num, String password) async {
    Map<String, dynamic> param = <String, dynamic>{};
    param['tidStr'] = tidStr;
    param['mem'] = mem;
    param['wordPtr'] = wordPtr;
    param['num'] = num;
    param['password'] = password;
    return await methodChannel.invokeMethod<String>('readDataByTid', param);
  }

  @override
  Future<String?> readTag(String epc, int memBank, int wordAdd, int wordCnt,
      Uint8List pwArr) async {
    Map<String, dynamic> param = <String, dynamic>{};
    param['epc'] = epc;
    param['memBank'] = memBank;
    param['wordAdd'] = wordAdd;
    param['wordCnt'] = wordCnt;
    param['pwArr'] = pwArr;
    return await methodChannel.invokeMethod<String>('readTag', param);
  }

  @override
  Future<bool?> isConnected() async {
    return await methodChannel.invokeMethod<bool>('isConnected');
  }

  @override
  Future<void> disConnect() async {
    return await methodChannel.invokeMethod('disConnect');
  }
}

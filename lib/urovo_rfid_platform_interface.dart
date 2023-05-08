import 'dart:typed_data';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'urovo_rfid_method_channel.dart';

abstract class UrovoRfidPlatform extends PlatformInterface {
  /// Constructs a UrovoRfidPlatform.
  UrovoRfidPlatform() : super(token: _token);

  static final Object _token = Object();

  static UrovoRfidPlatform _instance = MethodChannelUrovoRfid();

  /// The default instance of [UrovoRfidPlatform] to use.
  ///
  /// Defaults to [MethodChannelUrovoRfid].
  static UrovoRfidPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [UrovoRfidPlatform] when
  /// they register themselves.
  static set instance(UrovoRfidPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> init() async {
    throw UnimplementedError('init() has not been implemented.');
  }

  Future<void> release() async {
    throw UnimplementedError('release() has not been implemented.');
  }

  Future<int?> startInventory(int session) {
    throw UnimplementedError('startInventory() has not been implemented.');
  }

  Future<int?> stopInventory() {
    throw UnimplementedError('stopInventory() has not been implemented.');
  }

  Future<void> disConnect() async {
    throw UnimplementedError('disConnect() has not been implemented.');
  }

  Future<bool?> isConnected() async {
    throw UnimplementedError('isConnected() has not been implemented.');
  }

  Future<String?> readTag(
      String epc, int memBank, int wordAdd, int wordCnt, Uint8List pwArr) {
    throw UnimplementedError('readTag() has not been implemented.');
  }

  Future<String?> readDataByTid(
      String tidStr, int mem, int wordPtr, int num, String password) {
    throw UnimplementedError('readDataByTid() has not been implemented.');
  }

  Future<int?> inventorySingle() {
    throw UnimplementedError('inventorySingle() has not been implemented.');
  }

  Future<int?> writeTag(String epc, Uint8List btAryPassWord, int btMemBank,
      int btWordAdd, int btWordCnt, Uint8List btAryData) {
    throw UnimplementedError('writeTag() has not been implemented.');
  }

  Future<int?> writeTagByTid(
      String tidStr, int mem, int wordPtr, Uint8List password, String data) {
    throw UnimplementedError('writeTagByTid() has not been implemented.');
  }

  Future<int?> WriteEPC(int epcLen, Uint8List epc, Uint8List password) {
    throw UnimplementedError('WriteEPC() has not been implemented.');
  }

  Future<int?> killTag(String epc, Uint8List btAryPassWord) {
    throw UnimplementedError('killTag() has not been implemented.');
  }


  Future<int?> killbyTID(int tidlen, Uint8List tid,  Uint8List btAryPassWord) {
    throw UnimplementedError('killbyTID() has not been implemented.');
  }
  Future<int?> lockTag(
      String epc, Uint8List btAryPassWord, int btMemBank, int btLockType) {
    throw UnimplementedError('lockTag() has not been implemented.');
  }

  Future<int?> lockbyTID(int tidlen, Uint8List tid, int btMemBank,
      int btLockType, Uint8List btAryPassWord) {
    throw UnimplementedError('lockbyTID() has not been implemented.');
  }

  Future<void> setQueryMode(int mode) async {
    throw UnimplementedError('setQueryMode() has not been implemented.');
  }

  Future<int?> getQueryMode() {
    throw UnimplementedError('getQueryMode() has not been implemented.');
  }

  Future<String?> getFirmwareVersion() {
    throw UnimplementedError('getFirmwareVersion() has not been implemented.');
  }

  Future<int?> setOutputPower(int power) {
    throw UnimplementedError('setOutputPower() has not been implemented.');
  }

  Future<int?> getOutputPower() {
    throw UnimplementedError('getOutputPower() has not been implemented.');
  }

  Future<int?> setFrequencyRegion(
      int btRegion, int btStartRegion, int btEndRegion) {
    throw UnimplementedError('setFrequencyRegion() has not been implemented.');
  }

  Future<String?> getFrequencyRegion() {
    throw UnimplementedError('getFrequencyRegion() has not been implemented.');
  }

  Future<void> addMask(int mem, int startAddress, int len, String data) async {
    throw UnimplementedError('addMask() has not been implemented.');
  }

  Future<void> clearMask() async {
    throw UnimplementedError('clearMask() has not been implemented.');
  }

  Future<String?> getModuleFirmware() {
    throw UnimplementedError('getModuleFirmware() has not been implemented.');
  }

  Future<int?> setScanInterval(int interval) {
    throw UnimplementedError('setScanInterval() has not been implemented.');
  }

  Future<int?> getScanInterval() {
    throw UnimplementedError('getScanInterval() has not been implemented.');
  }

  Future<void> startRead() async {
    throw UnimplementedError('startRead() has not been implemented.');
  }

  Future<void> scanRfid() async {
    throw UnimplementedError('scanRfid() has not been implemented.');
  }

  Future<void> setInventoryParameter(String params) async {
    throw UnimplementedError(
        'setInventoryParameter() has not been implemented.');
  }

  Future<String?> getDeviceId() {
    throw UnimplementedError('getDeviceId() has not been implemented.');
  }

  Future<int?> setCustomRegion(
      int flags, int freSpace, int freNum, int startFre) {
    throw UnimplementedError('setCustomRegion() has not been implemented.');
  }

  Future<String?> getCustomRegion() {
    throw UnimplementedError('getCustomRegion() has not been implemented.');
  }

  Future<int?> setProfile(int param) {
    throw UnimplementedError('setProfile() has not been implemented.');
  }

  Future<int?> setRange(int range) {
    throw UnimplementedError('setRange() has not been implemented.');
  }

  Future<int?> getRange() {
    throw UnimplementedError('getRange() has not been implemented.');
  }

  Future<int?> getReaderType() {
    throw UnimplementedError('getReaderType() has not been implemented.');
  }

  Future<String?> getReaderTemperature() {
    throw UnimplementedError(
        'getReaderTemperature() has not been implemented.');
  }

  Future<int?> iso180006BInventory() {
    throw UnimplementedError('iso180006BInventory() has not been implemented.');
  }

  Future<int?> iso180006BLockTag(Uint8List btAryUID, int btWordAdd) {
    throw UnimplementedError('iso180006BInventory() has not been implemented.');
  }

  Future<int?> iso180006BQueryLockTag(Uint8List btAryUID, int btWordAdd) {
    throw UnimplementedError(
        'iso180006BQueryLockTag() has not been implemented.');
  }

  Future<int?> iso180006BReadTag(
      Uint8List btAryUID, int btWordAdd, int btWordCnt) {
    throw UnimplementedError('iso180006BReadTag() has not been implemented.');
  }

  Future<int?> iso180006BWriteTag(
      Uint8List btAryUID, int btWordAdd, int btWordCnt, Uint8List btAryBuffer) {
    throw UnimplementedError('iso180006BWriteTag() has not been implemented.');
  }
}

import 'dart:typed_data';

import 'urovo_rfid_platform_interface.dart';

class UrovoRfid {
  Future<void> init() async {
    await UrovoRfidPlatform.instance.init();
  }

  Future<void> release() async {
    await UrovoRfidPlatform.instance.release();
  }

  Future<int?> startInventory(int session) {
    return UrovoRfidPlatform.instance.startInventory(session);
  }

  Future<int?> stopInventory() {
    return UrovoRfidPlatform.instance.stopInventory();
  }

  Future<void> disConnect() async {
    UrovoRfidPlatform.instance.disConnect();
  }

  Future<bool?> isConnected() async {
    return UrovoRfidPlatform.instance.isConnected();
  }

  Future<String?> readTag(
      String epc, int memBank, int wordAdd, int wordCnt, Uint8List pwArr) {
    return UrovoRfidPlatform.instance
        .readTag(epc, memBank, wordAdd, wordCnt, pwArr);
  }

  Future<String?> readDataByTid(
      String tidStr, int mem, int wordPtr, int num, String password) {
    return UrovoRfidPlatform.instance
        .readDataByTid(tidStr, mem, wordPtr, num, password);
  }

  Future<int?> inventorySingle() {
    return UrovoRfidPlatform.instance.inventorySingle();
  }

  Future<int?> writeTag(String epc, Uint8List btAryPassWord, int btMemBank,
      int btWordAdd, int btWordCnt, Uint8List btAryData) {
    return UrovoRfidPlatform.instance.writeTag(
        epc, btAryPassWord, btMemBank, btWordAdd, btWordCnt, btAryData);
  }

  Future<int?> writeTagByTid(
      String tidStr, int mem, int wordPtr, Uint8List password, String wdata) {
    return UrovoRfidPlatform.instance
        .writeTagByTid(tidStr, mem, wordPtr, password, wdata);
  }

  Future<int?> WriteEPC(int epclen, Uint8List epc, Uint8List password) {
    return UrovoRfidPlatform.instance.WriteEPC(epclen, epc, password);
  }

  Future<int?> killTag(String epc, Uint8List btAryPassWord) {
    return UrovoRfidPlatform.instance.killTag(epc, btAryPassWord);
  }

  Future<int?> killbyTID(int tidlen, Uint8List tid, Uint8List btAryPassWord) {
    return UrovoRfidPlatform.instance
        .killbyTID(tidlen, tid, btAryPassWord);
  }

  Future<int?> lockTag(
      String epc, Uint8List btAryPassWord, int btMemBank, int btLockType) {
    return UrovoRfidPlatform.instance
        .lockTag(epc, btAryPassWord, btMemBank, btLockType);
  }

  Future<int?> lockbyTID(int tidlen, Uint8List tid, int btMemBank,
      int btLockType, Uint8List btAryPassWord) {
    return UrovoRfidPlatform.instance
        .lockbyTID(tidlen, tid, btMemBank, btLockType, btAryPassWord);
  }

  Future<void> setQueryMode(int mode) async {
    return UrovoRfidPlatform.instance.setQueryMode(mode);
  }

  Future<int?> getQueryMode() {
    return UrovoRfidPlatform.instance.getQueryMode();
  }

  Future<String?> getFirmwareVersion() {
    return UrovoRfidPlatform.instance.getFirmwareVersion();
  }

  Future<int?> setOutputPower(int powe) {
    return UrovoRfidPlatform.instance.setOutputPower(powe);
  }

  Future<int?> getOutputPower() {
    return UrovoRfidPlatform.instance.getOutputPower();
  }

  Future<int?> setFrequencyRegion(
      int btRegion, int btStartRegion, int btEndRegion) {
    return UrovoRfidPlatform.instance
        .setFrequencyRegion(btRegion, btStartRegion, btEndRegion);
  }

  Future<String?> getFrequencyRegion() {
    return UrovoRfidPlatform.instance.getFrequencyRegion();
  }

  Future<void> addMask(int mem, int startAddress, int len, String data) async {
    return UrovoRfidPlatform.instance.addMask(mem, startAddress, len, data);
  }

  Future<void> clearMask() async {
    return UrovoRfidPlatform.instance.clearMask();
  }

  Future<String?> getModuleFirmware() {
    return UrovoRfidPlatform.instance.getModuleFirmware();
  }

  Future<int?> setScanInterval(int interval) {
    return UrovoRfidPlatform.instance.setScanInterval(interval);
  }

  Future<int?> getScanInterval() {
    return UrovoRfidPlatform.instance.getScanInterval();
  }

  Future<void> startRead() async {
    return UrovoRfidPlatform.instance.startRead();
  }

  Future<void> scanRfid() async {
    return UrovoRfidPlatform.instance.scanRfid();
  }

  Future<void> setInventoryParameter(String params) async {
    return UrovoRfidPlatform.instance.setInventoryParameter(params);
  }

  Future<String?> getDeviceId() {
    return UrovoRfidPlatform.instance.getDeviceId();
  }

  Future<int?> setCustomRegion(
      int flags, int freSpace, int freNum, int startFre) {
    return UrovoRfidPlatform.instance
        .setCustomRegion(flags, freSpace, freNum, startFre);
  }

  Future<String?> getCustomRegion() {
    return UrovoRfidPlatform.instance.getCustomRegion();
  }

  Future<int?> setProfile(int param) {
    return UrovoRfidPlatform.instance.setProfile(param);
  }

  Future<int?> setRange(int range) {
    return UrovoRfidPlatform.instance.setRange(range);
  }

  Future<int?> getRange() {
    return UrovoRfidPlatform.instance.getRange();
  }

  Future<int?> getReaderType() {
    return UrovoRfidPlatform.instance.getReaderType();
  }

  Future<String?> getReaderTemperature() {
    return UrovoRfidPlatform.instance.getReaderTemperature();
  }

  Future<int?> iso180006BInventory() {
    return UrovoRfidPlatform.instance.iso180006BInventory();
  }

  Future<int?> iso180006BLockTag(Uint8List btAryUID, int btWordAdd) {
    return UrovoRfidPlatform.instance.iso180006BLockTag(btAryUID, btWordAdd);
  }

  Future<int?> iso180006BQueryLockTag(Uint8List btAryUID, int btWordAdd) {
    return UrovoRfidPlatform.instance
        .iso180006BQueryLockTag(btAryUID, btWordAdd);
  }

  Future<int?> iso180006BReadTag(
      Uint8List btAryUID, int btWordAdd, int btWordCnt) {
    return UrovoRfidPlatform.instance
        .iso180006BReadTag(btAryUID, btWordAdd, btWordCnt);
  }

  Future<int?> iso180006BWriteTag(
      Uint8List btAryUID, int btWordAdd, int btWordCnt, Uint8List btAryBuffer) {
    return UrovoRfidPlatform.instance
        .iso180006BWriteTag(btAryUID, btWordAdd, btWordCnt, btAryBuffer);
  }
}

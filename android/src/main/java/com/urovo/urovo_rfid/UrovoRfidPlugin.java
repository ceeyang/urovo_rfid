package com.urovo.urovo_rfid;

import android.app.Activity;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;

import androidx.annotation.NonNull;

import com.google.gson.Gson;
import com.ubx.usdk.USDKManager;
import com.ubx.usdk.bean.CustomRegionBean;
import com.ubx.usdk.bean.RfidParameter;
import com.ubx.usdk.rfid.RfidManager;
import com.ubx.usdk.rfid.aidl.IRfidCallback;

import org.json.JSONObject;

import java.util.HashMap;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/**
 * UrovoRfidPlugin
 */
public class UrovoRfidPlugin implements FlutterPlugin, ActivityAware, MethodCallHandler {
    private static final String EVENT_NAME = "plugin_rfid_event";
    private static final String EVENT_INIT = "event_init";
    private static final String EVENT_BATTERY = "event_battery";
    private static final String EVENT_MODULES_STATUS = "event_modules_status";
    private static final String EVENT_INVENTORY_TAG = "event_inventory_tag";
    private static final String EVENT_INVENTORY_TAG_END = "event_inventory_tag_end";
    private static final int ERR_CODE = -19;

    private final String TAG = UrovoRfidPlugin.class.getSimpleName();
    private Activity activity;//缓存上下文
    private USDKManager usdkManager;
    private RfidManager rfidManager;

    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private MethodChannel channel;
    // 事件派发对象
    private EventChannel.EventSink eventSink = null;
    private final IRfidCallback rfidCallback = new IRfidCallback() {

        @Override
        public void onInventoryTag(String EPC, String TID, String strRSSI) {
            try {
                JSONObject jsonObject = new JSONObject();
                jsonObject.put("EPC", EPC);
                jsonObject.put("TID", TID);
                jsonObject.put("RSSI", strRSSI);

                sendEvent(getMap(EVENT_INVENTORY_TAG, jsonObject.toString()));
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        @Override
        public void onInventoryTagEnd() {
            sendEvent(getMap(EVENT_INVENTORY_TAG_END, ""));
        }
    };

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "urovo_rfid");
        channel.setMethodCallHandler(this);
        //
        initEventSink(flutterPluginBinding);
        //
        usdkManager = USDKManager.getInstance(flutterPluginBinding.getApplicationContext());


    }

    private void initEventSink(FlutterPluginBinding flutterPluginBinding) {
        log("initEventSink");
        // 初始事件
        EventChannel eventChannel = new EventChannel(flutterPluginBinding.getBinaryMessenger(), EVENT_NAME);
        eventChannel.setStreamHandler(new EventChannel.StreamHandler() {
            @Override
            public void onListen(Object arguments, EventChannel.EventSink events) {
                log("initEventSink=====onListen");
                eventSink = events;
            }

            @Override
            public void onCancel(Object arguments) {
                log("initEventSink=====onCancel");
                eventSink = null;
            }
        });
    }


    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        String method = call.method;
        Object arguments = call.arguments;
        log("onMethodCall=====method:" + method);
        log("onMethodCall=====arguments:" + arguments);

        if (method.equals("init")) {
            init();
            return;
        } else if (method.equals("release")) {
            release();
            return;
        }
        // rfidManager inited or not
        if (!checkInit(result)) {
            return;
        }
        //
        if (method.equals("startInventory")) {
            startInventory(call, result);
        } else if (method.equals("stopInventory")) {
            stopInventory(result);
        } else if (method.equals("disConnect")) {
            disConnect();
        } else if (method.equals("isConnected")) {
            isConnected(result);
        } else if (method.equals("readTag")) {
            readTag(call, result);
        } else if (method.equals("readDataByTid")) {
            readDataByTid(call, result);
        } else if (method.equals("inventorySingle")) {
            inventorySingle(result);
        } else if (method.equals("writeTag")) {
            writeTag(call, result);
        } else if (method.equals("writeTagByTid")) {
            writeTagByTid(call, result);
        } else if (method.equals("WriteEPC")) {
            WriteEPC(call, result);
        } else if (method.equals("killTag")) {
            killTag(call, result);
        } else if (method.equals("killbyTID")) {
            killbyTID(call, result);
        } else if (method.equals("lockTag")) {
            lockTag(call, result);
        } else if (method.equals("lockbyTID")) {
            lockbyTID(call, result);
        } else if (method.equals("setQueryMode")) {
            setQueryMode(call);
        } else if (method.equals("getQueryMode")) {
            getQueryMode(result);
        } else if (method.equals("getFirmwareVersion")) {
            getFirmwareVersion(result);
        } else if (method.equals("setOutputPower")) {
            setOutputPower(call, result);
        } else if (method.equals("getOutputPower")) {
            getOutputPower(result);
        } else if (method.equals("setFrequencyRegion")) {
            setFrequencyRegion(call, result);
        } else if (method.equals("getFrequencyRegion")) {
            getFrequencyRegion(result);
        } else if (method.equals("addMask")) {
            addMask(call, result);
        } else if (method.equals("clearMask")) {
            clearMask();
        } else if (method.equals("getModuleFirmware")) {
            getModuleFirmware(result);
        } else if (method.equals("setScanInterval")) {
            setScanInterval(call, result);
        } else if (method.equals("getScanInterval")) {
            getScanInterval(result);
        } else if (method.equals("startRead")) {
            startRead();
        } else if (method.equals("scanRfid")) {
            scanRfid();
        } else if (method.equals("setInventoryParameter")) {
            setInventoryParameter(call);
        } else if (method.equals("getDeviceId")) {
            getDeviceId(result);
        } else if (method.equals("setCustomRegion")) {
            setCustomRegion(call, result);
        } else if (method.equals("getCustomRegion")) {
            getCustomRegion(result);
        } else if (method.equals("setProfile")) {
            setProfile(call, result);
        } else if (method.equals("setRange")) {
            setRange(call, result);
        } else if (method.equals("getRange")) {
            getRange(result);
        } else if (method.equals("getReaderType")) {
            getReaderType(result);
        } else if (method.equals("getReaderTemperature")) {
            getReaderTemperature(result);
        } else if (method.equals("iso180006BInventory")) {
            iso180006BInventory(result);
        } else if (method.equals("iso180006BLockTag")) {
            iso180006BLockTag(call, result);
        } else if (method.equals("iso180006BQueryLockTag")) {
            iso180006BQueryLockTag(call, result);
        } else if (method.equals("iso180006BReadTag")) {
            iso180006BReadTag(call, result);
        } else if (method.equals("iso180006BWriteTag")) {
            iso180006BWriteTag(call, result);
        } else {
            result.notImplemented();
        }
    }

    private void killbyTID(MethodCall call, Result result) {
        Integer tidlen = call.argument("tidlen");
        byte[] tid = call.argument("tid");
        byte[] btAryPassWord = call.argument("btAryPassWord");
        if (tidlen == null) {
            result.success(ERR_CODE);
            return;
        }
        int ret = rfidManager.killTagByTid(tidlen.byteValue(), tid, btAryPassWord);
        result.success(ret);
    }

    private void lockbyTID(MethodCall call, Result result) {
        Integer tidlen = call.argument("tidlen");
        byte[] tid = call.argument("tid");
        Integer btMemBank = call.argument("btMemBank");
        Integer btLockType = call.argument("btLockType");
        byte[] btAryPassWord = call.argument("btAryPassWord");
        if (tidlen == null || btMemBank == null || btLockType == null) {
            result.success(ERR_CODE);
            return;
        }
        int ret = rfidManager.lockbyTID(tidlen.byteValue(), tid, btMemBank.byteValue(),
                btLockType.byteValue(), btAryPassWord);
        result.success(ret);
    }

    private void disConnect() {
        rfidManager.disConnect();
    }

    private void isConnected(Result result) {
        boolean ret = rfidManager.isConnected();
        result.success(ret);
    }

    private void readTag(MethodCall call, Result result) {
        String epc = call.argument("epc");
        Integer memBank = call.argument("memBank");
        Integer wordAdd = call.argument("wordAdd");
        Integer wordCnt = call.argument("wordCnt");
        byte[] pwArr = call.argument("pwArr");
        if (memBank == null || wordAdd == null || wordCnt == null) {
            result.success(ERR_CODE+"");
            return;
        }
        String ret = rfidManager.readTag(epc, memBank.byteValue(),
                wordAdd.byteValue(), wordCnt.byteValue(), pwArr);
        result.success(ret);
    }

    private void readDataByTid(MethodCall call, Result result) {
        String tidStr = call.argument("tidStr");
        Integer mem = call.argument("mem");
        Integer wordPtr = call.argument("wordPtr");
        Integer num = call.argument("num");
        String password = call.argument("password");
        if (mem == null || wordPtr == null || num == null) {
            result.success(ERR_CODE+"");
            return;
        }
        String ret = rfidManager.readDataByTid(tidStr, mem.byteValue(), wordPtr.byteValue(),
                num.byteValue(), password);
        result.success(ret);
    }

    private void inventorySingle(Result result) {
        int ret = rfidManager.inventorySingle();
        result.success(ret);
    }

    private void writeTag(MethodCall call, Result result) {
        String epc = call.argument("epc");
        byte[] btAryPassWord = call.argument("btAryPassWord");
        Integer btMemBank = call.argument("btMemBank");
        Integer btWordAdd = call.argument("btWordAdd");
        Integer btWordCnt = call.argument("btWordCnt");
        byte[] btAryData = call.argument("btAryData");
        if (btMemBank == null || btWordAdd == null || btWordCnt == null) {
            result.success(ERR_CODE);
            return;
        }
        int ret = rfidManager.writeTag(epc, btAryPassWord, btMemBank.byteValue(),
                btWordAdd.byteValue(), btWordCnt.byteValue(), btAryData);
        result.success(ret);
    }

    private void writeTagByTid(MethodCall call, Result result) {
        String tidStr = call.argument("tidStr");
        Integer mem = call.argument("mem");
        Integer wordPtr = call.argument("wordPtr");
        byte[] password = call.argument("password");
        String data = call.argument("data");
        if (mem == null || wordPtr == null) {
            result.success(ERR_CODE);
            return;
        }
        int ret = rfidManager.writeTagByTid(tidStr, mem.byteValue(), wordPtr.byteValue(), password, data);
        result.success(ret);
    }

    private void WriteEPC(MethodCall call, Result result) {
        Integer epcLen = call.argument("epcLen");
        byte[] epc = call.argument("epc");
        byte[] password = call.argument("password");
        if (epcLen == null) {
            result.success(ERR_CODE);
            return;
        }
        int ret = rfidManager.writeEpc(epcLen.byteValue(), epc, password);
        result.success(ret);
    }

    private void killTag(MethodCall call, Result result) {
        String epc = call.argument("epc");
        byte[] btAryPassWord = call.argument("btAryPassWord");
        int ret = rfidManager.killTag(epc, btAryPassWord);
        result.success(ret);
    }

    private void lockTag(MethodCall call, Result result) {
        String epc = call.argument("epc");
        byte[] btAryPassWord = call.argument("btAryPassWord");
        Integer btMemBank = call.argument("btMemBank");
        Integer btLockType = call.argument("btLockType");
        if (btMemBank == null || btLockType == null) {
            result.success(ERR_CODE);
            return;
        }
        int ret = rfidManager.lockTag(epc, btAryPassWord, btMemBank.byteValue(), btLockType.byteValue());
        result.success(ret);
    }

    private void setQueryMode(MethodCall call) {
        Integer mode = call.argument("mode");
        if (mode == null) {
            return;
        }
        rfidManager.setQueryMode(mode);
    }

    private void getQueryMode(Result result) {
        int ret = rfidManager.getQueryMode();
        result.success(ret);
    }

    private void getFirmwareVersion(Result result) {
        String ret = rfidManager.getFirmwareVersion();
        result.success(ret);
    }

    private void setOutputPower(MethodCall call, Result result) {
        Integer power = call.argument("power");
        if (power == null) {
            result.success(ERR_CODE);
            return;
        }
        int ret = rfidManager.setOutputPower(power.byteValue());
        result.success(ret);
    }

    private void getOutputPower(Result result) {
        int ret = rfidManager.getOutputPower();
        result.success(ret);
    }

    private void setFrequencyRegion(MethodCall call, Result result) {
        Integer btRegion = call.argument("btRegion");
        Integer btStartRegion = call.argument("btStartRegion");
        Integer btEndRegion = call.argument("btEndRegion");
        if (btRegion == null || btStartRegion == null || btEndRegion == null) {
            result.success(ERR_CODE);
            return;
        }
        int ret = rfidManager.setFrequencyRegion(btRegion.byteValue(), btStartRegion.byteValue(), btEndRegion.byteValue());
        result.success(ret);
    }

    private void getFrequencyRegion(Result result) {
        String ret = rfidManager.getModuleFirmware();
        result.success(ret);
    }

    private void addMask(MethodCall call, Result result) {
        Integer mem = call.argument("mem");
        Integer startAddress = call.argument("startAddress");
        Integer len = call.argument("len");
        String data = call.argument("data");
        rfidManager.addMask(mem == null ? 0 : mem, startAddress == null ? 0 : startAddress, len == null ? 0 : len, data);

    }

    private void clearMask() {
        rfidManager.clearMask();
    }

    private void getModuleFirmware(Result result) {
        String ret = rfidManager.getModuleFirmware();
        result.success(ret);
    }

    private void setScanInterval(MethodCall call, Result result) {
        Integer arg = call.argument("interval");
        int ret = rfidManager.setScanInterval(arg == null ? 10 : arg);
        result.success(ret);
    }

    private void getScanInterval(Result result) {
        int ret = rfidManager.getScanInterval();
        result.success(ret);
    }

    private void startRead() {
        rfidManager.startRead();
    }

    private void scanRfid() {
        rfidManager.scanRfid();
    }

    private void setInventoryParameter(MethodCall call) {
        String params = call.argument("params");
        RfidParameter rfidParameter = new Gson().fromJson(params, RfidParameter.class);
        if (rfidParameter == null) {
            return;
        }
        rfidManager.setInventoryParameter(rfidParameter);
    }

    private void getDeviceId(Result result) {
        String ret = rfidManager.getDeviceId();
        result.success(ret);
    }

    private void setCustomRegion(MethodCall call, Result result) {
        Integer flags = call.argument("flags");
        Integer freSpace = call.argument("freSpace");
        Integer freNum = call.argument("freNum");
        Integer startFre = call.argument("startFre");

        int ret = rfidManager.setCustomRegion((byte) (flags == null ? 0 : flags),
                freSpace == null ? 0 : freSpace,
                freNum == null ? 0 : freNum,
                startFre == null ? 0 : startFre
        );
        result.success(ret);
    }

    private void getCustomRegion(Result result) {
        CustomRegionBean customRegion = rfidManager.getCustomRegion();
        result.success(new Gson().toJson(customRegion));
    }

    private void setProfile(MethodCall call, Result result) {
        Integer arg = call.argument("param");
        if (arg == null) {
            result.success(ERR_CODE);
            return;
        }
        int ret = rfidManager.setProfile(arg.byteValue());
        result.success(ret);
    }

    private void setRange(MethodCall call, Result result) {
        Integer range = call.argument("range");
        if (range == null) {
            result.success(ERR_CODE);
            return;
        }
        int ret = rfidManager.setRange(range);
        result.success(ret);
    }

    private void getRange(Result result) {
        int ret = rfidManager.getRange();
        result.success(ret);
    }

    private void getReaderType(Result result) {
        int ret = rfidManager.getReaderType();
        result.success(ret);
    }

    private void getReaderTemperature(Result result) {
        String ret = rfidManager.getReaderTemperature();
        result.success(ret);
    }

    private void iso180006BInventory(Result result) {
        int ret = rfidManager.iso180006BInventory();
        result.success(ret);
    }

    private void iso180006BLockTag(MethodCall call, Result result) {
        byte[] btAryUID = call.argument("btAryUID");
        Integer btWordAdd = call.argument("btWordAdd");
        int ret = rfidManager.iso180006BLockTag(btAryUID,
                (byte) (btWordAdd == null ? 0 : btWordAdd));
        result.success(ret);
    }

    private void iso180006BQueryLockTag(MethodCall call, Result result) {
        byte[] btAryUID = call.argument("btAryUID");
        Integer btWordAdd = call.argument("btWordAdd");
        int ret = rfidManager.iso180006BQueryLockTag(btAryUID,
                (byte) (btWordAdd == null ? 0 : btWordAdd));
        result.success(ret);
    }

    private void iso180006BReadTag(MethodCall call, Result result) {
        byte[] btAryUID = call.argument("btAryUID");
        Integer btWordAdd = call.argument("btWordAdd");
        Integer btWordCnt = call.argument("btWordCnt");
        int ret = rfidManager.iso180006BReadTag(btAryUID,
                (byte) (btWordAdd == null ? 0 : btWordAdd),
                (byte) (btWordCnt == null ? 0 : btWordCnt));
        result.success(ret);
    }

    private void iso180006BWriteTag(MethodCall call, Result result) {
        byte[] btAryUID = call.argument("btAryUID");
        Integer btWordAdd = call.argument("btWordAdd");
        Integer btWordCnt = call.argument("btWordCnt");
        byte[] btAryBuffer = call.argument("btAryBuffer");
        int ret = rfidManager.iso180006BWriteTag(btAryUID,
                (byte) (btWordAdd == null ? 0 : btWordAdd),
                (byte) (btWordCnt == null ? 0 : btWordCnt),
                btAryBuffer);
        result.success(ret);
    }

    private void stopInventory(Result result) {
        rfidManager.unregisterCallback(rfidCallback);
        int stopInventory = rfidManager.stopInventory();
        result.success(stopInventory);
    }

    /**
     * check if inited or not
     *
     * @param result
     * @return
     */
    private boolean checkInit(Result result) {
        if (rfidManager == null) {
            Log.d(TAG, "rfidManager == null");
            result.error("-99", "RFIDManager was not inited", "");
            return false;
        }
        return true;
    }

    private void startInventory(MethodCall call, Result result) {
        Integer session = call.argument("session");
        rfidManager.registerCallback(rfidCallback);
        int startInventory = rfidManager.startInventory((byte) (session == null ? 0 : session));
        result.success(startInventory);
    }

    private void release() {
        if (rfidManager != null) {
            rfidManager.release();
            rfidManager = null;
        }
        if (usdkManager != null) {
            usdkManager.release();
        }
    }

    private void init() {
        log("doInit");
        usdkManager.init(activity, status -> {
            log("InitListener status:" + status);
            if (status == USDKManager.STATUS.SUCCESS) {
                rfidManager = usdkManager.getRfidManager();
            }
            int result = status == USDKManager.STATUS.SUCCESS ? 0 : -1;
            //事件派发
            sendEvent(getMap(EVENT_INIT, result));
        });
    }

    /**
     * 回调事件数据
     *
     * @param event
     * @param result
     * @return
     */
    private HashMap<String, Object> getMap(String event, Object result) {
        HashMap<String, Object> map = new HashMap<>();
        map.put(event, result);
        return map;
    }

    /**
     * 回调事件
     *
     * @param map
     */
    private void sendEvent(HashMap<String, Object> map) {
        new Handler(Looper.getMainLooper()).post(new Runnable() {
            @Override
            public void run() {
                if (eventSink != null) {
                    log("eventSinkInit.success:" + map);
                    eventSink.success(map);
                } else {
                    log("eventSink === null");
                }
            }
        });
    }


    //////////////////////////////////////
    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        activity = binding.getActivity();
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {

    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
        activity = binding.getActivity();
    }

    @Override
    public void onDetachedFromActivity() {
//        activity = null;
        release();
    }

    private void log(String s) {
        Log.d(TAG, ">> " + s);
    }

}

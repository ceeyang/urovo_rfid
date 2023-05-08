import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:urovo_rfid/urovo_rfid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final urovoRfidPlugin = UrovoRfid();
  String info = "";

  @override
  void initState() {
    super.initState();
    _initEvent();
  }

  void _init() async {
    setState(() {
      info = "_init";
    });
    await urovoRfidPlugin.init();
  }

  void _startInventory() async {
    setState(() {
      info = "_startInventory";
    });
    int? startInventory = await urovoRfidPlugin.startInventory(0);
    setState(() {
      info = "_startInventory：$startInventory";
    });
  }

  void _stopInventory() async {
    setState(() {
      info = "_stopInventory";
    });
    var stopInventory = await urovoRfidPlugin.stopInventory();
    setState(() {
      info = "_stopInventory：$stopInventory";
    });
  }

  void _readTag() async {
    setState(() {
      info = "_readTag";
    });
    String epc = "3131313131313131";
    int memBank = 1;
    int wordAdd = 2;
    int wordCnt = 8;
    var codeUnits = "31323334".codeUnits;
    Uint8List pwArr = Uint8List.fromList(codeUnits);
    String ret =
        await urovoRfidPlugin.readTag(epc, memBank, wordAdd, wordCnt, pwArr) ??
            "readTag Fail";
    setState(() {
      info = "_readTag：$ret";
    });
  }

  void _writeTag() async {
    setState(() {
      info = "_writeTag";
    });
    String epc = "3131313131313131";
    int memBank = 1;
    int wordAdd = 2;
    int wordCnt = 8;
    Uint8List pwArr = Uint8List.fromList("31323334".codeUnits);
    Uint8List datas = Uint8List.fromList("3131313131313131".codeUnits);
    var ret = await urovoRfidPlugin.writeTag(
        epc, pwArr, memBank, wordAdd, wordCnt, datas);
    setState(() {
      info = "_writeTag：$ret";
    });
  }

  void _getOutputPower() async {
    setState(() {
      info = "_getOutputPower";
    });
    var ret = await urovoRfidPlugin.getOutputPower();
    setState(() {
      info = "_getOutputPower：$ret";
    });
  }

  void _setOutputPower() async {
    setState(() {
      info = "_setOutputPower";
    });

    var ret = await urovoRfidPlugin.setOutputPower(18);
    setState(() {
      info = "_setOutputPower：$ret";
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Column(
        // Column is also a layout widget. It takes a list of children and
        // arranges them vertically. By default, it sizes itself to fit its
        // children horizontally, and tries to be as tall as its parent.
        //
        // Invoke "debug painting" (press "p" in the console, choose the
        // "Toggle Debug Paint" action from the Flutter Inspector in Android
        // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
        // to see the wireframe for each widget.
        //
        // Column has various properties to control how it sizes itself and
        // how it positions its children. Here we use mainAxisAlignment to
        // center the children vertically; the main axis here is the vertical
        // axis because Columns are vertical (the cross axis would be
        // horizontal).
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Wrap(spacing: 10, children: <Widget>[
            ElevatedButton(
              onPressed: _init,
              child: const Text("INIT"),
            ),
            ElevatedButton(
              onPressed: _startInventory,
              child: const Text("Start_Inventory"),
            ),
            ElevatedButton(
              onPressed: _stopInventory,
              child: const Text("Stop_Inventory"),
            ),
            ElevatedButton(
              onPressed: _readTag,
              child: const Text("Read_Tag"),
            ),
            ElevatedButton(
              onPressed: _writeTag,
              child: const Text("Write_Tag"),
            ),
            ElevatedButton(
              onPressed: _getOutputPower,
              child: const Text("Get_Power"),
            ),
            ElevatedButton(
              onPressed: _setOutputPower,
              child: const Text("Set_Power"),
            )
          ]),
          Row(
            children: <Widget>[
              Text(
                'INFO：$info',
                // style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _initEvent() {
    var eventChannel = const EventChannel("plugin_rfid_event");
    eventChannel.receiveBroadcastStream().listen(
        (event) {
          setState(() {
            var string = DateTime.now().toString();
            info = "$string\nEventChannel：$event";
          });
        },
        onDone: () {},
        onError: (err) {
          final PlatformException e = err;
          throw e;
        });
  }
}

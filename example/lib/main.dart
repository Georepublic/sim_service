import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:sim_service/sim_service.dart';

void main() async {
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SimData _simData;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    SimData simData;

    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      simData = await SimService.getSimData;
    } on PlatformException {
      print(simData);
    }
    print(simData.carrierName);
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _simData = simData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
            appBar: new AppBar(
              title: const Text('Plugin example app'),
            ),
            body: _simData == null
                ? Text('Loading')
                : SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                Text('carrierName: ${_simData.carrierName}'),
                                Text('countryCode: ${_simData.countryCode}'),
                                Text('networkType: ${_simData.networkType}'),
                                Text('phoneType: ${_simData.phoneType}'),
                                Text('deviceId: ${_simData.deviceId}'),
                                Text('simState: ${_simData.simState}'),
                                Text('phoneCount: ${_simData.phoneCount}'),
                                Text('phoneNumber: ${_simData.phoneNumber}'),
                                Text('simSerialNumber: ${_simData.simSerialNumber}'),
                                Text('subscriberId: ${_simData.subscriberId}'),
                              ]
                            )
                          )
                        ),
                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            children: _simData.cards.map((SimCard card) {
                              return Container(
                                child: Center(
                                  child: Column(
                                    children: <Widget>[
                                      Text('carrierName: ${card.carrierName}'),
                                      Text('displayName: ${card.displayName}'),
                                      Text('countryCode: ${card.countryCode}'),
                                      Text('mcc: ${card.mcc}'),
                                      Text('mnc: ${card.mnc}'),
                                      Text('isNetworkRoaming: ${card.isNetworkRoaming}'),
                                      Text('isDataRoaming: ${card.isDataRoaming}'),
                                      Text('simSlotIndex: ${card.simSlotIndex}'),
                                      //Text('phoneNumber: ${card.phoneNumber}'),
                                      Text('deviceId: ${card.deviceId}'),
                                      Text('simSerialNumber: ${card.simSerialNumber}'),
                                      Text('subscriptionId: ${card.subscriptionId}')
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        )
                      ],
                    ))));
  }
}

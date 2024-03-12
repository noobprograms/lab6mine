import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> stringList = [];
  List<String> toBeRemoved = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < 100; i++) {
      stringList.add(getRandom(4));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Saved Suggestions',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text(
                                'Would you like to remove \'${toBeRemoved.join(',')}\''),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    stringList.removeWhere((element) =>
                                        toBeRemoved.contains(element));
                                  });
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Yes',
                                  style: TextStyle(color: Colors.green),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'No',
                                  style: TextStyle(color: Colors.red),
                                ),
                              )
                            ],
                          ));
                },
                icon: Icon(Icons.delete))
          ],
        ),
        body: ListView(
          children: stringList
              .map((e) => GestureDetector(
                    onTap: () {
                      // showDialog(
                      //     context: context,
                      //     builder: (context) => AlertDialog(
                      //           title: Text('Would you like to remove \'$e\''),
                      //           actions: [
                      //             TextButton(
                      //               onPressed: () {
                      //                 setState(() {
                      //                   stringList.remove(e);
                      //                 });
                      //                 Navigator.pop(context);
                      //               },
                      //               child: Text(
                      //                 'Yes',
                      //                 style: TextStyle(color: Colors.green),
                      //               ),
                      //             ),
                      //             TextButton(
                      //               onPressed: () {
                      //                 Navigator.pop(context);
                      //               },
                      //               child: Text(
                      //                 'No',
                      //                 style: TextStyle(color: Colors.red),
                      //               ),
                      //             )
                      //           ],
                      //         ));
                      setState(() {
                        toBeRemoved.add(e);
                      });
                    },
                    child: ListTile(
                      leading: Text(e),
                      trailing:
                          toBeRemoved.contains(e) ? Icon(Icons.check) : null,
                    ),
                  ))
              .toList(),
        ));
  }

  String getRandom(int length) {
    const ch =
        'AaBbCcDdEeF14fGgHhIi89JjKk45LlMmNnOoPp5645458QqRrSsTtUuVvWwXxYyZz';
    Random r = Random();
    return String.fromCharCodes(
        Iterable.generate(length, (_) => ch.codeUnitAt(r.nextInt(ch.length))));
  }
}

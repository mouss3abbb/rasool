import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rasool/data.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  var loveButtonIcon = Icons.favorite_border_rounded;
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        appBar: AppBar(
          elevation: 0,
          title: const Text("رسول"),
          backgroundColor: Colors.green[400],
        ),
        body: Container(
          color: Colors.lime[100],
          width: double.infinity,
          height: double.infinity,
          child: customInfo(context),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            color: Colors.green,
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      selectedIndex = 0;
                    });
                  },
                  icon: Icon(Icons.add_box_rounded),
                  color: selectedIndex == 0
                      ? Colors.greenAccent[100]
                      : Colors.white70,
                  iconSize: selectedIndex == 0 ? 40 : 20,
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      selectedIndex = 1;
                    });
                  },
                  icon: Icon(Icons.home),
                  color: selectedIndex == 1
                      ? Colors.greenAccent[100]
                      : Colors.white70,
                  iconSize: selectedIndex == 1 ? 40 : 20,
                ),
              ],
            ),
          ),
        ));
  }

  Padding customInfo(BuildContext context) {
    var rand = Random();
    int index = rand.nextInt(data.length);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                text: data[index][0],
                style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 26,
                    fontFamily: 'Massir'),
              ),
            ),
            RichText(
              text: TextSpan(
                text: data[index][1],
                style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 22,
                    fontFamily: 'Massir'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.refresh,
                      color: Colors.redAccent,
                    )),
                IconButton(
                    onPressed: () {
                      setState(() {
                        if (loveButtonIcon == Icons.favorite_border_rounded) {
                          loveButtonIcon = Icons.favorite_rounded;
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Center(child: Text("Saved")),
                            duration: Duration(milliseconds: 700),
                            backgroundColor: Colors.redAccent,
                            elevation: 0,
                          ));
                        } else {
                          loveButtonIcon = Icons.favorite_border_rounded;
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Center(child: Text("Unsaved")),
                            duration: Duration(milliseconds: 700),
                            backgroundColor: Colors.red,
                            elevation: 0,
                          ));
                        }
                      });
                    },
                    icon: Icon(
                      loveButtonIcon,
                      color: Colors.redAccent,
                    )),
              ],
            )
          ]),
    );
  }
}

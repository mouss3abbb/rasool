import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:rasool/data.dart';
import 'package:unicons/unicons.dart';

var rand = Random();
int index = rand.nextInt(data.length);

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  var loveButtonIcon = Icons.favorite_border_rounded;
  var selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text("رسول"),
        backgroundColor: Colors.green[400],
      ),
      body: Container(
        color: Colors.lime[100],
        width: double.infinity,
        height: double.infinity,
        child: selectedIndex == 1 ? customInfo() : const SavedItems(),
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
                icon: Icon(selectedIndex == 0
                    ? CupertinoIcons.bookmark_fill
                    : CupertinoIcons.bookmark),
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
                icon: Icon(selectedIndex == 1
                    ? FeatherIcons.bookOpen
                    : FeatherIcons.book),
                color: selectedIndex == 1
                    ? Colors.greenAccent[100]
                    : Colors.white70,
                iconSize: selectedIndex == 1 ? 40 : 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding customInfo() {
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
                      setState(() {
                        loveButtonIcon = Icons.favorite_border_rounded;
                        index = rand.nextInt(data.length);
                      });
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
                          savedItems.add(data[index]);
                        } else {
                          loveButtonIcon = Icons.favorite_border_rounded;
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Center(child: Text("Unsaved")),
                            duration: Duration(milliseconds: 700),
                            backgroundColor: Colors.red,
                            elevation: 0,
                          ));
                          savedItems.remove(data[index]);
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

var savedItems = [];

class SavedItems extends StatefulWidget {
  const SavedItems({super.key});

  @override
  State<SavedItems> createState() => _SavedItemsState();
}

class _SavedItemsState extends State<SavedItems> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: savedItems.toSet().length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onHorizontalDragDown: (details) {
            setState(() {
              savedItems.remove(details);
            });
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(8),
            color: Colors.white70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    text: savedItems.toSet().toList()[index][0],
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 26,
                        fontFamily: 'Massir'),
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: savedItems.toSet().toList()[index][1],
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 22,
                        fontFamily: 'Massir'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

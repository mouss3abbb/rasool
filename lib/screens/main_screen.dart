import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:rasool/data.dart';
import 'package:rasool/glass_effect.dart';
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
      bottomNavigationBar: GlassBox(
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey[700],
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              label: "Saved",
              icon: Icon(
                selectedIndex == 0
                    ? CupertinoIcons.bookmark_fill
                    : CupertinoIcons.bookmark,
                size: selectedIndex == 0 ? 25 : 20,
              ),
            ),
            BottomNavigationBarItem(
              label: "Home",
              icon: Icon(
                selectedIndex == 1 ? FeatherIcons.bookOpen : FeatherIcons.book,
                size: selectedIndex == 1 ? 25 : 20,
              ),
            ),
          ],
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
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(8),
          width: double.infinity,
          color: Colors.white70,
          child: Slidable(
            endActionPane: ActionPane(motion: const ScrollMotion(), children: [
              SlidableAction(
                onPressed: (context) {
                  setState(() {
                    var removed = savedItems[index];
                    savedItems.removeAt(index);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Undo"),
                          IconButton(
                            icon: const Icon(
                              Icons.undo,
                              color: Colors.white70,
                            ),
                            onPressed: () {
                              setState(() {
                                savedItems.add(removed);
                              });
                            },
                          ),
                        ],
                      ),
                      duration: const Duration(seconds: 3),
                      backgroundColor: Colors.redAccent,
                      elevation: 0,
                    ));
                  });
                },
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ]),
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

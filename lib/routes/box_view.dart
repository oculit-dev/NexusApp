import 'package:nexusapp/routes/box_view/recommendation_tab.dart';
import 'package:nexusapp/routes/box_view/my_tab.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:nexusapp/routes.dart';

class BoxView extends StatelessWidget {
  /// Creates a [BoxView] widget.
  const BoxView({
    Key? key,
  }) : super(key: key);

  void _tileCallback(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Hello!"),
          content: const Text('NEED AUTH'),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<bool> _hasAuth(String? uid) async {
    final usercol = FirebaseFirestore.instance.collection("managers").doc(uid);
    var checking = await usercol.get();
    return checking.exists;
  }

  void _addActivities(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (await _hasAuth(user!.uid)) {
      Navigator.of(context).pushNamed(RouteGenerator.addActivity);
    } else {
      _tileCallback(context);
    }
  }

  void _infopage(BuildContext context) async {
    Navigator.of(context).pushNamed(RouteGenerator.infoPage);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                icon: const Icon(Icons.list),
                text: "recommended activities",
              ),
              Tab(
                icon: const Icon(Icons.person),
                text: "My activities",
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            RecommendationTab(),
            MyTab(),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () => _addActivities(context), 
                icon: const Icon(Icons.add_box_outlined),
                color: Color.fromARGB(255, 47, 0, 215),
                iconSize: 50,
              ),
              IconButton(
                onPressed: () => _infopage(context), 
                icon: const Icon(Icons.info_outline),
                color: Color.fromARGB(255, 47, 0, 215),
                iconSize: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

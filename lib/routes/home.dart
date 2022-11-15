import 'dart:math';

import 'package:nexusapp/models/data_source.dart';
import 'package:nexusapp/utils/breakpoints.dart';
import 'package:nexusapp/routes.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  /// Creates a [Home] widget.
  const Home({Key? key}) : super(key: key);
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

  void _openBoxView(BuildContext context) {
    Navigator.of(context).pushNamed(RouteGenerator.boxView);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          title: const Text("Nexus"),
          elevation: 5,
          actions: [
            IconButton(
              onPressed: () => _openBoxView(context),
              icon: const Icon(Icons.list),
            ),
          ],
        ),
        body: ListView(
          children: [
            // The radial progression bar at the top
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 30,
              ),
              child: LayoutBuilder(
                builder: (context, dimensions) {
                  final square = dimensions.maxWidth * 0.7;

                  return Center(
                    child: CustomPaint(
                      // painter: const CircularProgressPainter(
                      //   progression: 6 / 10,
                      // ),
                      child: SizedBox(
                        width: square,
                        height: square,
                        child: Center(
                          child: SizedBox(
                              height: square / 1.8,
                              width: square / 1.8,
                              child: Image.asset('assets/images/logo.png')),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Some text
            Center(
              child: Text(
                ' ',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: Divider(
                height: 80,
                thickness: 2,
              ),
            ),

            // Other dates
            Center(
              child: LayoutBuilder(
                builder: (context, dimensions) {
                  final width = min<double>(
                    maxNextRacesContents,
                    dimensions.maxWidth,
                  );

                  return SizedBox(
                    //width: width,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () => _addActivities(context),
                                    icon: const Icon(Icons.add_location_alt),
                                    color: Colors.blue,
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  const Text("add"),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () => Navigator.of(context)
                                        .pushNamed(RouteGenerator.login),
                                    icon: const Icon(Icons.event),
                                    color: Colors.blue,
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  const Text("event"),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () => _addActivities(context),
                                    icon: const Icon(Icons.help),
                                    color: Colors.blue,
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  const Text("help"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nexusapp/models/data_source.dart';
import 'package:nexusapp/models/activities_spec.dart';
import 'package:nexusapp/models/activities_list.dart';
import 'package:nexusapp/utils/breakpoints.dart';
import 'package:nexusapp/utils/collapsible/collapsible.dart';
import 'package:nexusapp/utils/collapsible/collapsible_state.dart';
import 'package:nexusapp/routes/home/circular_progress.dart';
import 'package:nexusapp/routes.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class RecommendationTab extends StatelessWidget {
  /// Creates a [RecommendationTab] widget.
  const RecommendationTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, dimensions) {
        final square = dimensions.maxWidth * 0.7;
        return FutureBuilder(
            future: DataSource().getCurrentData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData == false) {
                return SizedBox(
                    width: square,
                    height: square,
                    child: Center(
                      child: SizedBox(
                        height: square / 1.8,
                        width: square / 1.8,
                        child: CircularProgressIndicator(),
                      ),
                    ));
              } else if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: TextStyle(fontSize: 15),
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) => _ExpandedResultCard(
                      results: snapshot.data,
                      index: index,
                    ),
                  ),
                );
              }
            });
      },
    );
  }
}

class _CompactResultCard extends StatelessWidget {
  /// The data.
  final List<ActivitiesSpec> results;
  final int index;

  /// Creates a [_CompactResultCard] widget.
  const _CompactResultCard({
    required this.results,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return CollapsibleState(
      state: ValueNotifier<bool>(false),
      child: LayoutBuilder(
        builder: (context, dimensions) {
          final width =
              min<double>(mobileResultsBreakpoint, dimensions.maxWidth);

          return SizedBox(
            width: width,
            child: Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 15,
              ),
              child: Collapsible(
                edgeInsets: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                header: ListTile(
                  title: Text(results[index].host),
                  subtitle: Text(results[index].location),
                ),
                content: ActivitiesList(
                  results: results,
                  index: index,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ExpandedResultCard extends StatelessWidget {
  /// The data.
  final List<ActivitiesSpec> results;
  final int index;
  final bool _contains = false;

  /// Creates a [_ExpandedResultCard] widget.
  const _ExpandedResultCard({
    required this.results,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    void _onPressed(String? uid, ActivitiesSpec act, bool contains) async {
      final actRef = FirebaseFirestore.instance
          .collection("activities")
          .doc(act.hashCode.toString());
      late bool _contains = contains;
      if (contains) {
        actRef.update({
          "currentNumberOfPeople": FieldValue.increment(-1),
          "applicants": FieldValue.arrayRemove([user!.uid]),
        });
      } else {
        actRef.update({
          "currentNumberOfPeople": FieldValue.increment(1),
          "applicants": FieldValue.arrayUnion([user!.uid]),
        });
      }
      Navigator.of(context).pushNamed(RouteGenerator.boxView);
    }

    return LayoutBuilder(
      builder: (context, dimensions) {
        var cardWidth = max<double>(
          mobileResultsBreakpoint,
          dimensions.maxWidth,
        );

        if (cardWidth >= maxStretchResultCards - 50) {
          cardWidth = maxStretchResultCards;
        }
        final leftFlex = cardWidth < maxStretchResultCards ? 2 : 3;
        final target = results[index];
        final square = dimensions.maxWidth * 0.3;

        return Center(
          child: SizedBox(
            width: cardWidth - 20,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 20,
              ),
              child: Card(
                elevation: 5,
                child: Row(
                  children: [
                    Expanded(
                      flex: leftFlex,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomPaint(
                            painter: CircularProgressPainter(
                              progression: target.currentNumberOfPeople /
                                  target.maxNumberOfPeople,
                            ),
                            child: SizedBox(
                                width: square,
                                height: square,
                                child: Align(
                                  child: IconButton(
                                    onPressed: () => {
                                      _onPressed(user.uid, target,
                                          target.applicants.contains(user.uid))
                                    },
                                    icon: Icon(
                                        target.applicants.contains(user!.uid)
                                            ? Icons.person_remove
                                            : Icons.person_add_alt_1),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),

                    // activity info
                    Expanded(
                      flex: 3,
                      child: ActivitiesList(
                        results: results,
                        index: index,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

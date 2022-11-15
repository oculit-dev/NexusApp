import 'package:nexusapp/models/activities_spec.dart';
import 'package:flutter/material.dart';

class ActivitiesList extends StatelessWidget {
  final List<ActivitiesSpec> results;
  final int index;

  const ActivitiesList({
    Key? key,
    required this.results,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final target = results[index];
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(40.0),
            child: Column(
              children: [
                Text('Host', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('${target.host}'),
                Text('Time', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('${target.time} ${target.date}'),
                Text('Location', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('${target.location}'),
                Text('Number of People',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                    '${target.currentNumberOfPeople} / ${target.maxNumberOfPeople}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

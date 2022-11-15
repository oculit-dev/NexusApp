import 'package:nexusapp/models/activities_spec.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataSource {
  // final CollectionReference _collectionRef =
  //     FirebaseFirestore.instance.collection('activities');
  final _query = FirebaseFirestore.instance.collection('activities');

  Future<List<ActivitiesSpec>> getCurrentData() async {
    String _now = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final query =
        _query.where("date", isGreaterThanOrEqualTo: _now).orderBy("date");

    QuerySnapshot querySnapshot = await query.get();

    final all = querySnapshot.docs
        .map((item) => item.data() as Map<String, dynamic>)
        .toList();
    final val = (all.map((item) => ActivitiesSpec(
          host: item['host'],
          date: item['date'],
          time: item['time'],
          location: item['location'],
          maxNumberOfPeople: item['maxNumberOfPeople'],
          currentNumberOfPeople: item['currentNumberOfPeople'],
          optional: item['optional'],
          applicants: List<String>.from(item['applicants']),
        ))).toList();
    // print(val);
    return val;
  }

  Future<List<ActivitiesSpec>> getMyData() async {
    User? user = FirebaseAuth.instance.currentUser;
    final query = _query.where("applicants", arrayContains: user!.uid);

    QuerySnapshot querySnapshot = await query.get();

    final all = querySnapshot.docs
        .map((item) => item.data() as Map<String, dynamic>)
        .toList();
    final val = (all.map((item) => ActivitiesSpec(
          host: item['host'],
          date: item['date'],
          time: item['time'],
          location: item['location'],
          maxNumberOfPeople: item['maxNumberOfPeople'],
          currentNumberOfPeople: item['currentNumberOfPeople'],
          optional: item['optional'],
          applicants: List<String>.from(item['applicants']),
        ))).toList();
    // print(val);
    return val;
  }
}



// /// Fake data source
// const activitiesList = [
//   ActivitiesSpec(
//     host: 'Club 2',
//     date: '22/12/43',
//     time: '22/12/43',
//     location: 'Gangnam',
//     maxNumberOfPeople: 7,
//     currentNumberOfPeople: 3,
//     optional: 'test',
//   ),
//   ActivitiesSpec(
//     host: 'Club 3',
//     date: '22/12/43',
//     time: '22/12/43',
//     location: 'Gangnam',
//     maxNumberOfPeople: 7,
//     currentNumberOfPeople: 3,
//     optional: 'test',
//   ),
//     name: 'Club 1',
//     loc: 'Secho',
//     time: '15/67/81',
//     description: 'ihrt',
//     currentParticipants: 0,
//     maxParticipants: 4,
//   ),
//   ActivitiesSpec(
//     name: 'Club 5',
//     loc: 'Pangyo',
//     time: '51/65/88',
//     description: 'itnr',
//     currentParticipants: 32,
//     maxParticipants: 56,
//   ),
//   ActivitiesSpec(
//     name: 'Club 3',
//     loc: 'Busan',
//     time: '87/51/53',
//     description: 'it',
//     currentParticipants: 8,
//     maxParticipants: 8,
//   ),
//   ActivitiesSpec(
//     name: 'Club 6',
//     loc: 'Jeju',
//     time: '11/05/16',
//     description: 'it',
//     currentParticipants: 1,
//     maxParticipants: 10,
//   ),
// ];

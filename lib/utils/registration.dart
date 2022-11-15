import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nexusapp/models/activities_spec.dart';

class RegistHelper {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<String?> regist(
      {required String host,
      required String date,
      required String time,
      required String location,
      required int maxNumberOfPeople,
      required int currentNumberOfPeople,
      required String optional,
      required List<String> applicants}) async {
    ActivitiesSpec acts = ActivitiesSpec(
      host: host,
      date: date,
      time: time,
      location: location,
      maxNumberOfPeople: maxNumberOfPeople,
      currentNumberOfPeople: currentNumberOfPeople,
      optional: optional,
      applicants: <String>[],
    );

    var act = {
      "host": host,
      "date": date,
      "time": time,
      "location": location,
      "maxNumberOfPeople": maxNumberOfPeople,
      "currentNumberOfPeople": currentNumberOfPeople,
      "optional": optional,
      "applicants": applicants,
    };

    db
        .collection("activities")
        .doc(acts.hashCode.toString())
        .set(act)
        .onError((e, _) => print("Error writing document: $e"));

    return null;
  }
}

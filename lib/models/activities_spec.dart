import 'package:cloud_firestore/cloud_firestore.dart';

class ActivitiesSpec {
  final String host;
  final String date;
  final String time;
  final String location;
  final int maxNumberOfPeople;
  final int currentNumberOfPeople;
  final String optional;
  final List<String> applicants;

  // final string charactars; ENUM

  /// Creates a [ActivitiesSpec] object.
  const ActivitiesSpec(
      {required this.host,
      required this.date,
      required this.time,
      required this.location,
      required this.maxNumberOfPeople,
      required this.currentNumberOfPeople,
      required this.optional,
      required this.applicants});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    if (other is ActivitiesSpec) {
      return runtimeType == other.runtimeType &&
          host == other.host &&
          date == other.date &&
          time == other.time;
    } else {
      return false;
    }
  }

  @override
  int get hashCode {
    var result = 17;
    result = result * 37 + location.hashCode;
    result = result * 37 + date.hashCode;
    result = result * 37 + time.hashCode;
    return result;
  }

  Map<String, dynamic> toJson() => {
        'host': host,
        'date': date,
        'time': time,
        'location': location,
        'maxNumberOfPeople': maxNumberOfPeople,
        'currentNumberOfPeople': currentNumberOfPeople,
        'optional': optional,
        'applicants': applicants,
      };
}

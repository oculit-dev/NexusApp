import 'package:nexusapp/utils/registration.dart';
import 'package:nexusapp/routes.dart';

import 'package:kpostal/kpostal.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

class AddActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          SizedBox(height: 80),
          // logo
          Column(
            children: [
              FlutterLogo(
                size: 55,
              ),
            ],
          ),
          SizedBox(height: 50),
          Text(
            'Welcome!',
            style: TextStyle(fontSize: 24),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AddActivityForm(),
          ),
        ],
      ),
    );
  }

  Container buildLogo() {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.blue),
      child: Center(
        child: Text(
          "T",
          style: TextStyle(color: Colors.white, fontSize: 60.0),
        ),
      ),
    );
  }
}

class AddActivityForm extends StatefulWidget {
  AddActivityForm({Key? key}) : super(key: key);

  @override
  _AddActivityFormState createState() => _AddActivityFormState();
}

class _AddActivityFormState extends State<AddActivityForm> {
  final _formKey = GlobalKey<FormState>();

  String? host;
  String? date;
  String? time;
  String? location;
  int? maxNumberOfPeople;
  int? currentNumberOfPeople;
  String? optional;

  final dateinput = TextEditingController();
  final timeinput = TextEditingController();
  final loc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var border = OutlineInputBorder(
      borderRadius: BorderRadius.all(
        const Radius.circular(100.0),
      ),
    );

    var space = SizedBox(height: 10);
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          // host
          TextFormField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.groups),
                labelText: 'Host name',
                border: border),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onSaved: (val) {
              host = val;
            },
          ),
          space,

          // date
          TextField(
            controller: dateinput,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.calendar_today),
                labelText: "Date",
                border: border),
            readOnly: true,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101));

              if (pickedDate != null) {
                String formattedDate =
                    DateFormat('yyyy-MM-dd').format(pickedDate);
                date = formattedDate;
                setState(() {
                  dateinput.text = formattedDate;
                });
              }
            },
          ),
          space,

          // time
          TextField(
            controller: timeinput,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.schedule),
                labelText: "Time",
                border: border),
            readOnly: true,
            onTap: () async {
              TimeOfDay? pickedTime = await showTimePicker(
                  context: context, initialTime: TimeOfDay.now());

              if (pickedTime != null) {
                final now = DateTime.now();
                String formattedDate = DateFormat('kk:mm').format(DateTime(
                    now.year,
                    now.month,
                    now.day,
                    pickedTime.hour,
                    pickedTime.minute));
                time = formattedDate;
                setState(() {
                  timeinput.text = formattedDate;
                });
              }
            },
          ),
          space,

          // location
          TextFormField(
            controller: loc,
            readOnly: true,
            initialValue: location,
            decoration: InputDecoration(
              labelText: 'Location',
              prefixIcon: Icon(Icons.map),
              border: border,
              suffixIcon:
                  // GestureDetector(
                  // child:
                  const Icon(
                Icons.search,
              ),
              // ),
            ),
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => KpostalView(
                    callback: (Kpostal result) {
                      location = result.address;
                      loc.text = location!;
                    },
                  ),
                ),
              );
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter some text'; // search
              }
              return null;
            },
          ),
          space,

          // max #
          TextFormField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.groups),
                labelText: 'Max number of People',
                border: border),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onSaved: (val) {
              maxNumberOfPeople = int.parse(val!);
            },
          ),
          space,
          // current #
          TextFormField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.groups),
                labelText: 'Current number of People',
                border: border),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onSaved: (val) {
              currentNumberOfPeople = int.parse(val!);
            },
          ),
          space,

          // optional
          TextFormField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.playlist_add),
                labelText: 'Optional',
                border: border),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onSaved: (val) {
              optional = val;
            },
          ),
          space,

          // AddActivity button
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  RegistHelper().regist(
                    host: host!,
                    date: date!,
                    time: time!,
                    location: location!,
                    maxNumberOfPeople: maxNumberOfPeople!,
                    currentNumberOfPeople: currentNumberOfPeople!,
                    optional: optional!,
                    applicants: <String>[],
                  ).then((result) {
                    if (result == null) {
                      Navigator.of(context).pushNamed(RouteGenerator.home);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          result,
                          style: TextStyle(fontSize: 16),
                        ),
                      ));
                    }
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(24.0)))),
              child: Text('Registration'),
            ),
          ),
        ],
      ),
    );
  }
}

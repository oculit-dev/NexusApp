import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 47, 0, 215),
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                'OUR TEAM',
                style: TextStyle(
                  color: Color.fromARGB(255, 47, 0, 215),
                  fontFamily: 'Rubik',
                  fontSize: 45.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(8),
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      height: 50,
                      color: Colors.grey,
                      child: Column(
                        children: [
                          Text(
                            'Jeesung Lee',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Rubik',
                              fontSize: 25.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'Co-founder, Head Developer'
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
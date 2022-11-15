import 'package:flutter/material.dart';
import 'package:nexusapp/utils/authentication.dart';
import 'package:nexusapp/routes/home.dart';
import 'package:nexusapp/routes/signup.dart';
import 'package:nexusapp/routes/box_view.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 47, 0, 215),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: <Widget>[
          SizedBox(height: 80),
          // logo
          Column(
            children: [
              // Image.asset('assets/images/logo.png'),
              SizedBox(height: 50),
              Text(
                'Welcome to Nexus!',
                style: TextStyle(
                  fontSize: 40,
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),

          SizedBox(
            height: 50,
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: LoginForm(),
          ),

          SizedBox(height: 20),

          Row(
            children: <Widget>[
              SizedBox(width: 30),
              Text("Don't have an account? ",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, fontFamily: 'Rubik', color: Colors.white)),
              GestureDetector(
                onTap: () {
                  // Navigator.pushNamed(context, '/signup');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Signup()));
                },
                child: Text('Get Registered Here',
                    style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 182, 255, 98), fontFamily: 'Rubik', fontWeight: FontWeight.w700)),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  String? email;
  String? password;

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          // email
          TextFormField(
            // initialValue: 'Input text',
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.email_outlined,
                color: Colors.white,
              ),
              hintText: 'Email',
              hintStyle: TextStyle(
                color: Colors.white,
                fontFamily: 'Rubik',
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  const Radius.circular(10.0),
                ),
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 2.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  const Radius.circular(10.0),
                ),
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 3.0,
                ),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onSaved: (val) {
              email = val;
            },
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontFamily: 'Rubik',
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 20,
          ),

          // password
          TextFormField(
            // initialValue: 'Input text',
            decoration: InputDecoration(
              hintText: 'Password',
              hintStyle: TextStyle(
                color: Colors.white,
                fontFamily: 'Rubik',
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
              prefixIcon: Icon(
                Icons.lock_outline,
                color: Colors.white,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  const Radius.circular(10.0),
                ),
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 2.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  const Radius.circular(10.0),
                ),
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 2.0,
                ),
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.white,
                ),
              ),
            ),
            obscureText: _obscureText,
            onSaved: (val) {
              password = val;
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontFamily: 'Rubik',
              fontWeight: FontWeight.w500,
            ),
          ),

          SizedBox(height: 30),

          SizedBox(
            height: 54,
            width: 184,
            child: ElevatedButton(
              onPressed: () {
                // Respond to button press

                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  AuthenticationHelper()
                      .signIn(email: email!, password: password!)
                      .then((result) {
                    if (result == null) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => BoxView()));
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
                  borderRadius: BorderRadius.all(
                    Radius.circular(24.0),
                  ),
                ),
                backgroundColor: Colors.white,
              ),
              child: Text(
                'Login',
                style: TextStyle(
                  color: Color.fromARGB(255, 47, 0, 215),
                  fontSize: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

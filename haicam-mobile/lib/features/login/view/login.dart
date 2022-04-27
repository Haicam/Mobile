import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<Login> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'HAICAM',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    //forgot password screen
                  },
                  textColor: Colors.blue,
                  child: const Text('Forgot Password'),
                ),
                Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('Login'),
                    onPressed: () {
                      print(nameController.text);
                      print(passwordController.text);
                    },
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      const Text('Does not have account?'),
                      FlatButton(
                        textColor: Colors.blue,
                        child: const Text(
                          'Sign in',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          //signup screen
                        },
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ),
                FlatButton(
                  onPressed: () {},
                  textColor: Colors.blue,
                  child: const Text('Back To Login'),
                ),
              ],
            )));
  }
}

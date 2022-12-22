import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class login extends StatefulWidget{
  @override
  State<login> createState()=>_loginState();

}

class _loginState extends State<login> {
  final username_controller = TextEditingController();
  final password_controller = TextEditingController();


  late SharedPreferences logindata;
  late bool newuser;

  void initState() {
    super.initState();
    check();
  }
  void check () async{
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool("login") ?? true);
    print(newuser);

    if (newuser == false) {
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => homepage()));
    }
  }
    void dispose() {
      // Clean up the controller when the widget is disposed.
      username_controller.dispose();
      password_controller.dispose();
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("login page"),
        ),
        body: Column(
          children: [
            const Text("hello"),
            TextField(
              controller: username_controller,
              decoration: const InputDecoration(
                label: Text("username"),
              ),
            ),
            TextField(
              controller: password_controller,
              decoration: const InputDecoration(
                  label: Text("password")
              ),
            ),
            ElevatedButton(onPressed: () {
              String username = username_controller.text;
              String password = password_controller.text;
              if (username != '' && password != '') {
                print('Successfull');

                logindata.setBool('login', false);
                logindata.setString('username', username);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => homepage()));
              }
            }, child: const Text("login"))
          ],
        ),
      );
    }
  }
class homepage extends StatefulWidget {
  @override
  State<homepage> createState() => _homepageState();
}
class _homepageState extends State<homepage> {

  late SharedPreferences logindata;
  late String username;

  @override
  void initState() {
    super.initState();
    initial();
  }
  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString('username')!;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shared Preference Example"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                'Hai $username Welcome To Luminar ',
                style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                logindata.setBool('login', true);
                Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => login()));
              },
              child: const Text('LogOut'),
            )
          ],
        ),
      ),
    );
  }
}

void main(){
  runApp(MaterialApp(home: login(),));
}
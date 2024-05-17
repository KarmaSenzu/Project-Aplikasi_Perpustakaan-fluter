import 'package:flutter/material.dart';
import '../service/login_service.dart';
import 'beranda.dart'; // Sesuaikan dengan path beranda.dart yang benar

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg-blue.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(20), // Mengatur radius gambar
                child: Image.asset(
                  'assets/images/book.png',
                  height: 200,
                  width: 320,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                "Login Admin",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Form(
                  key: _formKey,
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: Column(
                      children: [
                        _usernameTextField(),
                        SizedBox(height: 20),
                        _passwordTextField(),
                        SizedBox(height: 40),
                        _tombolLogin(),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _usernameTextField() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black12,
        ),
        color: Colors.grey[100],
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Userame',
          contentPadding: EdgeInsets.all(10),
        ),
        controller: _usernameCtrl,
      ),
    );
  }

  Widget _passwordTextField() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black12,
        ),
        color: Colors.grey[100],
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Password',
          contentPadding: EdgeInsets.all(10),
        ),
        controller: _passwordCtrl,
      ),
    );
  }

  Widget _tombolLogin() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        child: Text("Login"),
        onPressed: () async {
          String username = _usernameCtrl.text;
          String password = _passwordCtrl.text;
          await LoginService().login(username, password).then((value) {
            if (value == true) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Beranda()),
              );
            } else {
              AlertDialog alertDialog = AlertDialog(
                content: const Text("Username atau Password Tidak Valid"),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("OK"),
                    style: ElevatedButton.styleFrom(primary: Colors.blue),
                  )
                ],
              );
              showDialog(
                context: context,
                builder: (context) => alertDialog,
              );
            }
          });
        },
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff2888d5),
            Color(0xffaf09f1)
          ], // Sesuaikan dengan warna yang diinginkan
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

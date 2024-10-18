import 'package:flutter/material.dart';
import 'package:responsi_uts/bloc/login_bloc.dart';
import 'package:responsi_uts/helpers/user_info.dart';
import 'package:responsi_uts/ui/produk_page.dart';
import 'package:responsi_uts/ui/registrasi_page.dart';
import 'package:responsi_uts/widget/warning_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final _emailTextboxController = TextEditingController();
  final _passwordTextboxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.green, // Warna AppBar hijau
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _emailTextField(),
                _passwordTextField(),
                _buttonLogin(),
                const SizedBox(
                  height: 30,
                ),
                _menuRegistrasi()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _emailTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Email",
        labelStyle: TextStyle(color: Colors.green), // Warna label hijau
      ),
      keyboardType: TextInputType.emailAddress,
      controller: _emailTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Email harus diisi';
        }
        return null;
      },
      style: const TextStyle(
        fontFamily: 'Sans-serif', // Font Sans Serif
      ),
    );
  }

  Widget _passwordTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Password",
        labelStyle: TextStyle(color: Colors.green), // Warna label hijau
      ),
      keyboardType: TextInputType.text,
      obscureText: true,
      controller: _passwordTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Password harus diisi";
        }
        return null;
      },
      style: const TextStyle(
        fontFamily: 'Sans-serif', // Font Sans Serif
      ),
    );
  }

  Widget _buttonLogin() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green, // Warna tombol hijau
        foregroundColor: Colors.yellow, // Warna teks tombol kuning
      ),
      child: const Text("Login"),
      onPressed: () {
        var validate = _formKey.currentState!.validate();
        if (validate) {
          if (!_isLoading) _submit();
        }
      },
    );
  }

  void _submit() {
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    LoginBloc.login(
      email: _emailTextboxController.text,
      password: _passwordTextboxController.text,
    ).then((value) async {
      print("Login successful: $value");
      if (value.userID != null) {
        await UserInfo().setToken(value.token ?? "");
        await UserInfo().setUserID(value.userID!);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProdukPage()),
        );
      } else {
        throw Exception("UserID is null");
      }
    }).catchError((error) {
      print("Login error: $error");
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => WarningDialog(
          description: "Login gagal: ${error.toString()}",
        ),
      );
    }).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
  }

  Widget _menuRegistrasi() {
    return Center(
      child: InkWell(
        child: const Text(
          "Registrasi",
          style: TextStyle(color: Colors.yellow), // Teks Registrasi kuning
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RegistrasiPage()),
          );
        },
      ),
    );
  }
}

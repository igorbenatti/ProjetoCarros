import 'package:carros/pages/home_page.dart';
import 'package:carros/pages/login_api.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/app_button.dart';
import 'package:carros/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _tLogin = TextEditingController();

  final _tSenha = TextEditingController();

  final _focusSenha = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
      ),
      body: _body(),
    );
  }

  _body() {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            AppText(
              "Login",
              "Informe o usuário",
              controller: _tLogin,
              validator: _validateLogin,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              nextFocus: _focusSenha,
            ),
            SizedBox(
              height: 10,
            ),
            AppText(
              "Senha",
              "Informe a senha do usuário",
              password: true,
              controller: _tSenha,
              validator: _validateSenha,
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: 20,
            ),
            AppButton(
              "Login",
              onPressed: _onClickLogin,
            )
          ],
        ),
      ),
    );
  }

  void _onClickLogin() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    String login = _tLogin.text;
    String senha = _tSenha.text;

    print("Login: $login, Senha: $senha");

    bool ok = await LoginApi.login(login, senha);

    if (ok) {
      push(context, HomePage());
    } else {
      print("Login incorreto");
    }
  }

  String _validateLogin(String text) {
    if (text.isEmpty) {
      return "Usuário deve ser informado";
    }
    return null;
  }

  String _validateSenha(String text) {
    if (text.isEmpty) {
      return "Senha deve ser informada";
    }
    if (text.length < 2) {
      return "A senha deve ter no mínimo 3 caracteres";
    }
    return null;
  }
}

import 'package:flutter/material.dart';
import 'package:my_architecture_app/ui/pages/home/home_page.dart';
import 'package:provider/provider.dart';
import 'login_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async{
    final email = _emailController.text;
    final password = _passwordController.text;

  final bool isSuccess = await context.read<LoginProvider>().login(email, password);

  if (isSuccess && mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = context.watch<LoginProvider>();

    if (loginProvider.isLoading) {
      return Scaffold(
        backgroundColor: Colors.grey[900],
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Log In',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            // 7. Поле для Email
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                filled: true,
                fillColor: Colors.grey[800],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 16),
            // 8. Поле для Пароля
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                filled: true,
                fillColor: Colors.grey[800],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              obscureText: true, // Ховаємо пароль
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 16), // Додамо невеликий відступ

          // --- 1. НОВИЙ БЛОК: ПОКАЗУЄМО ПОМИЛКУ ---
          if (loginProvider.errorMessage != null)
            Text(
              // Беремо текст помилки з провайдера
              loginProvider.errorMessage!,
              style: TextStyle(color: Colors.red[400], fontSize: 14),
              textAlign: TextAlign.center,
            ),
          // ----------------------------------------

          SizedBox(height: 16),
            // 9. Кнопка
            loginProvider.isLoading
              ? Center( // ЯКЩО true (завантаження)
                  child: CircularProgressIndicator(
                    color: Colors.purple,
                  ),
                )
              : ElevatedButton( // ЯКЩО false (немає завантаження)
                  onPressed: _handleLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text('Log In', style: TextStyle(fontSize: 18)),
                ),
          ],
        ),
      ),
    );
  }
}

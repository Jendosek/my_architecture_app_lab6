import 'package:flutter/material.dart';
import 'package:my_architecture_app/ui/pages/main/main_page.dart';
import 'package:provider/provider.dart';
import 'login_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController(text: 'test@gmail.com');
  final _passwordController = TextEditingController(text: '123456');

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin(LoginProvider provider) async {
    final email = _emailController.text;
    final password = _passwordController.text;

    final bool isSuccess = await provider.login(email, password);

    if (isSuccess && mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainPage()),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final loginProvider = context.watch<LoginProvider>();

    return Scaffold(
      backgroundColor: Colors.black, 
      body: SafeArea( 
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 60),
              _buildHeader(),
              SizedBox(height: 48),
              _buildForm(loginProvider),
              SizedBox(height: 24),
              _buildLoginButton(loginProvider),
              SizedBox(height: 40),
              _buildDivider(),
              SizedBox(height: 24),
              _buildSocialLogins(),
              SizedBox(height: 40),
              _buildRegisterLink(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Text(
          'Log In',
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Welcome to Musify – listen unlimitedly',
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildForm(LoginProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextField(
          controller: _emailController,
          style: TextStyle(color: Colors.white),
          decoration: _buildInputDecoration('Email'),
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: 16),
        TextField(
          controller: _passwordController,
          style: TextStyle(color: Colors.white),
          decoration: _buildInputDecoration('Password').copyWith(
            suffixIcon: Icon(Icons.visibility_off, color: Colors.grey),
          ),
          obscureText: true,
        ),
        SizedBox(height: 12),
        TextButton(
          onPressed: () {},
          child: Text(
            'Forgot password?',
            style: TextStyle(color: Colors.grey[400]),
          ),
        ),
        if (provider.errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Center(
              child: Text(
                provider.errorMessage!,
                style: TextStyle(color: Colors.red[400], fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
  
  Widget _buildLoginButton(LoginProvider provider) {
    return provider.isLoading
        ? Center(
            child: CircularProgressIndicator(
              color: Color(0xFF8A2BE2),
            ),
          )
        : ElevatedButton(
            onPressed: () => _handleLogin(provider),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF8A2BE2),
              padding: EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text(
              'Log In',
              style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          );
  }
  
  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey[700])),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text('Or', style: TextStyle(color: Colors.grey[400])),
        ),
        Expanded(child: Divider(color: Colors.grey[700])),
      ],
    );
  }

  Widget _buildSocialLogins() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialButton(Icons.facebook, onPressed: () {}), // TODO: Implement
        SizedBox(width: 20),
        _buildSocialButton(Icons.g_mobiledata, onPressed: () {}), // TODO: Implement Google
        SizedBox(width: 20),
        _buildSocialButton(Icons.apple, onPressed: () {}), // TODO: Implement Apple
      ],
    );
  }

  Widget _buildRegisterLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't Have An Account? ",
          style: TextStyle(color: Colors.grey[400]),
        ),
        TextButton(
          onPressed: () {}, // TODO: Implement navigation to Register
          child: Text(
            'Register',
            style: TextStyle(
              color: Color(0xFF8A2BE2),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  InputDecoration _buildInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.grey[400]),
      filled: true,
      fillColor: Colors.grey[900],
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[700]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Color(0xFF8A2BE2)),
      ),
    );
  }

  Widget _buildSocialButton(IconData icon, {required VoidCallback onPressed}) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(16),
        side: BorderSide(color: Colors.grey[700]!),
      ),
      child: Icon(icon, color: Colors.white, size: 28),
    );
  }
}

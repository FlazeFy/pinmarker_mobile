import 'package:flutter/material.dart';
import 'package:pinmarker/helpers/variables/style.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => StateLoginFormState();
}

class StateLoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.all(spaceXLG),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(roundedXLG),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Welcome Back',
              style: TextStyle(fontSize: textJumbo, fontWeight: FontWeight.w700),
            ),
          ),
          Center(
            child: Text(
              'Sign in to your account to continue exploring.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: textMD, color: greyColor),
            ),
          ),
          SizedBox(height: spaceMD),
          const Divider(),
          SizedBox(height: spaceMD),
          Text(
            'EMAIL OR USERNAME',
            style: TextStyle(fontSize: textSM, fontWeight: FontWeight.w700, letterSpacing: 0.5),
          ),
          SizedBox(height: spaceSM),
          _buildTextField(
            controller: _usernameController,
            hint: 'Enter your email',
            icon: Icons.person_outline,
          ),
          SizedBox(height: spaceMD),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'PASSWORD',
                style: TextStyle(fontSize: textSM, fontWeight: FontWeight.w700, letterSpacing: 0.5),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(fontSize: textMD, color: primaryColor, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          SizedBox(height: spaceSM),
          _buildTextField(
            controller: _passwordController,
            hint: '••••••••',
            icon: Icons.lock_outline,
            obscure: _obscurePassword,
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                color: greyColor,
                size: 20,
              ),
              onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
            ),
          ),
          SizedBox(height: spaceXLG),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                elevation: 0,
              ),
              child: Text(
                'Sign In',
                style: TextStyle(fontSize: textLG, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          SizedBox(height: spaceXLG),
          Row(
            children: [
              Expanded(child: Divider()),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: spaceMD),
                child: Text('Or Continue With', style: TextStyle(fontSize: textMD, color: greyColor)),
              ),
              Expanded(child: Divider()),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: Text('G', style: TextStyle(fontSize: textLG, fontWeight: FontWeight.w700, color: Colors.black87)),
              label: Text('Google', style: TextStyle(fontSize: textXMD, fontWeight: FontWeight.w600, color: Colors.black87)),
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                side: const BorderSide(color: Color(0xFFE0E0E0)),
              ),
            ),
          ),
          SizedBox(height: spaceXLG),
          Center(
            child: RichText(
              text: TextSpan(
                text: "Don't have an account? ",
                style: TextStyle(color: greyColor, fontSize: textMD),
                children: [
                  TextSpan(
                    text: 'Register Now',
                    style: const TextStyle(color: primaryColor, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscure = false,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: greyColor),
        prefixIcon: Icon(icon, color: greyColor, size: iconLG),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: const Color(0xFFF5F5F5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(roundedMD),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: spaceXMD, vertical: spaceMD),
      ),
    );
  }
}

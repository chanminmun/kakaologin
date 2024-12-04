import 'package:flutter/material.dart';
import 'package:chatapp/config/palette.dart';
import 'package:chatapp/screen/signup_screen.dart'; // 회원가입 화면 import
import 'package:chatapp/screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import 'package:chatapp/login/naver_service.dart';
import 'package:chatapp/login/google_service.dart';
import 'package:chatapp/login/kakao_sevice.dart';
import 'package:chatapp/config/login_platform.dart';
import 'package:chatapp/config/login_button.dart';

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({Key? key}) : super(key: key);

  @override
  State<LoginSignupScreen> createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPlatform _loginPlatform = LoginPlatform.none;

  // 카카오 로그인
  Future<void> _loginWithKakao() async {
    bool success = await KakaoService().login();
    if (success) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  // 구글 로그인
  Future<void> _loginWithGoogle() async {
    bool success = await GoogleService().login();
    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  // 네이버 로그인
  Future<void> _loginWithNaver() async {
    bool success = await NaverService().login();
    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  // 이메일 로그인
  Future<void> _loginWithEmail() async {
    try {
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

      await firebase_auth.FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      print('로그인 성공');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } catch (error) {
      print('이메일 로그인 실패: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('로그인 실패: ${error.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: Stack(
        children: [
          // 상단 이미지 및 텍스트 영역
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              padding: const EdgeInsets.only(top: 90, left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
              height: 300,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('asset/img/logo2.png'),
                  fit: BoxFit.cover,
                  opacity: 0.5,
                ),
              ),
            ),
          ),
          // 로그인 및 카카오, 구글, 네이버 로그인 UI
          Positioned(
            top: 250,
            left: 20,
            right: 20,
            child: Container(
              height: 480.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 15,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 이메일 입력 필드
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // 비밀번호 입력 필드
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // 이메일 로그인 버튼
                  ElevatedButton(
                    onPressed: _loginWithEmail,
                    child: const Text('Login'),
                  ),
                  const SizedBox(height: 20),
                  // "Sign Up" 구분 텍스트
                  const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  // 카카오, 구글, 네이버 로그인 버튼들
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // 카카오 로그인 버튼
                      Flexible(
                        child: LoginButton(
                          imagePath: 'asset/img/kakao_logo.png',
                          onPressed: _loginWithKakao,
                        ),
                      ),
                      // 구글 로그인 버튼
                      Flexible(
                        child: LoginButton(
                          imagePath: 'asset/img/google_logo.png',
                          onPressed: _loginWithGoogle,
                        ),
                      ),
                      // 네이버 로그인 버튼
                      Flexible(
                        child: LoginButton(
                          imagePath: 'asset/img/naver_logo.png',
                          onPressed: _loginWithNaver,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

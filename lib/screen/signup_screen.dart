import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firebase Firestore 사용
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Authentication 사용
import 'package:chatapp/screen/login_signup_screen.dart'; // LoginSignupScreen import

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 컨트롤러 선언
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('회원가입'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '회원가입',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // 이름 입력 필드
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: '이름',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            // 이메일 입력 필드
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: '이메일',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            // 비밀번호 입력 필드
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: '비밀번호',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 30),
            // 회원가입 완료 버튼
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    // Firebase Auth로 계정 생성
                    UserCredential userCredential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                    );

                    String uid = userCredential.user?.uid ?? '';

                    // Firestore에 사용자 정보 저장
                    await FirebaseFirestore.instance.collection('users').doc(uid).set({
                      'firebaseUserId': uid,
                      'name': nameController.text.trim(),
                      'email': emailController.text.trim(),
                      // roles 필드 추가
                      'roles': ["admin", "user"],  // 역할 리스트 추가
                    }).then((_) {
                      print('회원가입 정보 저장 완료');
                    }).catchError((error) {
                      print('Firestore 저장 실패: $error');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Firestore에 정보 저장 실패: ${error.toString()}')),
                      );
                    });

                    // 로그인 화면으로 이동
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginSignupScreen(),
                      ),
                    );
                  } catch (e) {
                    print('회원가입 실패: $e');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('회원가입 실패: ${e.toString()}')),
                    );
                  }
                },
                child: const Text('회원가입 완료'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

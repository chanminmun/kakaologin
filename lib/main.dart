import 'package:chatapp/screen/login_signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'firebase_options.dart';
import 'package:chatapp/screens/chatting_screen.dart';


void main() async {
  KakaoSdk.init(
    nativeAppKey: '58ad220ee044fa0abfd0df56f7545b71',
    javaScriptAppKey: '415518cc7103a085e009ff7ce58d0262',
  ); // Kakao SDK 초기화
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginSignupScreen(), // 로그인 화면으로 시작
    );
  }
}
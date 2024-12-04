import 'package:google_sign_in/google_sign_in.dart';

class GoogleService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // 구글 로그인 함수
  Future<bool> login() async {
    try {
      GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        print('구글 로그인 성공');
        return true;
      } else {
        print('구글 로그인 실패');
        return false;
      }
    } catch (error) {
      print('구글 로그인 실패: $error');
      return false;
    }
  }

  // 구글 로그아웃 함수
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      print('구글 로그아웃 성공');
    } catch (error) {
      print('구글 로그아웃 실패: $error');
    }
  }
}
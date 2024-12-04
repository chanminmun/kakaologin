import 'package:flutter_naver_login/flutter_naver_login.dart';

class NaverService {
  // 네이버 로그인 실행
  Future<bool> login() async {
    try {
      // 네이버 로그인 시도
      final NaverLoginResult result = await FlutterNaverLogin.logIn();

      // 로그인 성공 시 액세스 토큰 및 사용자 정보 출력
      print('Access Token: ${result.accessToken}');
      print('ID: ${result.account.id}');
      print('Email: ${result.account.email}');
      print('Name: ${result.account.name}');

      return true;
    } catch (error) {
      // 로그인 실패 시 에러 출력
      print('네이버 로그인 오류: $error');
      return false;
    }
  }

  // 네이버 로그아웃 실행
  Future<void> logOut() async {
    try {
      await FlutterNaverLogin.logOut();
      print('네이버에서 성공적으로 로그아웃 되었습니다.');
    } catch (error) {
      print('네이버 로그아웃 오류: $error');
    }
  }

  // 네이버 사용자 정보 가져오기
  Future<void> getUserInfo() async {
    try {
      // 로그인 후 NaverLoginResult 객체에서 사용자 정보 추출
      final result = await FlutterNaverLogin.logIn();
      print('사용자 ID: ${result.account.id}');
      print('사용자 이메일: ${result.account.email}');
      print('사용자 이름: ${result.account.name}');
    } catch (error) {
      print('사용자 정보 가져오기 실패: $error');
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' hide User;

class KakaoService {
  String _userName = '';  // 사용자 이름
  String _userProfilePicUrl = '';  // 프로필 이미지 URL

  // 카카오 로그인
  Future<bool> login() async {
    try {
      // 카카오 계정으로 로그인
      OAuthToken token = await UserApi.instance.loginWithKakaoAccount();

      // Firebase 로그인
      bool isFirebaseLoginSuccessful = await _signInWithFirebase(token);
      if (isFirebaseLoginSuccessful) {
        // Firebase 로그인 성공 후 사용자 정보 가져오기
        await _getKakaoUserInfo();
        return true;
      }
      return false;
    } catch (error) {
      print('카카오 로그인 실패: $error');
      return false;
    }
  }

  // Firebase 인증 처리
  Future<bool> _signInWithFirebase(OAuthToken token) async {
    try {
      var provider = OAuthProvider("oidc.chatapp");
      var credential = provider.credential(
        idToken: token.idToken,
        accessToken: token.accessToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      return true; // Firebase 로그인 성공
    } catch (error) {
      print('Firebase 로그인 실패: $error');
      return false;
    }
  }

  // 카카오 사용자 정보 가져오기
  Future<void> _getKakaoUserInfo() async {
    try {
      // 카카오 사용자 정보 가져오기
      var user = await UserApi.instance.me();

      // 사용자 정보 출력
      String userName = user.kakaoAccount?.profile?.nickname ?? '사용자 이름 없음';
      String userProfilePicUrl = user.kakaoAccount?.profile?.thumbnailImageUrl ?? '';

      print("카카오 사용자 정보: $userName");
      print("프로필 이미지 URL: $userProfilePicUrl");

      // 사용자 이름과 프로필 이미지 URL 저장
      _userName = userName;
      _userProfilePicUrl = userProfilePicUrl;
    } catch (error) {
      print('사용자 정보 가져오기 실패: $error');
    }
  }

  // 카카오 로그아웃
  Future<void> logOut() async {
    try {
      await UserApi.instance.logout();
      print('카카오 로그아웃 성공');
    } catch (error) {
      print('카카오 로그아웃 실패: $error');
    }
  }
}

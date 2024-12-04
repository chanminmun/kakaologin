import 'package:flutter/material.dart';
import 'package:chatapp/component/time_page.dart'; // TimePage를 가져옴.
import 'package:chatapp/screens/chatting_screen.dart';

class PlayScreen extends StatelessWidget {
  const PlayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 배경색을 흰색으로 설정
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: playOptions.length, // 버튼 개수
            itemBuilder: (context, index) {
              final option = playOptions[index];
              return _buildPlayButton(context, option['title'], option['pageNumber']);
            },
          ),
        ),
      ),
    );
  }

  // 버튼 생성 함수
  Widget _buildPlayButton(BuildContext context, String title, int pageNumber) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0), // 버튼 간격
      child: ElevatedButton(
        onPressed: () {
          // 버튼 클릭 시 TimePage로 이동
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TimePage(title: title), // 제목을 전달
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12.0), // 버튼 크기 조정
          textStyle: const TextStyle(fontSize: 16), // 텍스트 크기 조정
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero, // 모서리를 0으로 설정해 직사각형으로 변경
          ),
        ),
        child: Text(title), // 버튼 텍스트
      ),
    );
  }
}

// 놀거리 옵션 리스트
final List<Map<String, dynamic>> playOptions = [
  {'title': '볼링', 'pageNumber': 1},
  {'title': '당구', 'pageNumber': 2},
  {'title': 'PC방', 'pageNumber': 3},
  {'title': '야구', 'pageNumber': 4},
  {'title': '농구', 'pageNumber': 5},
  {'title': '보드게임', 'pageNumber': 6},
];

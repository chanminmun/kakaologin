import 'package:flutter/material.dart';

class TimePage extends StatefulWidget {
  final String title; // 버튼에서 받은 제목을 전달받음

  const TimePage({Key? key, required this.title}) : super(key: key);

  @override
  _TimePageState createState() => _TimePageState();
}

class _TimePageState extends State<TimePage> {
  @override
  Widget build(BuildContext context) {
    // 08:00부터 20:30까지 30분 간격으로 시간 목록 생성
    List<String> times = [];
    for (int hour = 8; hour <= 20; hour++) {
      times.add('$hour:00');
      if (hour < 20) {
        times.add('$hour:30');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title), // 전달받은 title을 AppBar에 표시
      ),
      body: ListView.builder(
        itemCount: times.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // 각 버튼 클릭 시 동작 정의
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Text('선택한 시간: ${times[index]}'),
                  ),
                );
              },
              child: Text(times[index]),
            ),
          );
        },
      ),
    );
  }
}

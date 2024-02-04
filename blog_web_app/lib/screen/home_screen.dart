import 'package:flutter/material.dart';
// 웹뷰 플러그인 적용
import 'package:webview_flutter/webview_flutter.dart';
class HomeScreen extends StatelessWidget {
  WebViewController? controller; // 선언되어 있지 않아서 HomeScreen 앞에 있던 const 없애야 함.
                                 // 모든 값이 상수여야만 생성자 앞에 const 붙일 수 있음.
  // 1. const 생성자 XX
   HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( // 1. 앱바 위젯 추가
        backgroundColor: Colors.green, // 2. 배경색 지정
        title: Text('Naver Testing'),    // 3. 앱 타이틀 설정
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {
            if (controller != null) {
              controller!.loadUrl('https://www.naver.com');
            }
          }, icon: Icon(
            Icons.home,
            ),
          ),
          IconButton(onPressed: () {
            if (controller != null) {
              controller!.goBack();
            }
          }, icon: Icon(
            Icons.arrow_back,
          )),
          IconButton(onPressed: () {
            if (controller != null) {
              controller!.goForward();
            }
          }, icon: Icon(
            Icons.arrow_forward,
          ))
        ],
      ),
      body: WebView(
        // 웹뷰 생성 함수
        onWebViewCreated: (WebViewController controller) {
          this.controller = controller; // 위젯에 컨트롤러 저장
        },
        initialUrl: 'https://www.naver.com',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
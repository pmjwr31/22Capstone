//ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_application_1/src/pages/home.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/all.dart';

void main() {
  KakaoContext.clientId = "71c004e121e337a95b8db8d73f8df969";
  runApp(LoginWidget());
}

class LoginWidget extends StatelessWidget {
  LoginWidget({Key? key}) : super(key: key);
  //구글 로그인 소스 코드
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  //카카오 로그인 소스 코드
  Future<void> _loginButtonPressed() async {
    String authCode = await AuthCodeClient.instance.request();
    print(authCode);
  }

  //로그인 버튼 구현
  @override
  Widget build(BuildContext context) {
    //로그인 구현하기
    return Scaffold(
      appBar: AppBar(
        title: Text('SNS Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //구글 로그인
            TextButton(
              onPressed: signInWithGoogle,
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.grey.withOpacity(0.3),
              ),
              child: Text('Google Login'),
            ),
            TextButton(
              onPressed: _loginButtonPressed,
              style: TextButton.styleFrom(
                primary: Colors.yellow,
                backgroundColor: Colors.black,
              ),
              child: Text('Kakao Login'),
            ),
          ],
        ),
      ),
    );
  }
}

// Future<void> _loginButtonPressed() async {
//   String authCode = await AuthCodeClient.instance.request();
//   print(authCode);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Center(
//       child: Column(
//         children: [
//           TextButton(
//               onPressed: _loginButtonPressed,
//               style: TextButton.styleFrom(
//                 primary: Colors.black,
//                 backgroundColor: Colors.black,
//               ),
//               child: Text('Kakao Login'))
//         ],
//       ),
//     ));
//   }
// }

// class KakaoLogin extends StatelessWidget {
//   const KakaoLogin({Key? key}) : super(key: key);

//   Future<void> _loginButtonPressed() async {
//     String authCode = await AuthCodeClient.instance.request();
//     // ignore: avoid_print
//     print(authCode);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: SafeArea(
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 TextButton(
//                     onPressed: _loginButtonPressed,
//                     style: TextButton.styleFrom(
//                       primary: Colors.black,
//                       backgroundColor: Colors.yellow,
//                     ),
//                     child: Text('Kakao Login'))
//                 // ElevatedButton(
//                 //     onPressed: _loginButtonPressed, child: Text('Kakao Login'))
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class FlutterKakaoLoginView extends StatefulWidget {
//   const FlutterKakaoLoginView({Key? key}) : super(key: key);

//   @override
//   _FlutterKakaoLoginViewState createState() => _FlutterKakaoLoginViewState();
// }

// class _FlutterKakaoLoginViewState extends State<FlutterKakaoLoginView> {
//   static final FlutterKakaoLogin kakaoSignin = flutterKakaoLogin();
//   bool _isLogined = false;
//   String _accessToken = "";
//   String _refreshToken = "";
//   String _accountInfo = "";
//   String _loginMessage = 'Not Logged In';
//   @override
//   void initState() {
//     super.initState();
//     loadKakao();
//   }

//   void loadKakao() async {
//     await kakaoSignin.init('71c004e121e337a95b8db8d73f8df969');

//     final hashKey = await kakaoSignin.hashKey;
//     print('hashKey:$hashKey');
//   }

//   Future<void> flutterKakaoLogin() async{
//     try {
//       final loginResult = await kakaoSignin.logIn();
//       _processLoginResult(loginResult);
//     } on PlatformException catch (e) {
//       print ("${e.code}${e.message}");
//     }
//   }

//   void _updateAccessToken(String accessToken){
//     setState(() {
//       _accessToken = accessToken;
//     });
//   }

//   void _updateRefreshToken(String refreshToken){
//     setState(() {
//       _refreshToken = refreshToken;
//     });
//   }  

//   void _updateAccountMessage(String message){
//     setState(() {
//       _accountInfo = message;
//     });
//   }

//   void _updateStateLogin(bool isLogined, KakaoLoginResult result) {
//     setState(() {
//       _isLogined = isLogined;
//     });
//     if (!isLogined) {
//       _updateAccessToken('');
//       _updateRefreshToken('');
//       _updateAccountMessage('');
//     } else {
//       if (result.token != null && result.token!.accessToken != null) {
//         _updateAccessToken(result.token!.accessToken!);
//         _updateRefreshToken(result.token!.refreshToken!);
//       }
//     }
//   }
//   void _updateLoginMessage(String message) {
//     setState(() {
//       _loginMessage = message;
//     });
//   }

//   void _processLoginResult(KakaoLoginResult result) {
//     switch (result.status) {
//       case KakaoLoginStatus.loggedIn:
//         _updateLoginMessage('Logged In by the user.');
//         _updateStateLogin(true, result);
//         break;
//       case KakaoLoginStatus.loggedOut:
//         _updateLoginMessage('Logged In by the user.');
//         _updateStateLogin(false, result);
//         break;
//       case KakaoLoginStatus.unlinked:
//         _updateLoginMessage('Unlinked by the user');
//         _updateStateLogin(false, result);
//         break;
//     }
//   }

//   Future<void> _unlink() async {
//     try {
//       final result = await kakaoSignin.unlink();
//       _processLoginResult(result);
//     } on PlatformException catch (e) {
//       _updateLoginMessage('${e.code}: ${e.message}');
//     }
//   }

//   Widget build(BuildContext context) {
//     return Container(
//       alignment: Alignment.center,
//         color: Colors.white,
//         child: Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Row(
//                 children: [
//                   ElevatedButton(
//                     child: Text('LogIn'),
//                     onPressed: () {
//                       flutterKakaoLogin();
//                     },
//                   ),
//                   ElevatedButton(
//                       onPressed: () {
//                         _unlink();
//                       },
//                       child: Text('Log Out'))
//                 ],
//               ),
//               _isLogined
//                   ? Text(
//                       '로그인 되었습니다.',
//                       style: TextStyle(fontSize: 18.0, color: Colors.black),
//                     )
//                   : Text('로그아웃 상태 ',
//                       style: TextStyle(fontSize: 18.0, color: Colors.black)),
//               Text(
//                 'access_token: $_accessToken',
//                 style: TextStyle(fontSize: 18.0, color: Colors.black),
//               ),
//               Text(
//                 'refresh_token: $_refreshToken',
//                 style: TextStyle(fontSize: 18.0, color: Colors.black),
//               ),
//               Text(
//                 'accountInfo: $_accountInfo',
//                 style: TextStyle(fontSize: 18.0, color: Colors.black),
//               ),
//               Text('loginMessage: $_loginMessage',
//                   style: TextStyle(fontSize: 18.0, color: Colors.black)),
//             ],
//           ),
//         ));
//   }
// }

            // TextButton(
            //   //카카오 로그인
            //   onPressed: flutterKakaoLogin(),
            //   style: TextButton.styleFrom(
            //     primary: Colors.black,
            //     backgroundColor: Colors.yellow,
            //   ),
            //   child: Text("Kakao Login"),
            // )

// class KakaoLogin extends StatefulWidget {
//   const KakaoLogin({Key? key}) : super(key: key);

//   @override
//   _KakaoLoginState createState() => _KakaoLoginState();
// }

// class _KakaoLoginState extends State<KakaoLogin> {
//   bool _isKakaoTalkInstalled = false;

//   @override
//   void initState() {
//     _initKakaoTalkInstalled();
//     super.initState();
//   }

//   _initKakaoInstalled() async {
//     final installed = await isKakaoTalkInstalled();
//     print('kakao install : ' + installed.toString());

//     setState(() {
//       _isKakaoTalkInstalled = installed;
//     });
//   }

//   _issueAccessToken(String authCode) async{
//     try {
//       var token = await AuthApi.instance.issueAccessToken(authCode);
//       AccessTokenStore.instance.toStore(token);
//       print(token);
//       Navigator.push(context, MaterialPageRoute(
//         builder: (context) => Home(),
//         ));
//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   _loginWithKakao() async {
//     try{
//       var code = await AuthCodeClient.instance.requestWithTalk();
//       await _issueAccessToken(code);
//     }
//   }

//   Widget build(BuildContext context) {
//     return Container();
//   } catch (e) {
//     print(e.toString());
//   }
// }

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zendesk2/zendesk2.dart';
import 'package:zendesk2_example/zendesk_answer.dart';
import 'package:zendesk2_example/zendesk_chat.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(accentColor: Colors.amber),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  final z = Zendesk.instance;
  final _accountKey='';
  final _appId='';
  String clientId = '';
  String zendeskUrl = '';

  void answer() async {
    z.initAnswerSDK(_appId, clientId, zendeskUrl);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ZendeskAnswerUI()));
  }

  void chat() async {
    String name = '';
    String email = '';
    String phoneNumber = '+218912345678';

    await z.initChatSDK(_accountKey, _appId);

    Zendesk2Chat zChat = Zendesk2Chat.instance;

    await zChat.setVisitorInfo(
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      tags: ['app', 'zendesk'],
    );


    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ZendeskChat()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Center(
        child: Text('Press on FAB to start chat'),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton.extended(
            heroTag: 'answer',
            icon: Icon(FontAwesomeIcons.comments),
            label: Text('Answer BOT'),
            onPressed: answer,
          ),
          FloatingActionButton.extended(
            heroTag: 'chat',
            icon: Icon(FontAwesomeIcons.comments),
            label: Text('Chat SDK V2'),
            onPressed: chat,
          ),
        ],
      ),
    );
  }
}

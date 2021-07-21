import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:udemy_flutter_firebase_moblieapp/model/memo.dart';

class MemoPage extends StatelessWidget {
  //final Memo memo;
  final QueryDocumentSnapshot memo;
  // MemoPageに来る際にmemo型を送ってね
  MemoPage(this.memo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text('確認画面')
        title: Text(memo.get('title')),
      ),
      body: Center( //Opt+EnterでCenterを選択できる
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('メモ内容', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            //Text('実際の内容'),
            Text(memo.get('detail'))
          ],
        ),
      ),

    );
  }
}

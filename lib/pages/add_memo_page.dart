import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// メイン画面右下の＋ボタンで入力画面に遷移
class AddMemoPage extends StatefulWidget {
  const AddMemoPage({Key? key}) : super(key: key);

  @override
  _AddMemoPageState createState() => _AddMemoPageState();
}

class _AddMemoPageState extends State<AddMemoPage> {
  // テキストフィールド入力内容を管理するために必要
  TextEditingController titleController = TextEditingController();
  TextEditingController detailController = TextEditingController();

  // +ボタンでFireStoreに保存、通信時間がかかる
  // addMemoメソッドは追加ボタンを押したら実行されるー＞　onPressへ
  Future<void> addMemo() async{
    //firestoreの[memo]コレクションに追加するために取得する
    var collection = FirebaseFirestore.instance.collection('memo');
    await collection.add({
      'title': titleController.text,   // 入力画面での内容を取得
      'detail': detailController.text,
      'created_date': Timestamp.now()
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('memoを追加'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text('タイトル'),
            ),
            Padding( // paddingは後から設定する
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey) // 下記で下線をなくした代わりに枠線
                ),
                  width: MediaQuery.of(context).size.width * 0.8, // 画面幅の8割
                  child: TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 10)
                    ), // 入力個所の下線をなくす
                  )
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text('メモ内容'),
            ),
            Padding( // paddingは後から設定する
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey) // 下記で下線をなくした代わりに枠線
                  ),
                  width: MediaQuery.of(context).size.width * 0.8, // 画面幅の8割
                  child: TextField(
                    controller: detailController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 10)
                    ), // 入力個所の下線をなくす
                  )
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                alignment: Alignment.center,
                //child: RaisedButton( // Flutter2.0以降で非推奨になった
                //   color: Theme.of(context).primaryColor,
                child: ElevatedButton(
                  onPressed: () async{
                    // 追加ボタンを押すと１Firestoreに保存、２TopPageに戻る
                    // 1 addMemoは時間がかかるが、１が終わってから２の処理へ
                    // onPressにもasync　とawaitを利用する
                    await addMemo();
                    // 今の階層を取り除く＝TopPageに戻ることに等しい
                    Navigator.pop(context);
                  },
                  child: Text('追加'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black, // ボタンの背景色
                  ),
                ),
              )
            ),

          ],
        ),
      )
    );
  }
}

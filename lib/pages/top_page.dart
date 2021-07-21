import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:udemy_flutter_firebase_moblieapp/model/memo.dart';
import 'package:udemy_flutter_firebase_moblieapp/pages/add_edit_memo_page.dart';
import 'package:udemy_flutter_firebase_moblieapp/pages/add_memo_page.dart';
import 'package:udemy_flutter_firebase_moblieapp/pages/memo_page.dart';



class TopPage extends StatefulWidget {
TopPage({Key? key, required this.title}) : super(key: key);

final String title;

@override
_TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {

  /**
  List<Memo> memoList = []; // <Memo>とあるがmemo型って存在する？？ -> importする！Memo.dart
  // メモ内容をFirebaseから取得する関数
  Future<void> getMemo() async{
    // Firebaseから取得するのに時間がかかるので[await]を追記する、Firebaseにmemoとして登録したはず
    var snapshot = await FirebaseFirestore.instance.collection('memo').get();
    var docs = snapshot.docs;
    docs.forEach((doc) {
      print(doc);
      memoList.add(Memo(
        title: doc.data()['title'],
        detail: doc.data()['detail']
        //title: doc.get('title'),
        //detail: doc.get('detail'),
      ));
    });
    // 画面の再描画
    setState(() {});
  }
   **/

  // Firestoreのコレクション参照用としてmemosを準備
  // Firestoreからのデータを格納しておく変数
  late CollectionReference memos;
  //QueryDocumentSnapshot memos;

  // [init]と入力すると予測変換で出てくる
  // buildする前に初期化して、getMemoする
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getMemo();
    memos = FirebaseFirestore.instance.collection('memo');
  }

  // 削除ボタンのメソッドを作成する
  Future<void> deleteMemo(String docId) async{
    var document = FirebaseFirestore.instance.collection('memo').doc(docId);
    document.delete();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: StreamBuilder<QuerySnapshot>(
        // streamの意味はmemosに変更があるとbuilderが動く
        stream: memos.snapshots(), //リアルタイム監視？
        builder: (context, snapshot) {
          //Firebaseからデータ取得中なら
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data!.docs[index].get('title')),
                //title: Text(memoList[index].title),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // ボタンを押すと画面下にダイヤログが現れる処理を書く
                    showModalBottomSheet(context: context, builder: (context) {
                      return SafeArea(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: Icon(Icons.edit, color: Colors.blueAccent,),
                              title: Text('編集'),
                              onTap: () {
                                // 編集ボタンを押した際にページ遷移
                                Navigator.pop(context);
                                Navigator.push(context, MaterialPageRoute(builder: (context) => AddEditMemoPage(memo: snapshot.data!.docs[index],)));

                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.delete, color: Colors.redAccent,),
                              title: Text('削除'),
                              onTap: () async{
                                await deleteMemo(snapshot.data!.docs[index].id);
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      );
                    });
                  },
                ),
                onTap: () {
                  // 画面遷移Navigator、後ほど実装
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MemoPage(snapshot.data!.docs[index])));
                },
              );
            },
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddMemoPage()));
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}

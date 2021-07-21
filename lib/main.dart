import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:udemy_flutter_firebase_moblieapp/pages/top_page.dart';


void main() async{

  // Firebase初期化、asyncは非同期
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: TopPage(title: 'Flutter x Firebase Memo app'),
    );
  }
}

//mission ;  メモアプリの作成
//todo ; デフォルトの「MyHomePage」は「top_pages.dart」に切り分け
//  「MyHomePage」は「TopPage」に変更する
//todo ; アプリのタイトルを変更
//todo ; メモクラスを定義
//todo ; Android Firebaseプロジェクトの作成
/*
* Firebaseに登録
* １，アプリの登録
* ２，設定ファイルのダウンロード; jsonをDLしてapp直下に配置
* ３，FirebaseSDKの追加、必要事項をコピペする
* （１）プロジェクト レベルの build.gradle（<project>/build.gradle）: classpath
* （２）アプリレベルの build.gradle（<project>/<app-module>/build.gradle）: apply plugin
* */
//todo ; ios Firebaseプロジェクトの作成
//todo ;　Cloud
/*
* Firebaseを作ったらそのまま「Cloud Firestore」も準備する
* https://qiita.com/1amageek/items/d606dcee9fbcf21eeec6
* 「Cloud Firestore」　：　NoSQLデータベース,開発でスピード重視、小さく回すなら十分
* 設定手順　[データベースの作成] - [テストモード] - location[asia-northeast1]
* 作成できたら決めうちでデータ入力　[コレクションを開始]
* 今回はtitleとdetail
* */
//todo ; FlutterとFirebaseの連携
/*
* 1, pubspec.yamlに追記してインストール
* dart packagesでググる、FlutterHP内で[firebase]で検索
* [firebase_core] をインストール　[firebase_core: ^1.4.0] を[pubspec.yaml]に追記する
*   cupertino_icons: ^1.0.2
  firebase_core: ^1.4.0
  cloud_firestore: ^2.4.0
*　追記後にStudio画面上にある「pub get」を押す
*
* ２，main.dartにFirebaseのinitialize
*
* ３，studio画面の赤■ボタンを押してmain.dartを停止してから
* アプリを起動するとよい、新しいライブラリを入れたから
*
* 4, 実行してConsoleでエラーが出たら[app/build.grade]にて
*　minSdkVersion 16->23　にしてみる
* 実行できればFirebaseとの連携もできている
*
* */

//todo ; main.dartで[async]としたが、よくわかってない

//todo ; TopPageにメモの詳細を確認可能に
/**
* top_page.dartのbodyにメモ内容を表示する
* 関数getMemoでFirebaseから内容を取得、setState()で描画更新
* initStateしてから buildする
* https://qiita.com/nkmk1215/items/7d73b4fd8cb5ec5ac486
*
* 動画の通りに実装しても'title'や'detail'で怒られる
* memo.dart にて　[require]を追加したらOKだった（エラー表示の指示に従っただけ）
* エラー内容はNullがどうのこうのなので、Nullsafetyかもしれない（Flutter2.0以降のupdate）
* 変数にNullが入る可能性があることを警告していたようだ
* */
//todo ; リストをタップでメモの詳細を確認可能に
/**
* memo_page.dartを作成、リストタップ後の内容を記述する
* top_page.dart からonTapで画面遷移,Navigatorで実装
*
* */

//todo ; メモ追加画面のUIを作成
/**
 * add_memo_page.dart　で＋ボタン押した後の遷移画面を簡易作成
 * top_page.dart のonPress　にNavigatorで遷移を記述
 *
 * TextEditingControllerでテキストフィールドの入力内容を管理する
 *
 */

//todo ; 追加ボタンタップでメモを追加可能に
/**
 * +ボタンでメモを追加する、FireStoreに保存、メイン画面に反映する
 * Cloud firestore を確認する
 * 　コレクション[memo] - ドキュメント[hifaru****] - フィールド[ detail / title]
 * Firestoreに保存するのもじかんがかかるのでasync＋awaitを利用する
 */

//todo ; 追加したメモをリアルタイム取得表示
/**
 * QuerySnapshot って何よ
 * https://qiita.com/kabochapo/items/1ef39942ac1206c38b2d
 * https://tenderfeel.xsrv.jp/javascript/4980/
 *
 * late CollectionReference memos
 * 動画だと[ CollectionReference memos ] で記述している.
 * NullSfatyに対処する必要がある（Flutter2以降をつかっているから）
 * エラーがあれば赤波線が表示される、大抵はopt+Enterで対処できる
 */

//todo ; リストの右側のボタンタップでボトムシートを表示
/**
 * リストの右端にボタンを準備して
 * top_page.dartに記述する、　trailingを使う
 *　
 */


//todo ; 編集画面をさくせいしメモを更新可能に
/**
 * [add_edit_memo.dart] を作成.　add_memo_pageを利用する
 * 新規追加の[add_memo_page]をnullなら新規、nullじゃないなら編集として判断
 *　
 */
//todo ; メモを削除可能に
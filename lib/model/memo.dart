// メモクラスを定義
class Memo {
  String title;
  String detail;
  //DateTime createdTime; //作成日
  //DateTime updatedDate; //更新日

  // コンストラクタ
  //Memo({this.title, this.detail, this.createdTime, this.updatedDate}) //Flutter2以降ではNullsafetyでエラー
  //Memo({required this.title, required this.detail, required this.createdTime, required this.updatedDate})
  Memo({required this.title, required this.detail});
}


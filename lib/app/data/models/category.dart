import 'package:equatable/equatable.dart';

import 'Word.dart';

class Category extends Equatable {
  int _ID = -1 ;
  String _name = "";
  String _pictureSrc="";
  int _isCompleted=0;
  int _reward=50;
  List<Word>? _words;

  Category(this._ID,this._name,this._pictureSrc,this._isCompleted,this._reward,[this._words]);

  Category.withoutSettings([this._name = "",this._pictureSrc="",this._isCompleted = 0,this._reward=50]);

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    json["ID"],
    json["Name"],
    json["PictureSrc"],
    json["isCompleted"],
    json["Reward"],
  );

  Map<String, dynamic> toJson() => {
    "Name": _name,
    "PictureSrc": _pictureSrc,
    "isCompleted":_isCompleted,
    "Reward":_reward,
  };

  // equatible paketinden geliyor obje karşılaştırıken kullanılacak
  @override
  List<Object?> get props => [
    _name,
  ];
  int get ID => _ID;

  set ID(int value) {
    _ID = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get pictureSrc => _pictureSrc;

  set pictureSrc(String value) {
    _pictureSrc = value;
  }

  int get isCompleted => _isCompleted;

  set isCompleted(int value) {
    _isCompleted = value;
  }

  int get reward => _reward;

  set reward(int value) {
    _reward = value;
  }

  List<Word> get words => _words!;

  set words(List<Word> value) {
    _words = value;
  }
}

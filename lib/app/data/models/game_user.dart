class GameUser {
  int _userID = -1;
  int _gameID = -1;
  double _score = -1;
  int _timeTaken = -1;
  DateTime _date = DateTime.now().toUtc();
  bool _isFinished = false;

  GameUser(
    this._userID,
    this._gameID,
    this._score,
    this._timeTaken,
    this._date,
    this._isFinished,
  );

  GameUser.fromJson(dynamic json) {
    _userID = json['UserID'];
    _gameID = json['GameID'];
    _score = json['Score'];
    _timeTaken = json['Timetaken'];
    _date = DateTime.parse(json['Date']);
    _isFinished = json['IsFinished'] == 1;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['UserID'] = _userID;
    map['GameID'] = _gameID;
    map['Score'] = _score;
    map['Timetaken'] = _timeTaken;
    map['Date'] = _date.toIso8601String();
    map['IsFinished'] = _isFinished ? 1 : 0;

    return map;
  }

  get isFinished => this._isFinished;
  set isFinished(value) => this._isFinished = value;

  get userID => this._userID;
  set userID(value) => this._userID = value;

  get gameID => this._gameID;
  set gameID(value) => this._gameID = value;

  double get score => this._score;
  set score(double value) => this._score = value;

  get timeTaken => this._timeTaken;
  set timeTaken(value) => this._timeTaken = value;

  DateTime get date => this._date;
  set date(DateTime value) => this._date = value;
}

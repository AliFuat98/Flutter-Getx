class Content {
  int _id = -1;
  String _name = "";
  String _pictureSrc = "";
  bool _isPurchased = false;
  int _price = 50;
  int _category = 1;

  Content(
    this._id,
    this._name,
    this._pictureSrc,
    this._isPurchased,
    this._price,
    this._category,
  );

  Content.withoutSettings([
    this._name = "",
    this._pictureSrc = "",
    this._isPurchased = false,
    this._price = 50,
    this._category = 1,
  ]);

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        json["ID"],
        json["Name"],
        json["PictureSrc"],
        json["isPurchased"] == 1,
        json["Price"],
        json["Category"],
      );

  Map<String, dynamic> toJson() => {
        "Name": _name,
        "PictureSrc": _pictureSrc,
        "isPurchased": _isPurchased ? 1 : 0,
        "Price": _price,
        "Category": _category,
      };

  get category => this._category;
  set category(value) => this._category = value;

  int get price => this._price;
  set price(int value) => this._price = value;

  get isPurchased => this._isPurchased;
  set isPurchased(value) => this._isPurchased = value;

  String get pictureSrc => this._pictureSrc;
  set pictureSrc(String value) => this._pictureSrc = value;

  get name => this._name;
  set name(value) => this._name = value;

  int get id => this._id;
  set id(int value) => this._id = value;
}

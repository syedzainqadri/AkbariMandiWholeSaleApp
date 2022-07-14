class OnBoardingModel {
  String _imageUrl;
  String _title;
  String _description;
  String _title2;
  String _title3;

  get imageUrl => _imageUrl;
  get title => _title;
  get title2 => _title2;
  get title3 => _title3;
  get description => _description;

  OnBoardingModel(
    this._imageUrl,
    this._title,
    this._description,
    this._title2,
    this._title3,
  );
}

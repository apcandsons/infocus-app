class Account {
  String _id;
  String _email;
  String _name;

  Account(this._id, this._email, this._name);

  String get id => _id;
  String get email => _email;
  String get name => _name;
}
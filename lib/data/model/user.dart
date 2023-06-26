import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String fullName;
  final int coins;

  const User(this.fullName, this.coins);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(json['fullName'], json['coins']);
  }
  Map<String, dynamic> toJson() {
    return {'fullName': fullName, 'coins': coins};
  }

  @override
  List<Object?> get props => [fullName, coins];
}

import 'package:equatable/equatable.dart';

class CoinsModel extends Equatable {
  final int coins;

  const CoinsModel(this.coins);

  factory CoinsModel.fromJson(Map<String, dynamic> json) =>
      CoinsModel(json['coins']);

  Map<String, dynamic> toJson() => {'coins': coins};

  @override
  List<Object?> get props => [coins];
}

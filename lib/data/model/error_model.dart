import 'package:equatable/equatable.dart';

class ErrorModel extends Equatable {
  final String msg;

  const ErrorModel(this.msg);

  factory ErrorModel.fromJson(Map<String, dynamic> json) =>
      ErrorModel(json['msg']);

  Map<String, dynamic> toJson() => {'msg': msg};

  @override
  List<Object?> get props => [msg];
}

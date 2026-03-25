import 'package:equatable/equatable.dart';

class Categories extends Equatable {
  final String? name;

  const Categories({this.name});

  factory Categories.fromJson(Map<String, dynamic> json) =>
      Categories(name: json['name'] as String?);

  Map<String, dynamic> toJson() => {'name': name};

  @override
  List<Object?> get props => [name];
}

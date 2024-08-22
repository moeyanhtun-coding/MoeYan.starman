import 'dart:ffi';

import 'package:collection/collection.dart';

class CustomModel {
  double? starSaleAmount;
  String? warehouseName;

  CustomModel({this.starSaleAmount, this.warehouseName});

  @override
  String toString() {
    return 'CustomModel(starSaleAmount: $starSaleAmount, warehouseName: $warehouseName)';
  }

  factory CustomModel.fromJson(Map<String, dynamic> json) => CustomModel(
        starSaleAmount: json['starSaleAmount'] as double?,
        warehouseName: json['warehouseName'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'starSaleAmount': starSaleAmount,
        'warehouseName': warehouseName,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! CustomModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => starSaleAmount.hashCode ^ warehouseName.hashCode;
}

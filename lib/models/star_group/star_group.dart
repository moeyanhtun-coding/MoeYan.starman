import 'package:collection/collection.dart';

class StarGroup {
  int? id;
  String? busniessName;
  String? busniessPhone;
  String? busniessAddress;
  String? starId;

  StarGroup({
    this.id,
    this.busniessName,
    this.busniessPhone,
    this.busniessAddress,
    this.starId,
  });

  @override
  String toString() {
    return 'StarGroup(id: $id, busniessName: $busniessName, busniessPhone: $busniessPhone, busniessAddress: $busniessAddress, starId: $starId)';
  }

  factory StarGroup.fromJson(Map<String, dynamic> json) => StarGroup(
        id: json['id'] as int?,
        busniessName: json['busniessName'] as String?,
        busniessPhone: json['busniessPhone'] as String?,
        busniessAddress: json['busniessAddress'] as String?,
        starId: json['starId'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'busniessName': busniessName,
        'busniessPhone': busniessPhone,
        'busniessAddress': busniessAddress,
        'starId': starId,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! StarGroup) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      busniessName.hashCode ^
      busniessPhone.hashCode ^
      busniessAddress.hashCode ^
      starId.hashCode;
}

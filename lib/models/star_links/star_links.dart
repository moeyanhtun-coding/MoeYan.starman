import 'package:collection/collection.dart';

class StarLinks {
	int? id;
	String? warehouseName;
	String? warehouseLocation;
	String? prefix;
	String? userId;
	String? starId;
	String? appName;
	String? version;
	String? status;

	StarLinks({
		this.id, 
		this.warehouseName, 
		this.warehouseLocation, 
		this.prefix, 
		this.userId, 
		this.starId, 
		this.appName, 
		this.version, 
		this.status, 
	});

	@override
	String toString() {
		return 'StarLinks(id: $id, warehouseName: $warehouseName, warehouseLocation: $warehouseLocation, prefix: $prefix, userId: $userId, starId: $starId, appName: $appName, version: $version, status: $status)';
	}

	factory StarLinks.fromJson(Map<String, dynamic> json) => StarLinks(
				id: json['id'] as int?,
				warehouseName: json['warehouseName'] as String?,
				warehouseLocation: json['warehouseLocation'] as String?,
				prefix: json['prefix'] as String?,
				userId: json['userId'] as String?,
				starId: json['starId'] as String?,
				appName: json['appName'] as String?,
				version: json['version'] as String?,
				status: json['status'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'warehouseName': warehouseName,
				'warehouseLocation': warehouseLocation,
				'prefix': prefix,
				'userId': userId,
				'starId': starId,
				'appName': appName,
				'version': version,
				'status': status,
			};

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! StarLinks) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toJson(), toJson());
	}

	@override
	int get hashCode =>
			id.hashCode ^
			warehouseName.hashCode ^
			warehouseLocation.hashCode ^
			prefix.hashCode ^
			userId.hashCode ^
			starId.hashCode ^
			appName.hashCode ^
			version.hashCode ^
			status.hashCode;
}

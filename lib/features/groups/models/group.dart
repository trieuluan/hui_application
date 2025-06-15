import 'package:freezed_annotation/freezed_annotation.dart';

part 'group.freezed.dart';
part 'group.g.dart';

@JsonEnum(
  alwaysCreate: true,
) // 👈 Bắt JsonSerializable generate helper cho enum
enum CycleUnit {
  @JsonValue('day')
  day,

  @JsonValue('week')
  week,

  @JsonValue('month')
  month,
}

@JsonEnum(alwaysCreate: true)
enum GroupStatus {
  @JsonValue('inactive')
  inactive,
  @JsonValue('active')
  active,
  @JsonValue('completed')
  completed,
}

@Freezed(fromJson: true, toJson: true)
abstract class Group with _$Group {
  const Group._();

  const factory Group({
    @JsonKey(name: '_id') String? id,
    required String name,
    String? code,
    String? description,
    String? ownerId,

    @JsonKey(fromJson: _doubleFromJson, toJson: _doubleToJson)
    required double amountPerCycle,
    required int cycleDuration,
    required CycleUnit cycleUnit,

    required int totalCycles,
    int? maxMembers,
    @Default(false) bool autoStart,
    @Default(false) bool isPrivate,
    String? password,

    DateTime? startDate,
    DateTime? endDate,

    @Default(GroupStatus.inactive) GroupStatus status,

    @Default(null) DateTime? createdAt,
    @Default(null) DateTime? updatedAt,
  }) = _Group;

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  factory Group.fromForm(Map<String, dynamic> formValue) {
    return Group(
      name: formValue['name'] as String,
      description: formValue['description'] as String?,
      ownerId: formValue['ownerId'] as String?,
      amountPerCycle: _ensureDouble(formValue['amountPerCycle'].toString()),
      cycleDuration: int.parse(formValue['cycleDuration'].toString()),
      cycleUnit: CycleUnit.values.firstWhere(
        (e) => e.name == formValue['cycleUnit'],
        orElse: () => CycleUnit.day,
      ),
      totalCycles: int.parse(formValue['totalCycles'].toString()),
      maxMembers: int.tryParse(formValue['maxMembers'].toString()),
      autoStart: formValue['autoStart'] as bool? ?? false,
      isPrivate: formValue['isPrivate'] as bool? ?? false,
      password: formValue['password'] as String?,
    );
  }
}

extension GroupJsonHelper on Group {
  Map<String, dynamic> toJsonWithoutNull() {
    final json = toJson();
    json.removeWhere((k, v) => v == null);
    return json;
  }
}

// Hàm hỗ trợ để đảm bảo kiểu double
double _doubleFromJson(dynamic value) => (value as num).toDouble();
dynamic _doubleToJson(double value) => value;

double _ensureDouble(dynamic value) {
  if (value is int) {
    return value.toDouble(); // Chuyển đổi int thành double
  } else if (value is double) {
    return value;
  } else {
    return double.parse(value.toString());
  }
}

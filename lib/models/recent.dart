import 'package:freezed_annotation/freezed_annotation.dart';

part 'recent.freezed.dart';

@freezed
class Recent with _$Recent {
  const factory Recent({
    required String nsyId,
    required String nsyName,
    required int nsyPageNumber,
    required String paliName,
    required int paliPageNumber,
    required DateTime dateTime,
  }) = _Recent;
}

class RecentDao {
  final tableName = 'recent';
  final columnNsyId = 'nsy_id';
  final columnNsyName = 'nsy_name';
  final columnNsyPageNumber = 'nsy_page_number';
  final columnPaliName = 'pali_name';
  final columnPaliPageNumber = 'pali_page_number';
  final columnDateTime = 'date_time';

  Recent fromMap(Map<String, dynamic> map) {
    return Recent(
      nsyId: map[columnNsyId] as String,
      nsyName: map[columnNsyName] as String,
      nsyPageNumber: map[columnNsyPageNumber] as int,
      paliName: map[columnPaliName] as String,
      paliPageNumber: map[columnPaliPageNumber] as int,
      dateTime: DateTime.parse(map[columnDateTime] as String),
    );
  }

  List<Recent> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => fromMap(map)).toList();
  }

  Map<String, dynamic> toMap(Recent recent) {
    return {
      columnNsyId: recent.nsyId,
      columnNsyName: recent.nsyName,
      columnNsyPageNumber: recent.nsyPageNumber,
      columnPaliName: recent.paliName,
      columnPaliPageNumber: recent.paliPageNumber,
      columnDateTime: recent.dateTime.toIso8601String(),
    };
  }

}

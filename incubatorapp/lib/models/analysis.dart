import 'package:incubatorapp/models/patientanalysis.dart';
import 'package:json_annotation/json_annotation.dart';

part 'analysis.g.dart';

@JsonSerializable()

class Analysis {
  int id;
  String name;

  @JsonKey(ignore: true)
  List<PatientAnalysis> patientAnalysisList = [];

  Analysis(this.id,this.name);

  factory Analysis.fromJson(Map<String, dynamic> json) => _$AnalysisFromJson(json);

  Map<String, dynamic> toJson() => _$AnalysisToJson(this);
}

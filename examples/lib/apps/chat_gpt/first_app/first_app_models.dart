import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wt_models/wt_models.dart';

part 'first_app_models.freezed.dart';
part 'first_app_models.g.dart';

@freezed
class Experience extends BaseModel<Experience> with _$Experience {
  static final convert = DslConvert<Experience>(
    titles: ['yearsOfExperience', 'jobFunction', 'techFunction'],
    jsonToModel: Experience.fromJson,
    none: Experience.empty(),
  );

  factory Experience({
    required String? yearsOfExperience,
    required JobFunction? jobFunction,
    required TechFunction? techFunction,
  }) = _Experience;

  Experience._();

  factory Experience.fromJson(Map<String, dynamic> json) => _$ExperienceFromJson(json);

  factory Experience.empty() => Experience(
        yearsOfExperience: '',
        jobFunction: null,
        techFunction: null,
      );

  @override
  String getId() => yearsOfExperience ?? '';

  @override
  String getTitle() => '';

  @override
  List<String> getTitles() => convert.titles();
}

@freezed
class JobFunction extends BaseModel<JobFunction> with _$JobFunction {
  static final convert = DslConvert<JobFunction>(
    titles: ['name', 'skills'],
    jsonToModel: JobFunction.fromJson,
    none: JobFunction.empty(),
  );

  factory JobFunction({
    required String? name,
    required List<Skill>? skills,
  }) = _JobFunction;

  JobFunction._();

  factory JobFunction.fromJson(Map<String, dynamic> json) => _$JobFunctionFromJson(json);

  factory JobFunction.empty() => JobFunction(
        name: '',
        skills: null,
      );

  @override
  String getId() => name ?? '';

  @override
  String getTitle() => '';

  @override
  List<String> getTitles() => convert.titles();
}

@freezed
class TechFunction extends BaseModel<TechFunction> with _$TechFunction {
  static final convert = DslConvert<TechFunction>(
    titles: ['name', 'skills'],
    jsonToModel: TechFunction.fromJson,
    none: TechFunction.empty(),
  );

  factory TechFunction({
    required String? name,
    required List<Skill>? skills,
  }) = _TechFunction;

  TechFunction._();

  factory TechFunction.fromJson(Map<String, dynamic> json) => _$TechFunctionFromJson(json);

  factory TechFunction.empty() => TechFunction(
        name: '',
        skills: null,
      );

  @override
  String getId() => name ?? '';

  @override
  String getTitle() => '';

  @override
  List<String> getTitles() => convert.titles();
}

@freezed
class Skill extends BaseModel<Skill> with _$Skill {
  static final convert = DslConvert<Skill>(
    titles: ['name', 'proficiency'],
    jsonToModel: Skill.fromJson,
    none: Skill.empty(),
  );

  factory Skill({
    required String? name,
    required Proficiency? proficiency,
  }) = _Skill;

  Skill._();

  factory Skill.fromJson(Map<String, dynamic> json) => _$SkillFromJson(json);

  factory Skill.empty() => Skill(
        name: '',
        proficiency: null,
      );

  @override
  String getId() => name ?? '';

  @override
  String getTitle() => '';

  @override
  List<String> getTitles() => convert.titles();
}

@freezed
class Proficiency extends BaseModel<Proficiency> with _$Proficiency {
  static final convert = DslConvert<Proficiency>(
    titles: ['yearsRating', 'achievedRating', 'statusRating', 'potentialRating', 'upskillRating'],
    jsonToModel: Proficiency.fromJson,
    none: Proficiency.empty(),
  );

  factory Proficiency({
    required int? yearsRating,
    required int? achievedRating,
    required int? statusRating,
    required int? potentialRating,
    required int? upskillRating,
  }) = _Proficiency;

  Proficiency._();

  factory Proficiency.fromJson(Map<String, dynamic> json) => _$ProficiencyFromJson(json);

  factory Proficiency.empty() => Proficiency(
        yearsRating: 0,
        achievedRating: 0,
        statusRating: 0,
        potentialRating: 0,
        upskillRating: 0,
      );

  @override
  String getId() => '';

  @override
  String getTitle() => '';

  @override
  List<String> getTitles() => convert.titles();
}

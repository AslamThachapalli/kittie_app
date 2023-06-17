import 'package:cat_brochure_app/features/cat_list/domain/entities/cats.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cats_dto.freezed.dart';
part 'cats_dto.g.dart';

@freezed
class CatsDto with _$CatsDto {
  const CatsDto._();

  @JsonSerializable(explicitToJson: true)
  const factory CatsDto({
    required String id,
    required String url,
    required List<Breed> breeds,
  }) = _CatsDto;

  Cat toDomain() => Cat(
        id: id,
        imageUrl: url,
        wikiUrl: breeds.first.wikiUrl,
        breed: breeds.first.name,
        description: breeds.first.description,
        temperament: breeds.first.temperament,
        originCountry: breeds.first.origin,
        countryCode: breeds.first.countryCode,
        weight: breeds.first.weight.metric,
        intelligence: breeds.first.intelligence,
        lifeSpan: breeds.first.lifeSpan,
      );

  factory CatsDto.fromJson(Map<String, dynamic> json) =>
      _$CatsDtoFromJson(json);
}

@freezed
class Breed with _$Breed {
  @JsonSerializable(explicitToJson: true)
  const factory Breed({
    required Weight weight,
    required String name,
    required String description,
    required String temperament,
    required String origin,
    required int intelligence,
    @JsonKey(name: 'wikipedia_url') wikiUrl,
    @JsonKey(name: 'country_code') countryCode,
    @JsonKey(name: 'life_span') lifeSpan,
  }) = _Breed;

  factory Breed.fromJson(Map<String, dynamic> json) => _$BreedFromJson(json);
}

@freezed
class Weight with _$Weight {
  const factory Weight({required String metric}) = _Weight;

  factory Weight.fromJson(Map<String, dynamic> json) => _$WeightFromJson(json);
}

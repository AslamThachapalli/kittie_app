import 'package:freezed_annotation/freezed_annotation.dart';

part 'cats.freezed.dart';

@freezed
class Cat with _$Cat {
  const factory Cat({
    required String id,
    required String imageUrl,
    required String wikiUrl,
    required String breed,
    required String description,
    required String temperament,
    required String originCountry,
    required String countryCode,
    required String weight,
    required String lifeSpan,
    required int intelligence,
  }) = _Cat;
}

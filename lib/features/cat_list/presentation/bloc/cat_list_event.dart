part of 'cat_list_bloc.dart';

@freezed
class CatListEvent with _$CatListEvent {
  const factory CatListEvent.fetchAnotherBreed({required String breed}) =
      FetchAnotherBreed;
}

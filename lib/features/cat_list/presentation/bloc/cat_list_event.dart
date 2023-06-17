part of 'cat_list_bloc.dart';

@freezed
class CatListEvent with _$CatListEvent {
  const factory CatListEvent.refreshed({required String breed}) = Refreshed;
  const factory CatListEvent.fetchNextPage({required String breed}) =
      FetchNextPage;
  const factory CatListEvent.fetchAnotherBreed({required String breed}) =
      FetchAnotherBreed;
}

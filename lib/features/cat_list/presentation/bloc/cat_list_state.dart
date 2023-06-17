part of 'cat_list_bloc.dart';

@freezed
class CatListState with _$CatListState {
  const factory CatListState.initial() = Initial;
  const factory CatListState.loadInProgress() = LoadInProgress;
  const factory CatListState.catsFetched({
    required List<Cat> cats,
    required int length,
    required bool hasReachedTheEnd,
  }) = CatsFetched;
  const factory CatListState.loadFailure({
    required String message,
  }) = LoadFailure;
}

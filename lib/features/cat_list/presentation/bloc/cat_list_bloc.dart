import 'package:cat_brochure_app/features/cat_list/domain/entities/cats.dart';
import 'package:cat_brochure_app/features/cat_list/domain/usecases/get_cats_by_breed.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'cat_list_event.dart';
part 'cat_list_state.dart';
part 'cat_list_bloc.freezed.dart';

const String serverFailureMessage = "Some Unexpected Error Occurred";

@Injectable()
class CatListBloc extends Bloc<CatListEvent, CatListState> {
  List<Cat> fetchedCats = [];

  final GetCatsByBreed getCatsByBreed;

  CatListBloc({
    required this.getCatsByBreed,
  }) : super(const CatListState.initial()) {
    on<FetchAnotherBreed>((event, emit) async {
      emit(const LoadInProgress());

      fetchedCats.clear();
      final cats = await getCatsByBreed(Params(breed: event.breed));

      cats.fold(
        (failure) => failure.map(
          serverFailure: (_) =>
              emit(const LoadFailure(message: serverFailureMessage)),
        ),
        (catList) {
          List<Cat> updatedList = fetchedCats..addAll(catList);

          emit(
            CatsFetched(
              cats: updatedList,
              length: updatedList.length,
            ),
          );
        },
      );
    });
  }
}

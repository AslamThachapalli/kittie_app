import 'package:cat_brochure_app/features/cat_list/domain/entities/cats.dart';
import 'package:cat_brochure_app/features/cat_list/domain/usecases/get_cats_by_breed.dart';
import 'package:cat_brochure_app/features/cat_list/domain/usecases/reset_page_number.dart';
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
  final Refresh refresh;

  CatListBloc({
    required this.getCatsByBreed,
    required this.refresh,
  }) : super(const CatListState.initial()) {
    on<FetchNextPage>((event, emit) async {
      await fetchCatsAndEmitStates(emit, event.breed);
    });

    on<FetchAnotherBreed>((event, emit) async {
      emit(const LoadInProgress());

      refresh.refresh();
      fetchedCats.clear();
      await fetchCatsAndEmitStates(emit, event.breed);
    });

    on<Refreshed>((event, emit) async {
      emit(const LoadInProgress());

      refresh.refresh();
      fetchedCats.clear();
      await fetchCatsAndEmitStates(emit, event.breed);
    });
  }

  Future<void> fetchCatsAndEmitStates(Emitter emit, String breed) async {
    final cats = await getCatsByBreed(Params(breed: breed));

    cats.fold(
      (failure) => failure.map(
        noMoreCatFailure: (_) => emit(
          CatsFetched(
            cats: fetchedCats,
            length: fetchedCats.length,
            hasReachedTheEnd: true,
          ),
        ),
        serverFailure: (_) =>
            emit(const LoadFailure(message: serverFailureMessage)),
      ),
      (catList) {
        List<Cat> updatedList = fetchedCats..addAll(catList);

        emit(
          CatsFetched(
            cats: updatedList,
            length: updatedList.length,
            hasReachedTheEnd: (updatedList.length % 15) != 0 ? true : false,
          ),
        );
      },
    );
  }
}

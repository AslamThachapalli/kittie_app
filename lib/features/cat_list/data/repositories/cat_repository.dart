import 'package:cat_brochure_app/core/errors/exceptions.dart';
import 'package:cat_brochure_app/core/errors/failures.dart';
import 'package:cat_brochure_app/features/cat_list/data/datasources/get_cats_list.dart';
import 'package:cat_brochure_app/features/cat_list/domain/entities/cats.dart';
import 'package:cat_brochure_app/features/cat_list/domain/repositories/i_cat_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ICatRepository)
@Injectable()
class CatRepository implements ICatRepository {
  final GetCatsList _getCatsList;
  CatRepository(this._getCatsList);

  @override
  Future<Either<Failure, List<Cat>>> getCatsByBreed(
      {required String breed}) async {
    try {
      List<Cat> cats = [];
      final response = await _getCatsList.getCatsByBreed(breed);
      for (var res in response) {
        cats.add(res.toDomain());
      }
      return right(cats);
    } on ServerException catch (_) {
      return left(const ServerFailure());
    }
  }
}

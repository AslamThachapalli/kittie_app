import 'package:dartz/dartz.dart';
import 'package:cat_brochure_app/core/errors/failures.dart';
import 'package:cat_brochure_app/features/cat_list/domain/entities/cats.dart';

abstract class ICatRepository {
  Future<Either<Failure, List<Cat>>> getCatsByBreed({required String breed});
  void resetPageNumber();
}

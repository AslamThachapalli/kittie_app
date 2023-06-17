import 'package:cat_brochure_app/core/errors/failures.dart';
import 'package:cat_brochure_app/core/usecases/usecase.dart';
import 'package:cat_brochure_app/features/cat_list/domain/entities/cats.dart';
import 'package:cat_brochure_app/features/cat_list/domain/repositories/i_cat_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';


@LazySingleton()
@Injectable()
class GetCatsByBreed implements Usecase<List<Cat>, Params> {
  final ICatRepository _catRepository;
  GetCatsByBreed(this._catRepository);

  @override
  Future<Either<Failure, List<Cat>>> call(Params params) {
    return _catRepository.getCatsByBreed(breed: params.breed);
  }
}

class Params extends Equatable {
  final String breed;
  const Params({required this.breed});

  @override
  List<Object?> get props => [breed];
}

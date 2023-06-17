import 'package:cat_brochure_app/features/cat_list/domain/repositories/i_cat_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
@Injectable()
class Refresh {
  final ICatRepository _catRepository;
  Refresh(this._catRepository);

  void refresh() {
    return _catRepository.resetPageNumber();
  }
}

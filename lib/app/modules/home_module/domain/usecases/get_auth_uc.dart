import 'package:flutter_leap_v2/app/modules/home_module/domain/repositories/i_auth_repository.dart';
import 'package:flutter_leap_v2/app/modules/home_module/domain/usecases/intefaces/i_get_auth_uc.dart';
import 'package:get_it/get_it.dart';

class GetAuthUseCase implements IGetAuthUseCase {
  @override
  Future call() async {
    return await GetIt.I.get<IAuthRepository>().getRpmAuth();
  }
}

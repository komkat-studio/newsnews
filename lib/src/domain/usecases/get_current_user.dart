import 'package:firebase_auth/firebase_auth.dart';
import 'package:newsnews/src/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:newsnews/src/core/usecases/usecase.dart';
import 'package:newsnews/src/domain/repositories/firebase_repositories/firebase_services_repository.dart';

class GetCurrentUser extends Usecase<User, NoParams> {
  final FirebaseServicesRepository authRepository;

  GetCurrentUser({required this.authRepository});

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await authRepository.getCurrentUser();
  }
}

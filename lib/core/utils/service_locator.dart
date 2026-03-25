import 'package:get_it/get_it.dart';
import 'package:news_app/features/profile/data/profile_web_services/profile_web_services.dart';
import 'package:news_app/features/profile/data/repo/profile_repo_implementation.dart';

final getIt = GetIt.instance;
void startServiceLocator() {
  getIt.registerSingleton<ProfileRepoImplementation>(
    ProfileRepoImplementation(ProfileWebServices()),
  );
}

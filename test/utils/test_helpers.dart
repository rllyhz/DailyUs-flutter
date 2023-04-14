import 'package:daily_us/domain/repositories/daily_us_repository.dart';
import 'package:daily_us/domain/usecases/get_all_stories.dart';
import 'package:daily_us/domain/usecases/get_auth_info.dart';
import 'package:daily_us/domain/usecases/get_detail_story.dart';
import 'package:daily_us/domain/usecases/login.dart';
import 'package:daily_us/domain/usecases/logout.dart';
import 'package:daily_us/domain/usecases/register.dart';
import 'package:daily_us/domain/usecases/upload_new_story.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  DailyUsRepository,
  GetAllStories,
  GetAuthInfo,
  GetDetailStory,
  Login,
  Logout,
  Register,
  UploadNewStory,
])
void main() {}

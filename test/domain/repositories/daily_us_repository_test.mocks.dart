// Mocks generated by Mockito 5.4.0 from annotations
// in daily_us/test/domain/repositories/daily_us_repository_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:daily_us/common/failure.dart' as _i7;
import 'package:daily_us/domain/entities/auth_info.dart' as _i3;
import 'package:daily_us/domain/entities/localization.dart' as _i4;
import 'package:daily_us/domain/entities/story.dart' as _i9;
import 'package:daily_us/domain/entities/user.dart' as _i8;
import 'package:daily_us/domain/repositories/daily_us_repository.dart' as _i5;
import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeAuthInfo_1 extends _i1.SmartFake implements _i3.AuthInfo {
  _FakeAuthInfo_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeLocalization_2 extends _i1.SmartFake implements _i4.Localization {
  _FakeLocalization_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [DailyUsRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockDailyUsRepository extends _i1.Mock implements _i5.DailyUsRepository {
  MockDailyUsRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i2.Either<_i7.Failure, bool>> register(
    String? name,
    String? email,
    String? password,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #register,
          [
            name,
            email,
            password,
          ],
        ),
        returnValue: _i6.Future<_i2.Either<_i7.Failure, bool>>.value(
            _FakeEither_0<_i7.Failure, bool>(
          this,
          Invocation.method(
            #register,
            [
              name,
              email,
              password,
            ],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, bool>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, _i8.User?>> login(
    String? email,
    String? password,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #login,
          [
            email,
            password,
          ],
        ),
        returnValue: _i6.Future<_i2.Either<_i7.Failure, _i8.User?>>.value(
            _FakeEither_0<_i7.Failure, _i8.User?>(
          this,
          Invocation.method(
            #login,
            [
              email,
              password,
            ],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, _i8.User?>>);
  @override
  bool logout() => (super.noSuchMethod(
        Invocation.method(
          #logout,
          [],
        ),
        returnValue: false,
      ) as bool);
  @override
  _i3.AuthInfo getAuthInfo() => (super.noSuchMethod(
        Invocation.method(
          #getAuthInfo,
          [],
        ),
        returnValue: _FakeAuthInfo_1(
          this,
          Invocation.method(
            #getAuthInfo,
            [],
          ),
        ),
      ) as _i3.AuthInfo);
  @override
  _i6.Future<bool> updateAuthInfo(_i3.AuthInfo? authInfo) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateAuthInfo,
          [authInfo],
        ),
        returnValue: _i6.Future<bool>.value(false),
      ) as _i6.Future<bool>);
  @override
  _i4.Localization getLocalizationData() => (super.noSuchMethod(
        Invocation.method(
          #getLocalizationData,
          [],
        ),
        returnValue: _FakeLocalization_2(
          this,
          Invocation.method(
            #getLocalizationData,
            [],
          ),
        ),
      ) as _i4.Localization);
  @override
  _i6.Future<bool> updateLocalizationData(_i4.Localization? newLocalization) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateLocalizationData,
          [newLocalization],
        ),
        returnValue: _i6.Future<bool>.value(false),
      ) as _i6.Future<bool>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i9.Story>>> getAllStories(
    String? token,
    int? page,
    int? location,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getAllStories,
          [
            token,
            page,
            location,
          ],
        ),
        returnValue: _i6.Future<_i2.Either<_i7.Failure, List<_i9.Story>>>.value(
            _FakeEither_0<_i7.Failure, List<_i9.Story>>(
          this,
          Invocation.method(
            #getAllStories,
            [
              token,
              page,
              location,
            ],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, List<_i9.Story>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, _i9.Story>> getDetailStoryById(
    String? token,
    String? id,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getDetailStoryById,
          [
            token,
            id,
          ],
        ),
        returnValue: _i6.Future<_i2.Either<_i7.Failure, _i9.Story>>.value(
            _FakeEither_0<_i7.Failure, _i9.Story>(
          this,
          Invocation.method(
            #getDetailStoryById,
            [
              token,
              id,
            ],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, _i9.Story>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, bool>> uploadNewStory(
    String? token,
    List<int>? photoBytes,
    String? description,
    double? latitude,
    double? longitude,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #uploadNewStory,
          [
            token,
            photoBytes,
            description,
            latitude,
            longitude,
          ],
        ),
        returnValue: _i6.Future<_i2.Either<_i7.Failure, bool>>.value(
            _FakeEither_0<_i7.Failure, bool>(
          this,
          Invocation.method(
            #uploadNewStory,
            [
              token,
              photoBytes,
              description,
              latitude,
              longitude,
            ],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, bool>>);
}

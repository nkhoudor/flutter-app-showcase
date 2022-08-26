import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_demo/core/domain/model/user.dart';
import 'package:flutter_demo/features/auth/domain/model/log_in_failure.dart';
import 'package:flutter_demo/features/auth/login/login_initial_params.dart';
import 'package:flutter_demo/features/auth/login/login_presentation_model.dart';
import 'package:flutter_demo/features/auth/login/login_presenter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/auth_mock_definitions.dart';
import '../mocks/auth_mocks.dart';

void main() {
  late LoginPresentationModel model;
  late LoginPresenter presenter;
  late MockLoginNavigator navigator;

  test(
    'should show success when logInUseCase succeeded',
    () async {
      // GIVEN
      whenListen(
        Mocks.userStore,
        Stream.fromIterable([const User.empty()]),
      );

      when(() => AuthMocks.logInUseCase.execute(username: any(named: "username"), password: any(named: "password")))
          .thenAnswer((_) => successFuture(const User.empty()));
      when(() => navigator.showAlert(title: any(named: "title"), message: any(named: "message")))
          .thenAnswer((_) => Future.value());

      // WHEN
      presenter.onUserNameChanged("test");
      presenter.onPasswordChanged("test123");
      await presenter.onLoginPressed();

      // THEN
      verify(() => navigator.showAlert(title: any(named: "title"), message: any(named: "message")));
    },
  );

  test(
    'should show error when logInUseCase fails',
    () async {
      // GIVEN
      whenListen(
        Mocks.userStore,
        Stream.fromIterable([const User.empty()]),
      );

      when(() => AuthMocks.logInUseCase.execute(username: any(named: "username"), password: any(named: "password")))
          .thenAnswer((_) => failFuture(const LogInFailure.unknown()));
      when(() => navigator.showError(any())).thenAnswer((_) => Future.value());

      // WHEN
      presenter.onUserNameChanged("test");
      presenter.onPasswordChanged("test");
      await presenter.onLoginPressed();

      // THEN
      verify(() => navigator.showError(any()));
    },
  );

  setUp(() {
    model = LoginPresentationModel.initial(const LoginInitialParams());
    navigator = MockLoginNavigator();
    presenter = LoginPresenter(
      model,
      navigator,
      AuthMocks.logInUseCase,
    );
  });
}

part of 'test_cubit.dart';

@freezed
class TestState with _$TestState {
  ///State
  const factory TestState.initial() = _Initial;
  
  const factory TestState.loading() = _Loading;
  const factory TestState.loaded(List<Post> posts) = _Loaded;
  const factory TestState.error(String message) = _Error;
}

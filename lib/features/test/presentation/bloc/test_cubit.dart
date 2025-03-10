import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:realdrseattle/features/test/data/models/post.dart';
part 'test_state.dart';
part 'test_cubit.freezed.dart';

class TestCubit extends Cubit<TestState> {

  TestCubit() : super(TestState.initial());
  
  Future<void> fetchApi() async {
    emit(TestState.loading());
    try {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        emit(TestState.loaded(data.map((e) => Post.fromJson(e)).toList()));
      } else {
        emit(TestState.error('Something Went Wrong.'));
      }
    } catch (e) {
      emit(TestState.error(e.toString()));
    }
  }
}

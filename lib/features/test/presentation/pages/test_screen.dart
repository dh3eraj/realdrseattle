import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realdrseattle/features/test/presentation/bloc/test_cubit.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  late final TestCubit _cubit;
  @override
  void initState() {
    _cubit = context.read<TestCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TestCubit, TestState>(
      listener: (context, state) {
        state.maybeWhen(
          loading: () {},
          loaded: (data) {},
          error: (message) {},
          orElse: () {},
        );
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: state.maybeWhen(
              error: (message) {
                return Center(child: Text(message));
              },
              loaded: (posts) {
                return ListView.separated(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(posts[index].title ?? ''),
                      subtitle: Text(posts[index].body ?? ''),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                );
              },
              loading: () {
                return Center(child: CircularProgressIndicator.adaptive());
              },
              orElse: () {
                return Center(child: Text('Clicl + to call the API'));
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _cubit.fetchApi();
            },
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }
}

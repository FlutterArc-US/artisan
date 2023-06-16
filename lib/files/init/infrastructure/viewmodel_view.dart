import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'viewmodel.dart';


abstract class ViewModelWidget<T extends ViewModel>
    extends ConsumerStatefulWidget {
  ViewModelWidget({super.key});

  final T viewModel = GetIt.instance<T>();

  @override
  ConsumerState<ViewModelWidget> createState() => _ViewModelWidgetState<T>();

  Widget build(BuildContext context);
}

class _ViewModelWidgetState<T extends ViewModel>
    extends ConsumerState<ViewModelWidget> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.init();
  }

  @override
  Widget build(BuildContext context) {
    return widget.build(context);
  }

  @override
  void dispose() {
    GetIt.instance.resetLazySingleton<T>(
        disposingFunction: (instance) => instance.dispose());
    super.dispose();
  }
}

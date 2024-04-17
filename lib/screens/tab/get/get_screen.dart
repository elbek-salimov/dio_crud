import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/ebooks_bloc.dart';
import '../../../blocs/ebooks_state.dart';

class GetScreen extends StatelessWidget {
  const GetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get Screen'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: BlocConsumer<CurrenciesBloc, CurrenciesState>(
          builder: (context, state) {
            if (state is CurrenciesLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CurrenciesErrorState) {
              return Center(
                child: Text(state.errorText),
              );
            }

            if (state is CurrenciesSuccessState) {
              return ListView(
                children: List.generate(state.currencies.length, (index) {
                  return ListTile(
                    title: Text(state.currencies[index].name),
                    subtitle: Text(state.currencies[index].author),
                  );
                }),
              );
            }
            return const Center(child: Text("INITIAL"));
          },
          listener: (context, state) {}),
    );
  }
}

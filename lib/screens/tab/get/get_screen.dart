import 'package:dio_crud/blocs/ebooks_event.dart';
import 'package:dio_crud/screens/tab/put/put_screen.dart';
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
      body: BlocConsumer<EbookBloc, EbookState>(
          builder: (context, state) {
            if (state is EbookLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is EbookErrorState) {
              return Center(
                child: Text(state.errorText),
              );
            }
            if (state is EbookSuccessState) {
              return ListView(
                children: List.generate(state.ebooks.length, (index) {
                  return ListTile(
                    title: Text(state.ebooks[index].name),
                    subtitle: Text(state.ebooks[index].author),
                    leading: SizedBox(
                      height: 50,
                      width: 50,
                      child: Image.network(state.ebooks[index].image),
                    ),
                    trailing: PopupMenuButton(
                      itemBuilder: (BuildContext context) {
                        return [
                          PopupMenuItem(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return PutScreen(
                                    ebooksModel: state.ebooks[index]);
                              }));
                            },
                            child: const Text("Edit"),
                          ),
                          PopupMenuItem(
                            onTap: () {
                              context.read<EbookBloc>().add(
                                  DeleteEbookEvent(state.ebooks[index].id));
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text('Ebook deleted!'),
                              ));
                            },
                            child: const Text(
                              "Delete",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ];
                      },
                    ),
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

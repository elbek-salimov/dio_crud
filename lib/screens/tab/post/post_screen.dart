import 'package:dio_crud/blocs/ebooks_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/ebooks_event.dart';
import '../../../blocs/ebooks_state.dart';
import '../../../data/models/ebooks_model.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    authorController.dispose();
    imageController.dispose();
    rateController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Post Screen'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<EbookBloc, EbookState>(
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
            return Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: authorController,
                  decoration: const InputDecoration(
                    labelText: 'Author',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: imageController,
                  decoration: const InputDecoration(
                    labelText: 'Image',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  controller: rateController,
                  decoration: const InputDecoration(
                    labelText: 'Rate',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  controller: priceController,
                  decoration: const InputDecoration(
                    labelText: 'Price',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (nameController.text.isNotEmpty &&
                        descriptionController.text.isNotEmpty &&
                        authorController.text.isNotEmpty &&
                        rateController.text.isNotEmpty &&
                        priceController.text.isNotEmpty) {
                      context.read<EbookBloc>().add(
                        CreateEbookEvent(
                          EbooksModel(
                            id: '',
                            name: nameController.text,
                            description: descriptionController.text,
                            rate: double.parse(rateController.text),
                            author: authorController.text,
                            image: imageController.text,
                            price: double.parse(priceController.text),
                          ),
                        ),
                      );
                      nameController.clear();
                      descriptionController.clear();
                      authorController.clear();
                      imageController.clear();
                      rateController.clear();
                      priceController.clear();
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Ebook Saved!'),
                      ));
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Fill all fields !!!'),
                      ));
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

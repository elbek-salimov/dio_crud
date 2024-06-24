import 'package:dio_crud/blocs/ebooks_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/ebooks_event.dart';
import '../../../blocs/ebooks_state.dart';
import '../../../data/models/ebooks_model.dart';

class PutScreen extends StatefulWidget {
  const PutScreen({super.key, required this.ebooksModel});

  final EbooksModel ebooksModel;

  @override
  State<PutScreen> createState() => _PutScreenState();
}

class _PutScreenState extends State<PutScreen> {
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController authorController;
  late TextEditingController imageController;
  late TextEditingController rateController;
  late TextEditingController priceController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.ebooksModel.name);
    descriptionController =
        TextEditingController(text: widget.ebooksModel.description);
    authorController = TextEditingController(text: widget.ebooksModel.author);
    imageController = TextEditingController(text: widget.ebooksModel.image);
    rateController =
        TextEditingController(text: widget.ebooksModel.rate.toString());
    priceController =
        TextEditingController(text: widget.ebooksModel.price.toString());
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    authorController.dispose();
    rateController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Put Screen'),
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
                    if (nameController.text != widget.ebooksModel.name ||
                        descriptionController.text !=
                            widget.ebooksModel.description ||
                        authorController.text != widget.ebooksModel.author ||
                        double.parse(rateController.text) !=
                            widget.ebooksModel.rate ||
                        double.parse(priceController.text) !=
                            widget.ebooksModel.price) {
                      context.read<EbookBloc>().add(
                            UpdateEbookEvent(
                              widget.ebooksModel.id,
                              EbooksModel(
                                id: widget.ebooksModel.id,
                                name: nameController.text,
                                description: descriptionController.text,
                                rate: double.parse(rateController.text),
                                author: authorController.text,
                                image: widget.ebooksModel.image,
                                price: double.parse(priceController.text),
                              ),
                            ),
                          );
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Ebook Updated!'),
                      ));
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Fill in a field !!!'),
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

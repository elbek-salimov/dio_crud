import '../data/models/ebooks_model.dart';

abstract class EbookState {}

class EbookSuccessState extends EbookState {
  final List<EbooksModel> ebooks;

  EbookSuccessState({required this.ebooks});
}

class EbookInitialState extends EbookState {}

class EbookLoadingState extends EbookState {}

class EbookErrorState extends EbookState {
  final String errorText;

  EbookErrorState(this.errorText);
}

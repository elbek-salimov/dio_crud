import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/ebooks_repo.dart';
import '../data/models/ebooks_model.dart';
import 'ebooks_event.dart';
import 'ebooks_state.dart';

class EbookBloc extends Bloc<EbookEvent, EbookState> {
  EbookBloc({required this.currenciesRepo})
      : super(EbookInitialState()) {
    on<GetEbooksEvent>(_onGetEbooksEvent);
    on<CreateEbookEvent>(_onCreateEbookEvent);
    on<UpdateEbookEvent>(_onUpdateEbookEvent);
    on<DeleteEbookEvent>(_onDeleteEbookEvent);
  }

  final EbooksRepo currenciesRepo;

  Future<void> _onGetEbooksEvent(
      GetEbooksEvent event, Emitter<EbookState> emit) async {
    emit(EbookLoadingState());
    List<EbooksModel> list = await currenciesRepo.getBooks();
    if (list.isEmpty) {
      emit(EbookErrorState("Something went wrong"));
    } else {
      emit(EbookSuccessState(ebooks: list));
    }
  }

  Future<void> _onCreateEbookEvent(
      CreateEbookEvent event, Emitter<EbookState> emit) async {
    try {
      emit(EbookLoadingState());
      EbooksModel? ebook = await currenciesRepo.createBook(event.ebook);
      if (ebook != null) {
        List<EbooksModel> list = await currenciesRepo.getBooks();
        emit(EbookSuccessState(ebooks: list));
      } else {
        emit(EbookErrorState("Failed to create ebook"));
      }
    } catch (e) {
      emit(EbookErrorState(e.toString()));
    }
  }

  Future<void> _onUpdateEbookEvent(
      UpdateEbookEvent event, Emitter<EbookState> emit) async {
    try {
      emit(EbookLoadingState());
      EbooksModel? ebook = await currenciesRepo.updateBook(event.id, event.ebook);
      if (ebook != null) {
        List<EbooksModel> list = await currenciesRepo.getBooks();
        emit(EbookSuccessState(ebooks: list));
      } else {
        emit(EbookErrorState("Failed to update ebook"));
      }
    } catch (e) {
      emit(EbookErrorState(e.toString()));
    }
  }

  Future<void> _onDeleteEbookEvent(
      DeleteEbookEvent event, Emitter<EbookState> emit) async {
    try {
      emit(EbookLoadingState());
      bool isDeleted = await currenciesRepo.deleteBook(event.id);
      if (isDeleted) {
        List<EbooksModel> list = await currenciesRepo.getBooks();
        emit(EbookSuccessState(ebooks: list));
      } else {
        emit(EbookErrorState("Failed to delete ebook"));
      }
    } catch (e) {
      emit(EbookErrorState(e.toString()));
    }
  }
}

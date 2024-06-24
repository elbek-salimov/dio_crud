import '../data/models/ebooks_model.dart';

abstract class EbookEvent {}

class GetEbooksEvent extends EbookEvent {}

class CreateEbookEvent extends EbookEvent {
  final EbooksModel ebook;

  CreateEbookEvent(this.ebook);
}

class UpdateEbookEvent extends EbookEvent {
  final String id;
  final EbooksModel ebook;

  UpdateEbookEvent(this.id, this.ebook);
}

class DeleteEbookEvent extends EbookEvent {
  final String id;

  DeleteEbookEvent(this.id);
}

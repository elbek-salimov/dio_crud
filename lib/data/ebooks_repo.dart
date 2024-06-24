import 'api_provider.dart';
import 'models/ebooks_model.dart';

class EbooksRepo {
  EbooksRepo({required this.apiProvider});

  final ApiProvider apiProvider;

  Future<List<EbooksModel>> getBooks() => apiProvider.getEbooks();

  Future<EbooksModel?> createBook(EbooksModel ebook) => apiProvider.createEbook(ebook);

  Future<EbooksModel?> updateBook(String id, EbooksModel ebook) => apiProvider.updateEbook(ebook);

  Future<bool> deleteBook(String id) => apiProvider.deleteEbook(id);
}

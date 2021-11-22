import 'package:get/get.dart';
import 'package:grebo/core/service/repo/contactRepo.dart';
import 'package:grebo/ui/screens/profile/model/faqsModel.dart';

class FaqsController extends GetxController {
  int page = 1;

  FaqsController() {
    page = 1;
  }

  Future<List<ListElement>> fetchFaqs(int offset) async {
    if (offset == 0) page = 1;
    if (page == -1) return [];
    List<ListElement> getPost = [];
    var request = await ContactRepo.fetchFaqs(page);

    getPost = request!.faqsData.list;
    page = request.faqsData.hasMore ? page + 1 : -1;
    return getPost;
  }
}

import 'package:adss_machine_test/models/author_model.dart';
import 'package:adss_machine_test/models/comment_model.dart';
import 'package:adss_machine_test/services/api_services.dart';
import 'package:flutter/cupertino.dart';

import '../models/post_model.dart';

class PostProvider with ChangeNotifier {
bool _isCommentsLoading = false;
bool get isCommentsLoading => _isCommentsLoading;
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  List<PostModel> _postList = [];

  List<PostModel> get postList => _postList;

  PostModel? _individualPost;

  PostModel? get individualPost => _individualPost;
  AuthorModel? _author;

  AuthorModel? get author => _author;
  List<CommentModel> _comment = [];

  List<CommentModel> get comment => _comment;

  Future<void> getPost() async {
    _isLoading = true;
    notifyListeners();
    try {
      _postList = await ApiServices().getPostList();
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getPostById({required String id}) async {
    _isLoading = true;
    notifyListeners();
    try {
      _individualPost = await ApiServices().getIndividualPost(id: id);
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getAuthorById({required String id}) async {
    _isLoading = true;
    notifyListeners();
    try {
      _author = await ApiServices().getAuthor(id: id);
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getCommentById({required String id}) async {
    _isCommentsLoading = true;
    notifyListeners();
    try {
      _comment = await ApiServices().getPostComments(id: id);
    } catch (e) {
      print(e);
    } finally {
      _isCommentsLoading = false;
      notifyListeners();
    }
  }
}

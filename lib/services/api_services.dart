import "dart:convert";
import "dart:developer";
import "dart:io";

import "package:adss_machine_test/models/author_model.dart";
import "package:adss_machine_test/models/comment_model.dart";
import "package:adss_machine_test/models/post_model.dart";
import "package:adss_machine_test/utils/api_consts.dart";
import "package:http/http.dart" as http;

class ApiServices {
  Future<List<PostModel>> getPostList() async {
    List<PostModel> postModelList = [];
    try {
      var request = http.Request('GET', ApiConsts.post);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var data = await response.stream.bytesToString();
        var posts = data;

        postModelList = postModelFromJson(posts);
      } else {
        throw HttpException(
          '${response.statusCode}: ${response.reasonPhrase}',
        );
      }
    } catch (e) {
      log('error: $e');
      rethrow;
    }
    return postModelList;
  }

  Future<PostModel?> getIndividualPost({required String id}) async {
    PostModel? postModel;
    try {
      var request =
          http.Request('GET', Uri.parse('${ApiConsts.baseUrl}posts/$id'));

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var data = await response.stream.bytesToString();
        var posts = jsonDecode(data);

        postModel = PostModel.fromJson(posts);
      } else {
        throw HttpException(
          '${response.statusCode}: ${response.reasonPhrase}',
        );
      }
    } catch (e) {
      log('error: $e');
      rethrow;
    }
    return postModel;
  }
  Future<AuthorModel?> getAuthor({required String id}) async {
    AuthorModel? authorModel;
    try {
      var request =
      http.Request('GET', Uri.parse('${ApiConsts.baseUrl}users/$id'));

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var data = await response.stream.bytesToString();
        var author =  data ;

        authorModel = authorModelFromJson(author);
      } else {
        throw HttpException(
          '${response.statusCode}: ${response.reasonPhrase}',
        );
      }
    } catch (e) {
      log('error: $e');
      rethrow;
    }
    return authorModel;
  }


  Future<List<CommentModel>> getPostComments({required String id}) async {
    List<CommentModel> commentModel = [];

    try {
      var request =
      http.Request('GET', Uri.parse('${ApiConsts.baseUrl}comments?postd=$id'));

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var data = await response.stream.bytesToString();
        var author =  data ;

        commentModel =  commentModelFromJson(author);
      } else {
        throw HttpException(
          '${response.statusCode}: ${response.reasonPhrase}',
        );
      }
    } catch (e) {
      log('error: $e');
      rethrow;
    }
    return commentModel;
  }


}

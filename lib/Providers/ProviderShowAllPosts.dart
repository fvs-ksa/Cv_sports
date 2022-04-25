import 'package:cv_sports/Model/AllPost.dart';
import 'package:cv_sports/Model/Comments.dart';
import 'package:cv_sports/Services/AllServices/ServicesComments/serviceShowComments.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


class ProviderShowPosts with ChangeNotifier{


  List<AllPost> listAllPosts = [];
  
  void ChangeLikeSinglePost({@required  int index}){
    listAllPosts [index].isLiked = !listAllPosts [index].isLiked;
    notifyListeners();
  }

  void increasedSinglePost({@required  int index}){
    listAllPosts [index].likeCount ++;
    notifyListeners();
  }
  void descreadSinglePost({@required  int index}){
    listAllPosts [index].likeCount --;
    notifyListeners();
  }
  
  AllPost singlePost = AllPost();

  bool loading = false;

  int page = 0;
  int pageSingle = 0;

  Future<void> fetchSinglePostApi({@required int postId}) async {
    // clear old data
    pageSingle++;

    Response response = await ServiceShowCommentsAndAllPosts()
        .showSinglePost(idPost: postId, page: pageSingle);

    if (response.statusCode == 200) {
      singlePost = AllPost.fromJson(response.data);
    } else {
      singlePost = AllPost();
    }
    notifyListeners();
  }



  getSinglePostData({@required int postId}) async {
    pageSingle = 0;
    singlePost = AllPost();
    loading = true;
    await fetchSinglePostApi(postId: postId);
    loading = false;

    notifyListeners();
  }




  Future<void> fetchPostsApi() async {
    // clear old data
    page++;



    Response response =
        await ServiceShowCommentsAndAllPosts().showAllPost(page: page);

    if (response.statusCode == 200) {
      response.data.forEach((element) {
        listAllPosts.add(AllPost.fromJson(element));
      });
    } else {
      listAllPosts = [];
    }
    notifyListeners();
  }

  getPostsData() async {
    page = 0;

    listAllPosts = [];
    loading = true;
    await fetchPostsApi();
    loading = false;

    notifyListeners();
  }
}
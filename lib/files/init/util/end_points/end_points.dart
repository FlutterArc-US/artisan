class EndPoints {
  EndPoints._();

  static const String baseUrl = "http://makesell.naveedullah.me";

  static String get cities => "$baseUrl/api/cities";

  static String get categories => "$baseUrl/api/categories";

  static String get types => "$baseUrl/api/types";

  static String get subTypes => "$baseUrl/api/subtypes";

  static String get login => "$baseUrl/api/login";

  static String get register => "$baseUrl/api/register";

  static String get currentUser => "$baseUrl/api/current_user";

  static String get createPost => "$baseUrl/api/create_post";

  static String get allPosts => "$baseUrl/api/all_posts";

  static String get userPosts => "$baseUrl/api/get_user_posts";

  static String get followersPosts => "$baseUrl/api/posts_for_followers";

  static String get postDetail => "$baseUrl/api/postDetail";

  static String get follow => "$baseUrl/api/follow";

  static String get unfollow => "$baseUrl/api/unfollow";

  static String get follows => "$baseUrl/api/follows";

  static String get followedBy => "$baseUrl/api/followed_by";

  static String get userDetail => "$baseUrl/api/user_detail";
}

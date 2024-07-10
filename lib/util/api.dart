class Api {
  // static const String baseUrl = 'https://3.109.185.125:8081';
  static const String baseUrl = 'https://103.193.74.150:8081';

  // User
  static const String getAllUser = '$baseUrl/user';
  static const String getAllUserById = '$baseUrl/user/';
  static const String getUserByName = '$baseUrl/user/name/';
  static const String createUser = '$baseUrl/user';
  static const String deleteUser = '$baseUrl/user/';
  static const String updateUser = '$baseUrl/user/';
  static const String getUserByFirebaseAuthId = '$baseUrl/user/firebaseAuthId/';

  // Category
  static const String getAllCategory = '$baseUrl/category';
  static const String getAllCategoryById = '$baseUrl/category/';
  static const String getCategoryByName = '$baseUrl/category/name/';
  static const String createCategory = '$baseUrl/category';
  static const String deleteCategory = '$baseUrl/category/';
  static const String updateCategory = '$baseUrl/category/';

  // Author
  static const String getAllAuthor = '$baseUrl/author';
  static const String getAuthorById = '$baseUrl/author/';
  static const String getAuthorByName = '$baseUrl/author/name/';
  static const String createAuthor = '$baseUrl/author';
  static const String deleteAuthor = '$baseUrl/author/';
  static const String updateAuthor = '$baseUrl/author/';

  // Subscription
  static const String getAllSubscription = '$baseUrl/subscription';
  static const String getSubscriptionById = '$baseUrl/subscription/';
  static const String getSubscriptionByName = '$baseUrl/subscription/name/';
  static const String createSubscription = '$baseUrl/subscription';
  static const String deleteSubscription = '$baseUrl/subscription/';
  static const String updateSubscription = '$baseUrl/subscription/';

  // Story
  static const String getAllStory = '$baseUrl/story';
  static const String getStoryById = '$baseUrl/story/';
  static const String getStoryByName = '$baseUrl/story/name/';
  static const String getStoryByAuthor = '$baseUrl/story/author/';
  static const String getStoryByTag = '$baseUrl/story/tag/';
  static const String createStory = '$baseUrl/story';
  static const String deleteStory = '$baseUrl/story/';
  static const String updateStory = '$baseUrl/story/';

  // Story Chat
  static const String getStoryChatByStoryId = '$baseUrl/storychat/story/';
  static const String createChatStory = '$baseUrl/storychat';
  static const String updateChatStory = '$baseUrl/storychat/';
  static const String deleteChatStory = '$baseUrl/storychat/';
}

class PageConfiguration {
  PageConfiguration.splash()
      : unknown = false,
        register = false,
        loggedIn = null,
        storyId = null,
        addStory = null;

  PageConfiguration.login()
      : unknown = false,
        register = false,
        loggedIn = false,
        storyId = null,
        addStory = null;

  PageConfiguration.register()
      : unknown = false,
        register = true,
        loggedIn = false,
        storyId = null,
        addStory = null;

  PageConfiguration.home()
      : unknown = false,
        register = false,
        loggedIn = true,
        storyId = null,
        addStory = null;

  PageConfiguration.storiesDetail(String this.storyId)
      : unknown = false,
        register = false,
        loggedIn = true,
        addStory = null;

  PageConfiguration.addStory()
      : unknown = false,
        register = false,
        loggedIn = true,
        storyId = null,
        addStory = true;

  PageConfiguration.unknown()
      : unknown = true,
        register = false,
        loggedIn = null,
        storyId = null,
        addStory = null;

  final bool unknown;
  final bool register;
  final bool? loggedIn;
  final String? storyId;
  final bool? addStory;

  bool get isSplashPage =>
      unknown == false &&
      register == false &&
      loggedIn == null &&
      storyId == null &&
      addStory == null;

  bool get isLoginPage =>
      unknown == false &&
      register == false &&
      loggedIn == false &&
      storyId == null &&
      addStory == null;

  bool get isRegisterPage =>
      unknown == false &&
      register == true &&
      loggedIn == false &&
      storyId == null &&
      addStory == null;

  bool get isHomePage =>
      unknown == false &&
      register == false &&
      loggedIn == true &&
      storyId == null &&
      addStory == null;

  bool get isStoriesDetailPage =>
      unknown == false &&
      register == false &&
      loggedIn == true &&
      storyId != null &&
      addStory == null;

  bool get isAddStoryPage =>
      unknown == false &&
      register == false &&
      loggedIn == true &&
      storyId == null &&
      addStory == true;

  bool get isUnknownPage =>
      unknown == true &&
      register == false &&
      loggedIn == null &&
      storyId == null &&
      addStory == null;
}

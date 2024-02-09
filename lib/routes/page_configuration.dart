class PageConfiguration {
  PageConfiguration.splash()
      : unknown = false,
        register = false,
        loggedIn = null,
        storyId = null,
        map = null,
        addStory = null,
        location = null;

  PageConfiguration.login()
      : unknown = false,
        register = false,
        loggedIn = false,
        storyId = null,
        map = null,
        addStory = null,
        location = null;

  PageConfiguration.register()
      : unknown = false,
        register = true,
        loggedIn = false,
        storyId = null,
        map = null,
        addStory = null,
        location = null;

  PageConfiguration.home()
      : unknown = false,
        register = false,
        loggedIn = true,
        storyId = null,
        map = null,
        addStory = null,
        location = null;

  PageConfiguration.storiesDetail(String this.storyId)
      : unknown = false,
        register = false,
        loggedIn = true,
        map = null,
        addStory = null,
        location = null;

  PageConfiguration.map()
      : unknown = false,
        register = false,
        loggedIn = true,
        storyId = null,
        map = true,
        addStory = null,
        location = null;

  PageConfiguration.addStory()
      : unknown = false,
        register = false,
        loggedIn = true,
        storyId = null,
        map = null,
        addStory = true,
        location = null;

  PageConfiguration.location()
      : unknown = false,
        register = false,
        loggedIn = true,
        storyId = null,
        map = null,
        addStory = null,
        location = true;

  PageConfiguration.unknown()
      : unknown = true,
        register = false,
        loggedIn = null,
        storyId = null,
        map = null,
        addStory = null,
        location = null;

  final bool unknown;
  final bool register;
  final bool? loggedIn;
  final String? storyId;
  final bool? map;
  final bool? addStory;
  final bool? location;

  bool get isSplashPage =>
      unknown == false &&
      register == false &&
      loggedIn == null &&
      storyId == null &&
      map == null &&
      addStory == null &&
      location == null;

  bool get isLoginPage =>
      unknown == false &&
      register == false &&
      loggedIn == false &&
      storyId == null &&
      map == null &&
      addStory == null &&
      location == null;

  bool get isRegisterPage =>
      unknown == false &&
      register == true &&
      loggedIn == false &&
      storyId == null &&
      map == null &&
      addStory == null &&
      location == null;

  bool get isHomePage =>
      unknown == false &&
      register == false &&
      loggedIn == true &&
      storyId == null &&
      map == null &&
      addStory == null &&
      location == null;

  bool get isStoriesDetailPage =>
      unknown == false &&
      register == false &&
      loggedIn == true &&
      storyId != null &&
      map == null &&
      addStory == null &&
      location == null;

  bool get isMapPage =>
      unknown == false &&
      register == false &&
      loggedIn == true &&
      storyId != null &&
      map == true &&
      addStory == null &&
      location == null;

  bool get isAddStoryPage =>
      unknown == false &&
      register == false &&
      loggedIn == true &&
      storyId == null &&
      map == null &&
      addStory == true &&
      location == false;

  bool get isLocationPage =>
      unknown == false &&
      register == false &&
      loggedIn == true &&
      storyId == null &&
      map == null &&
      addStory == true &&
      location == true;

  bool get isUnknownPage =>
      unknown == true &&
      register == false &&
      loggedIn == null &&
      storyId == null &&
      map == null &&
      addStory == null &&
      location == null;
}

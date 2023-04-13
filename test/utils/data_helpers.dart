// AuthResponse
var exampleLoginResult =
    '{"userId": "userId-example","name": "user_example", "token": "token-example-1234"}';
var authSuccessJson =
    '{"error": false, "message": "success", "loginResult": $exampleLoginResult}';
var authFailedJson = '{"error": true, "message": "failed"}';

// GetAllStoriesResponse
var exampleStory1 =
    '{"id":"story-1","name":"user-story-1","description":"description-1","photoUrl":"url-here","createdAt":"11-05-2032","lat":0.2322,"lon":0.434235}';
var exampleStory2 =
    '{"id":"story-2","name":"user-story-2","description":"description-2","photoUrl":"url-here","createdAt":"12-05-2032","lat":null,"lon":null}';
var exampleStory3 =
    '{"id":"story-3","name":"user-story-3","description":"description-3","photoUrl":"url-here","createdAt":"13-05-2032"}';
var getAllStoriesSuccessJson =
    '{"error": false, "message": "success", "listStory": [$exampleStory1, $exampleStory2, $exampleStory3]}';
var getAllStoriesFailedJson = '{"error": true, "message": "failed"}';

// GetDetailStoryResponse
var getDetailStorySuccessJson =
    '{"error": false, "message": "success", "story": $exampleStory1}';
var getDetailStoryFailedJson = '{"error": true, "message": "failed"}';

// UploadNewStoryResponse
var uploadNewStorySuccessJson = '{"error": false, "message": "success"}';
var uploadNewStoryFailedJson = '{"error": true, "message": "failed"}';

// AuthInfo
var exampleUser =
    '{"id": "user-1", "name": "username-1", "token": "example-token-user-1"}';
var authInfoLoggedInJson = '{"isAlreadyLoggedIn": true, "user": $exampleUser}';
var authInfoNotLoggedInJson =
    '{"isAlreadyLoggedIn": false, "user": $exampleUser}';

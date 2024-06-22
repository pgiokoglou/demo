import "package:nock/nock.dart";

import "image_request.dart";

void stubImageRequest(ImageRequest response) => nock(response.baseUrl).get(response.resourcePath).reply(
      response.serverStatusCode,
      response.body,
    );

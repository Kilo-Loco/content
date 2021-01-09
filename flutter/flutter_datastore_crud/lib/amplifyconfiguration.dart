const amplifyconfig = ''' {
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "api": {
        "plugins": {
            "awsAPIPlugin": {
                "flutterdatastorecrudops": {
                    "endpointType": "GraphQL",
                    "endpoint": "https://qtzpw4utnzajhecb2gkktn56vi.appsync-api.us-west-2.amazonaws.com/graphql",
                    "region": "us-west-2",
                    "authorizationType": "API_KEY",
                    "apiKey": "da2-uufklpy7yrgsvlvn7i4idozp6a"
                }
            }
        }
    }
}''';
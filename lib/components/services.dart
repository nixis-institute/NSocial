import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

  final HttpLink httpLink = HttpLink(
    uri:'http://mybebo.pythonanywhere.com/graphql/'
  );
  final AuthLink authLink = AuthLink(
    getToken:()=>'Token token>',
  );
  final Link link = authLink.concat(httpLink as Link);
  ValueNotifier<GraphQLClient> client  = ValueNotifier(
    GraphQLClient(
      cache:InMemoryCache(),
      link: link,
    )
  );

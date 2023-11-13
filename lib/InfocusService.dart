
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:infocus/AccessToken.dart';
import 'package:infocus/Account.dart';

import 'SessionService.dart';

class InfocusService {
  final HttpLink httpLink = HttpLink('https://backend-hy47y5562a-an.a.run.app/graphql');

  GraphQLClient createNoAuthClient() {
    return GraphQLClient(
      cache: GraphQLCache(),
      link: httpLink,
    );
  }

  Future<AccessToken> exchangeAccessTokenForCode(final String code) async {
    final client = createNoAuthClient();
    final mutation = r'''
      mutation ExchangeAccessTokenForCode($code: String!) {
        exchangeAccessTokenForCode(input: { code: $code }) {
          accessToken
          refreshToken
          account {
            id
            email
            name
          }
        }
      }
    ''';
    final options = MutationOptions(
      document: gql(mutation),
      variables: <String, dynamic>{
        'code': code,
      },
    );
    final QueryResult result = await client.mutate(options);
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final data = result.data!['exchangeAccessTokenForCode'];

    final account = Account(
      data['account']['id'],
      data['account']['email'],
      data['account']['name'],
    );

    final accessToken = data['accessToken'];
    final refreshToken = data['refreshToken'];
    return AccessToken(accessToken, refreshToken, account);
  }
}
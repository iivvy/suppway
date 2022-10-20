import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'bloc/payment_bloc.dart';

class StripeWebViewPage extends StatelessWidget {
  const StripeWebViewPage({Key? key, required this.url}) : super(key: key);
  final String url;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
        navigationDelegate: (NavigationRequest request) {
          if (request.url.contains("authorize-return") &&
              !request.url.contains("redirect_uri")) {
            BlocProvider.of<PaymentBloc>(context)
                .add(PaymentReturn(url: request.url));
            Navigator.pop(context);
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suppwayy_mobile/manufacturing_product/bloc/manufacturing_product_bloc.dart';
import 'package:suppwayy_mobile/manufacturing_product/manufacturing_product_repository.dart';
import 'package:suppwayy_mobile/profile/bloc/bloc/profile_bloc.dart';
import 'package:suppwayy_mobile/profile/profile_repository.dart';
import 'package:suppwayy_mobile/commons/bloc/userlocation_bloc.dart';

import 'package:suppwayy_mobile/commons/main_page.dart';
import 'package:suppwayy_mobile/http_overrides.dart';
import 'package:suppwayy_mobile/location/bloc/location_bloc.dart';
import 'package:suppwayy_mobile/location/locations_repository.dart';
import 'package:suppwayy_mobile/lot/bloc/lot_bloc.dart';
import 'package:suppwayy_mobile/lot/lot_repository.dart';
import 'package:suppwayy_mobile/partner/bloc/partner_bloc.dart';
import 'package:suppwayy_mobile/partner/partner_repository.dart';
import 'package:suppwayy_mobile/product/bloc/product_bloc.dart';
import 'package:suppwayy_mobile/product/product_repository.dart';
import 'package:suppwayy_mobile/sale/bloc/sale_order_bloc.dart';
import 'package:suppwayy_mobile/sale/sale_order_repository.dart';
import 'package:suppwayy_mobile/setting/bloc/setting_bloc.dart';
import 'package:suppwayy_mobile/setting/theme.dart';
import 'package:suppwayy_mobile/trace/bloc/trace_bloc.dart';
import 'package:suppwayy_mobile/trace/trace_repository.dart';
import 'package:suppwayy_mobile/manufacturing/bloc/manufacturing_order_bloc.dart';
import 'authentication/bloc/authentication_bloc.dart';
import 'authentication/authenticate_repository.dart';
import 'deliveries/bloc/deliveries_bloc.dart';
import 'deliveries/deliveries_repository.dart';
import 'manufacturing/manufacturing_repository.dart';
import 'payment/bloc/payment_bloc.dart';
import 'payment/payment_repository.dart';
import 'setting/setting_repository.dart';

void main() async {
  var delegate = await LocalizationDelegate.create(
      fallbackLocale: 'en_US', supportedLocales: ['en_US', 'fr']);

  runApp(LocalizedApp(delegate, MyApp()));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  SaleOrderService saleOrderService = SaleOrderService();
  TraceService traceService = TraceService();
  ProductsService productsService = ProductsService();
  PartnersService partnersService = PartnersService();
  LotsService lotsService = LotsService();
  AuthenticationService authenticationService = AuthenticationService();
  PaymentService paymentService = PaymentService();
  ProfileService profileService = ProfileService();
  DeliveriesService deliveriesService = DeliveriesService();
  ManufacturingOrderService manufacturingOrderService =
      ManufacturingOrderService();
  ManufacturingProductsService manufacturingProductsService =
      ManufacturingProductsService();

  @override
  Widget build(BuildContext context) {
    HttpOverrides.global = MyHttpOverrides();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => UserlocationBloc()),
        BlocProvider(
          create: (_) =>
              AuthenticationBloc(authenticationService: authenticationService)
                ..add(GetSession()),
        ),
        BlocProvider(
          create: (_) => ProfileBloc(profileService: profileService)
            ..add(GetProfileEvent()),
        ),
        BlocProvider(
          create: (_) => ProductBloc(productsService: productsService)
            ..add(GetProductsEvent()),
        ),
        BlocProvider(
          create: (_) => SaleOrderBloc(saleOrderService: saleOrderService),
        ),
        BlocProvider(
          create: (_) =>
              TraceBloc(traceService: traceService)..add(GetTraceHistory()),
        ),
        BlocProvider(
          create: (_) => LotBloc(lotsService: lotsService),
        ),
        BlocProvider(
          create: (_) => PartnerBloc(partnersService: partnersService)
            ..add(GetPartnersEvent()),
        ),
        BlocProvider(
          create: (_) => LocationBloc(locationsService: LocationsListAPI())
            ..add(GetLocationsEvent()),
        ),
        BlocProvider(
            create: (_) => SettingBloc(settingService: SettingService())
              ..add(GetSavedSettings())),
        BlocProvider(
            create: (_) => PaymentBloc(paymentService: paymentService)),
        BlocProvider(
          create: (_) => DeliveriesBloc(deliveriesService: deliveriesService),
        ),
        BlocProvider(
          create: (_) => ManufacturingOrderBloc(
              manufacturingOrderService: manufacturingOrderService),
        ),
        BlocProvider(
          create: (_) => ManufacturingProductBloc(
              manufacturingProductsService: manufacturingProductsService),
        ),
      ],
      child: _buildWithTheme(context),
    );
  }

  Widget _buildWithTheme(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;
    return BlocBuilder<SettingBloc, SettingState>(builder: (context, state) {
      AppTheme _theme = AppTheme.light;
      String _language = 'fr';
      if (state is SettingsLoaded) {
        _theme =
            state.settings.theme == 'dark' ? AppTheme.dark : AppTheme.light;
        _language = state.settings.language;
      }

      return LocalizationProvider(
        state: LocalizationProvider.of(context).state,
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              localizationDelegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: localizationDelegate.supportedLocales,
            locale: Locale.fromSubtags(languageCode: _language),
            title: 'SuppWayy',
            theme: appThemeData[_theme],
            initialRoute: "/",
            routes: {
              "/": (context) => const MainPage(
                    defaultIndex: 0,
                  ),
            }),
      );
    });
  }
}

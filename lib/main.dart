import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nt_ten/blocs/ebooks_bloc.dart';
import 'package:flutter_nt_ten/blocs/ebooks_event.dart';
import 'package:flutter_nt_ten/data/api_provider.dart';
import 'package:flutter_nt_ten/data/currencies_repo.dart';
import 'package:flutter_nt_ten/screens/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  ApiProvider apiProvider = ApiProvider();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
            create: (_) => CurrenciesRepo(apiProvider: apiProvider)),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                CurrenciesBloc(currenciesRepo: context.read<CurrenciesRepo>())
                  ..add(GetCurrenciesEvent()),
          )
        ],
        child: const MyApp(),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: false),
      initialRoute: RouteNames.tabBox,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}

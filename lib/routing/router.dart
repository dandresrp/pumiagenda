import 'package:go_router/go_router.dart';
import 'package:pumiagenda/ui/activities/widgets/activities_screen.dart';
import 'package:pumiagenda/ui/main/widgets/main_screen.dart';
import '../ui/home/widgets/home_screen.dart';
import 'routes.dart';

GoRouter router() => GoRouter(
      initialLocation: Routes.main,
      routes: [
        GoRoute(
          path: Routes.main,
          builder: (context, state) => const MainScreen(),
        ),
        GoRoute(
          path: Routes.home,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: Routes.activities,
          builder: (context, state) => const ActivitiesScreen(),
        ),
      ],
    );

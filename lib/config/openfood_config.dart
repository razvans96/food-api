import 'package:openfoodfacts/openfoodfacts.dart';

/// Mi configuración global de OpenFoodFacts
void configureOpenFoodFacts() {
  OpenFoodAPIConfiguration.userAgent = UserAgent(
    name: 'AcademicProjectUALDev/1.0 (rs727@inlumine.ual.es)',
  );
  OpenFoodAPIConfiguration.globalUser = const User(
    userId: 'demo',
    password: 'demo',
    comment: 'Configuración global para FoodApp',
  );
  OpenFoodAPIConfiguration.globalLanguages = <OpenFoodFactsLanguage>[
    OpenFoodFactsLanguage.SPANISH,
  ];
  OpenFoodAPIConfiguration.globalCountry = OpenFoodFactsCountry.SPAIN;
}

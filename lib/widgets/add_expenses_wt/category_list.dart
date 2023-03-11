import 'package:exp_app/models/features_model.dart';

class CategoryList {
  var catList = [
    FeaturesModel(
      category: 'Gasolina',
      color: '#a1ff9c',
      icon: 'local_gas_station_outlined',
    ),
    FeaturesModel(
      category: 'Super',
      color: '#75acff',
      icon: 'shopping_cart_outlined',
    ),
    FeaturesModel(
      category: 'Comida',
      color: '#ffb361',
      icon: 'local_dining_outlined',
    ),
    FeaturesModel(
      category: 'Hogar',
      color: '#af81f7',
      icon: 'home',
    ),
    FeaturesModel(
      category: 'Transporte',
      color: '#ff7575',
      icon: 'directions_car_filled_outlined',
    ),
  ];
}

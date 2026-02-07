import 'package:projecto_registagro/Models/product_ep/product_modals_ep.dart';
import 'package:projecto_registagro/Models/profile_ep/profile_modals_ep.dart';

final products = [
  Product(
    id: "1",
    title: "Organic Banana",
    subTitle: "Frutas frescas",
    price: "1990.99 Kz",
    image: "assets/images/batata.png",
    description: "Bananas frescas",
    category: "Frutas",
    province: "Bengo",
    quantity: "20kg/cx",
    recommendedTransport: "Refrigerada",
    stockStatus: "vazio",
    supplier: ProfileModel(
      id: "1",
      username: "Fazenda Maria",
      description: "Frutas frescas",
      image: "assets/images/batata.png",
    )
  ),
  Product(
    id: "2",
    title: "Organic Apple",
    subTitle: "Frutas frescas",
    price: "2990.50 Kz",
    image: "assets/images/maca.png",
    description: "Descubra uma variedade de frutos frescos, selecionados com qualidade e sabor garantidos. Temos frutas nacionais e importadas, colhidas no ponto ideal para oferecer mais frescor, nutrição e sabor à sua mesa. Perfeitas para consumo diário, sumos naturais ou sobremesas saudáveis — tudo com preços acessíveis e entrega rápida.",
    category: "Frutas",
    province: "Malanje",
    quantity: "30kg/cx",
    recommendedTransport: "Refrigerada",
    stockStatus: "confirmado",
    supplier: ProfileModel(
      id: "2",
      username: "Fazenda Filomena",
      description: "Frutas frescas",
      image: "assets/images/batata.png",
    )
  ),
  Product(
    id: "3",
    title: "Organic Banana",
    subTitle: "Frutas frescas",
    price: "1990.99 Kz",
    image: "assets/images/batata.png",
    description: "Bananas frescas",
    category: "Frutas",
    province: "Bengo",
    quantity: "20kg/cx",
    recommendedTransport: "Refrigerada",
    stockStatus: "vazio",
    supplier: ProfileModel(
      id: "3",
      username: "Fazenda Kikovo",
      description: "Frutas frescas",
      image: "assets/images/batata.png",
    )
  ),
  Product(
    id: "4",
    title: "Organic Apple",
    subTitle: "Frutas frescas",
    price: "2990.50 Kz",
    image: "assets/images/maca.png",
    description: "Descubra uma variedade de frutos frescos, selecionados com qualidade e sabor garantidos. Temos frutas nacionais e importadas, colhidas no ponto ideal para oferecer mais frescor, nutrição e sabor à sua mesa. Perfeitas para consumo diário, sumos naturais ou sobremesas saudáveis — tudo com preços acessíveis e entrega rápida.",
    category: "Frutas",
    province: "Malanje",
    quantity: "30kg/cx",
    recommendedTransport: "Refrigerada",
    stockStatus: "confirmado",
    supplier: ProfileModel(
      id: "4",
      username: "Fazenda Tio Lucas",
      description: "Frutas frescas",
      image: "assets/images/batata.png",
    )
  ),
];

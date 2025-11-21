
class Onboardinglist {
  String title;
  String description;
  String imagePath;
  Onboardinglist(
      {required this.title, required this.description, required this.imagePath}
    );
}
final List<Map<String, String>> onboardingPages = [
    {
      "title": "Welcome to RegistAgro",
      "description":
          "Seu mercado de confiança para \nprodutos frescos e locais",
      "imagePath": "assets/images/icone.png"
    },
    {
      "title": "Conecte o campo à sua mesa",
      "description":
          "A RegistAgro aproxima produtores e consumidores de forma \nfácil e digital.",
      "imagePath": "assets/images/campoPlantacao.jpeg"
    },
    {
      "title": "Registre-se e gira a sua produção",
      "description":
          "Organize suas colheitas, controle estoques e acompanhe \nseu rendimento.",
      "imagePath": "assets/images/gado.jpeg"
      
    },
    {
      "title": "Transporte eficiente e seguro",
      "description":
          "Conectamos produtores a transportadoras \nde forma rápida e segura.",
      "imagePath": "assets/images/transportando.jpeg"
    },
    {
      "title": "Transparencia e confiança",
      "description":
          "A RegistAgro aproxima produtores e \nconsumidores de forma fácil e \ndigital.",
      "imagePath": "assets/images/campoAlface.jpeg"
    },
];
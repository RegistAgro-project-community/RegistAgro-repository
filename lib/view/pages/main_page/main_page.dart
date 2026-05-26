import 'dart:async';

import 'package:flutter/material.dart';
import 'package:projecto_registagro/Models/product_ep/product_modals_ep.dart';
import 'package:projecto_registagro/repositories/orders.dart';
import 'package:projecto_registagro/repositories/products.dart';
import 'package:projecto_registagro/repositories/profile.dart';
import 'package:projecto_registagro/view/pages/MyOrders/ObjectListOrders/object_data.dart';
import 'package:projecto_registagro/view/pages/MyOrders/my_orders.dart';
import 'package:projecto_registagro/view/pages/Store/incialStore/inicial_store.dart';
import 'package:projecto_registagro/view/pages/main_page/home_screen/home_state.dart';
import 'package:projecto_registagro/view/pages/userProfile/profile.dart';
import 'package:projecto_registagro/view/pages/userProfile/userModal/user_modal.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int selectedIndex = 0;
  List<Product> products = [];
  List<DataKeys> farms = [];
  bool isloading = true;
  String? errorMessage;
  String? name;

  Timer? _timer;
  bool isFirstLoad = true;

  UserModel userData = UserModel(
    name: 'Elias Manuell',
    email: 'eliasmanuell@gmail.com',
    phone: '+244 923 456 789',
    bio: 'Apaixonado por tecnologia e inovação.',
    province: "Luanda",
    adress: "Kalemba 2/Rua A",
  );

  List<Order> orders = [];

  List<Widget> get screens => [
    HomeState(products: products, name: name, adress: userData.adress),
    InicialStore(title: "Loja", products: products, adress: userData.adress),
    MyOrderScreen(orders: orders),
    ProfileScreen(
      name: userData.name,
      email: userData.email,
      phone: userData.phone,
      photo: userData.photoPath,
      adress: userData.adress,
    ),
  ];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadAllData();
    });

    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (!isFirstLoad) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
            _refreshAllData();
        });
      }
    });

    tabController = TabController(
      length: screens.length,
      vsync: this,
      initialIndex: selectedIndex,
    );

    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        setState(() {
          selectedIndex = tabController.index;
        });
      }
    });
  }


  Future<void> _refreshAllData() async {
    // ignore: avoid_print
    print("Renderizou");

    await Future.wait([
      _loadProducts(showLoading: false),
      _loadUserData(showLoading: false),
      _loadOrders(showLoading: false),
    ]);
  }

  Future<void> _loadAllData() async {
    setState(() {
      isFirstLoad = false;
    });
    await Future.wait([_loadProducts(), _loadUserData(), _loadOrders()]);
  }
  Future<void> _loadOrders({bool showLoading = true}) async {
     if (!mounted) return;
    setState(() {
      isloading = true;
    });

    try {
      final data = await OrdersRepositories().getOrders(
        context,
        showLoading: showLoading,
      );
      if (!mounted) return;
      setState(() {
        orders = data;
        errorMessage = null;
        isloading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        errorMessage = e.toString();
      });
    }
  }

  Future<void> _loadUserData({bool showLoading = true}) async {
    if (!mounted) return;
    setState(() {
      isloading = true;
    });

    try { 
      final data = await Profile().userData(context, showLoading: showLoading);
      if (!mounted) return;
      setState(() {
        name = data.name.split(" ")[0];
        userData = data;

        errorMessage = null;
        isloading = false;
      });
    } on Exception catch (e) {
      if (!mounted) return;
      setState(() {
        errorMessage = e.toString();
      });
    }
  }

  Future<void> _loadProducts({bool showLoading = true}) async {
    if (!mounted) return;
    setState(() {
      isloading = true;
    });

    final productsClass = ProductsRepositories();

    try {
      final fetchedProducts = await productsClass.getProducts(
        context,
        showLoading: showLoading,
      );
      if (!mounted) return;
      setState(() {
        farms = fetchedProducts;

        products = farms.expand((farm) {
          return farm.products.map((p) {
            return p.copyWith(farm: farm.farm);
          });
        }).toList();

        isloading = false;
        errorMessage = null;
      });
    } catch (e) {
      if (mounted) {
        if (!mounted) return;
        setState(() {
          errorMessage = e.toString();
          isloading = false;
        });
      }
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      tabController.animateTo(index);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: TabBarView(
          controller: tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: screens,
        ),
      ),

      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.white,
        ),
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: _onItemTapped,
          backgroundColor: const Color(0xFFF6F6F6),
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(fontFamily: 'Inter'),
          unselectedLabelStyle: const TextStyle(fontFamily: 'Inter'),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Loja'),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined),
              label: 'Pedidos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outlined),
              label: 'Perfil',
            ),
          ],
        ),
      ),
    );
  }
}

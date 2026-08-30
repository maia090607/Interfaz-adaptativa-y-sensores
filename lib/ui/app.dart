import 'package:flutter/material.dart';
import 'package:battery_plus/battery_plus.dart';
import '../theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Responsiva con Hardware',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const AdaptiveHomeScreen(),
    );
  }
}

class AdaptiveHomeScreen extends StatefulWidget {
  const AdaptiveHomeScreen({super.key});

  @override
  State<AdaptiveHomeScreen> createState() => _AdaptiveHomeScreenState();
}

class _AdaptiveHomeScreenState extends State<AdaptiveHomeScreen> {
  int _selectedIndex = 0;
  
  // Instancia del paquete battery_plus para consultar hardware
  final Battery _battery = Battery();
  int _batteryLevel = 100;
  BatteryState _batteryState = BatteryState.unknown;

  @override
  void initState() {
    super.initState();
    _initBatteryInfo();
  }

  Future<void> _initBatteryInfo() async {
    final level = await _battery.batteryLevel;
    final state = await _battery.batteryState;
    setState(() {
      _batteryLevel = level;
      _batteryState = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Validación para diseño responsivo: si el ancho es >= 600px usa NavigationRail
        bool isWideScreen = constraints.maxWidth >= 600;

        return Scaffold(
          appBar: AppBar(
            title: Text('Panel Principal - Batería: $_batteryLevel%'),
            elevation: 2,
          ),
          body: Row(
            children: [
              if (isWideScreen)
                NavigationRail(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  labelType: NavigationRailLabelType.all,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home),
                      label: Text('Inicio'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.memory_outlined),
                      selectedIcon: Icon(Icons.memory),
                      label: Text('Hardware'),
                    ),
                  ],
                ),
              Expanded(
                child: Center(
                  child: _selectedIndex == 0
                      ? const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.devices, size: 80, color: Colors.indigo),
                            SizedBox(height: 16),
                            Text(
                              'Bienvenido a la vista de Inicio Adaptativa',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.battery_charging_full, size: 80, color: Colors.green),
                            const SizedBox(height: 16),
                            Text(
                              'Nivel de Batería: $_batteryLevel%',
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Estado: ${_batteryState.name}',
                              style: const TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          ],
                        ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: isWideScreen
              ? null
              : NavigationBar(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  destinations: const [
                    NavigationDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home),
                      label: 'Inicio',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.memory_outlined),
                      selectedIcon: Icon(Icons.memory),
                      label: 'Hardware',
                    ),
                  ],
                ),
        );
      },
    );
  }
}
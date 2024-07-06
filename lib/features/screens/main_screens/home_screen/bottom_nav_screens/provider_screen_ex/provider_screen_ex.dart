import 'package:flutter/material.dart';
import 'package:practical_pachprthlo/features/providers/counter_provider.dart';
import 'package:practical_pachprthlo/utils/my_media_query.dart';
import 'package:provider/provider.dart';

class ProviderScreenEx extends StatelessWidget {
  const ProviderScreenEx({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider Example Screen'),
      ),
      body: Center(
        child: Text(
          context.watch<CounterProvider>().number.toString(),
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'increase',
            onPressed: () {
              context.read<CounterProvider>().incrementNumber();
            },
            child: const Center(child: Icon(Icons.add)),
          ),
          SizedBox(height: getScreenArea(context, 0.000015)),
          FloatingActionButton(
            heroTag: 'decrease',
            onPressed: () {
              context.read<CounterProvider>().decrementNumber();
            },
            child: const Center(child: Icon(Icons.minimize_rounded)),
          ),
        ],
      ),
    );
  }
}

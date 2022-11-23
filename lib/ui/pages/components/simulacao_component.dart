import 'package:flutter/material.dart';
import 'package:teste_flutter/ui/values/colors.dart';

class SimulacaoComponent extends StatelessWidget {
  const SimulacaoComponent({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  final String image;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Container(
            color: secondaryColor,
            child: Image.asset(
              image,
              height: 36.0,
              width: 36.0,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(
          title, //'R\$ 1.500  -  36 x R\$ 46,88',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle, //'PAN (FEDERAL) - 2.1%',
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

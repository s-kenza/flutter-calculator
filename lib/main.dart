import 'package:flutter/material.dart';

void main() => runApp(CalculatriceApp());

class CalculatriceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculatrice(),
    );
  }
}

class Calculatrice extends StatefulWidget {
  @override
  _CalculatriceState createState() => _CalculatriceState();
}

class _CalculatriceState extends State<Calculatrice> {
  String ecran = "0";
  String calculEnCours = "";
  List<String> historique = [];
  bool nouveauCalcul = false; // Indicateur de nouveau calcul

  void boutonAppuye(String texte) {
    setState(() {
      if (texte == "C") {
        ecran = "0";
        calculEnCours = "";
        nouveauCalcul = false;
      } else if (texte == "=") {
        try {
          double resultat = _calculer(calculEnCours);

          if (resultat == resultat.toInt().toDouble()) {
            ecran = resultat.toInt().toString();
          } else {
            ecran = resultat.toString();
          }

          historique.add("$calculEnCours = $ecran");
          if (historique.length > 5) {
            historique.removeAt(0);
          }

          // Réinitialiser mais garder le résultat affiché
          calculEnCours = ecran;
          nouveauCalcul = true;
        } catch (e) {
          ecran = "Erreur";
          nouveauCalcul = true;
        }
      } else {
        // Si un chiffre est appuyé après un "=", on recommence
        if (nouveauCalcul && RegExp(r'\d').hasMatch(texte)) {
          ecran = texte;
          calculEnCours = texte;
        } else {
          if (ecran == "0" && texte != "+" && texte != "-" && texte != "*" && texte != "/") {
            ecran = texte;
            calculEnCours = texte;
          } else {
            ecran += texte;
            calculEnCours += texte;
          }
        }
        nouveauCalcul = false;
      }
    });
  }

  void viderHistorique() {
    setState(() {
      historique.clear();
    });
  }

  double _calculer(String expression) {
    List<String> elements = expression.split(RegExp(r'(?<=\d)(?=[+\-*/])|(?<=[+\-*/])(?=\d)'));
    double resultat = double.parse(elements[0]);

    for (int i = 1; i < elements.length; i += 2) {
      String operateur = elements[i];
      double nombre = double.parse(elements[i + 1]);

      switch (operateur) {
        case '+': resultat += nombre; break;
        case '-': resultat -= nombre; break;
        case '*': resultat *= nombre; break;
        case '/': resultat /= nombre; break;
      }
    }

    return resultat;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calculatrice Flutter')),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(24.0),
              alignment: Alignment.bottomRight,
              child: Text(
                ecran,
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
              itemCount: 16,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                List<String> buttons = [
                  '7', '8', '9', '/',
                  '4', '5', '6', '*',
                  '1', '2', '3', '-',
                  'C', '0', '=', '+'
                ];
                return ElevatedButton(
                  onPressed: () => boutonAppuye(buttons[index]),
                  child: Text(buttons[index], style: TextStyle(fontSize: 24)),
                );
              },
            ),
          ),
          Flexible(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: historique.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(historique[index]),
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: viderHistorique,
                  child: Text("Vider l'historique"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
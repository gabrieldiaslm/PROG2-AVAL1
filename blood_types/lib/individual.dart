class Genotype {
  late final String _genotype;

  Genotype(String genotype) {
    if (validGenotype(genotype)) {
      _genotype = genotype;
    } else {
      throw ArgumentError("invalido $genotype");
    }
  }

  @override
  String toString() {
    if (_genotype.isNotEmpty) {
      return _genotype;
    } else {
      return _genotype.toString();
    }
  }

  // Método para verificar se o genótipo é válido
  bool validGenotype(String genotype) {
    final validGenotypes = ["AA", "Ai", "BB", "Bi", "AB", "ii"];
    return validGenotypes.contains(genotype);
  }

  // Método para determinar o  com base no genótipo
  String bloodType(genotype) {
    switch (_genotype) {
      case "AA":
        return "A";
      case "Ai":
        return "A";
      case "BB":
        return "B";
      case "Bi":
        return "B";
      case "AB":
        return "AB";
      case "ii":
        return "O";
      default:
        return " ";
    }
  }

  List<String> get alleles {
    var lista = _genotype.split("");
    List<String> lista2 = [];
    if (lista[0] == lista[1]) {
      lista2.add(lista[0]);
      return lista2;
    } else {
      return lista;
    }
  }

  List<String> get agglutinogens {
    List<String> agglutinogensList = [];
    if (_genotype.contains('A') && _genotype.contains("B")) {
      agglutinogensList.add('A');
      agglutinogensList.add('B');
    } else if (_genotype.contains('A')) {
      agglutinogensList.add('A');
    } else if (_genotype.contains('B')) {
      agglutinogensList.add('B');
     }  else {
      agglutinogensList.add("");
    }

    return agglutinogensList;
  }

  List<String> get agglutinins {
    List<String> agglutininsList = [];
    if (_genotype.contains('A') && _genotype.contains("B")) {
      agglutininsList.add('');
    } else if (_genotype.contains("A")) {
      agglutininsList.add('B');
    } else if (_genotype.contains("B")) {
      agglutininsList.add('A');
    } else if (_genotype.contains("i")) {
      agglutininsList.add('A');
      agglutininsList.add('B');
    }
    return agglutininsList;
  }

  List<String> offsprings(Genotype genotype) {
    List<String> offspringsList = [];
    var genotype1 = _genotype.split('');
    var genotype2 = genotype._genotype.split("");
    var resultado = [];
    for (var i in genotype1) {
      for (var i2 in genotype2) {
        if (i == 'i') {
          resultado.add(i2 + i);
        } else if (i == 'B' && i2 == 'i') {
          resultado.add(i + i2);
        } else if (i == 'B' && i2 == 'A') {
          resultado.add(i2 + i);
        } else {
          resultado.add(i + i2);
        }
      }
    }
    for (var i in resultado) {
      if (offspringsList.contains(i)) {
        continue;
      } else {
        offspringsList.add(i);
      }
    }
    return offspringsList;
  }

  bool compatible(Genotype genotype) {
    // Check if this genotype is universal donor "ii"
    if (_genotype == 'ii') {
      return true;
    }

    // Check if the other genotype is universal receiver "AB"
    if (genotype._genotype == 'AB') {
      return true;
    }

    final agglutinogens1 = agglutinogens;
    final agglutinogens2 = genotype.agglutinogens;

    for (String antigen in agglutinogens1) {
      if (!agglutinogens2.contains(antigen)) {
        return false;
      }
    }

    return true;
  }
}

class Individual {
  static int _individualCounter = 1;

  final Genotype genotype; // Armazena uma instância de Genotype
  late String name;

  Individual(String genotypeString, [String? name])
      : genotype = Genotype(genotypeString),
        name = name ?? _generateName(genotypeString);

  static String _generateName(String genotype) {
    int N = _individualCounter++;
    return "Indiv$N";
  }

  List<String> get alleles {
    return genotype.alleles;
  }

  List<String> get agglutinogens {
    return genotype.agglutinogens;
  }

  List<String> get agglutinins {
    return genotype.agglutinins;
  }

  List<String> get offsprings {
    return genotype.offsprings(genotype);
  }

  @override
  String toString() {
    return "$name(${genotype.bloodType(genotype)})";
  }
}

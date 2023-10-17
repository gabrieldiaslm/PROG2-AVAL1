class Genotype {
  late final String genotypeFirst;

  Genotype(String genotype) {
    if (validGenotypes(genotype)) {
      genotypeFirst = genotype;
    } else {
      throw ArgumentError(genotype);
    }
  }

  @override
  String toString() {
    if (genotypeFirst.isNotEmpty) {
      return genotypeFirst;
    } else {
      return genotypeFirst.toString();
    }
  }

  bool validGenotypes(String genotype) {
    final genotypesList = ["AA", "Ai", "BB", "Bi", "AB", "ii"];
    return genotypesList.contains(genotype);
  }

  String bloodType(genotype) {
    switch (genotypeFirst) {
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

  List<String> allelesToList() {
    List<String> allelesList = genotypeFirst.split('');
    List<String> allelesListFinal = [];
    for (var a in allelesList) {
      if (allelesListFinal.contains(a)) {
        continue;
      } else {
        allelesListFinal.add(a);
      }
    }
    return allelesListFinal;
  }

  List<String> get alleles {
    return allelesToList();
  }

  List<String> get agglutinogens {
    List<String> agglutinogensList = [];
    if (genotypeFirst.contains('A') && genotypeFirst.contains("B")) {
      agglutinogensList.add('A');
      agglutinogensList.add('B');
    } else if (genotypeFirst.contains('AA')) {
      agglutinogensList.add('A');
      agglutinogensList.add('A');
    } else if (genotypeFirst.contains('A')) {
      agglutinogensList.add('A');
    } else if (genotypeFirst.contains('BB')) {
      agglutinogensList.add('B');
      agglutinogensList.add('B');
    } else if (genotypeFirst.contains('B')) {
      agglutinogensList.add('B');
    } else {
      agglutinogensList.add("i");
    }

    return agglutinogensList;
  }

  List<String> get agglutinins {
    List<String> agglutininsList = [];
    if (genotypeFirst.contains('A') && genotypeFirst.contains("B")) {
      agglutininsList.add('');
    } else if (genotypeFirst.contains("A")) {
      agglutininsList.add('B');
    } else if (genotypeFirst.contains("B")) {
      agglutininsList.add('A');
    } else if (genotypeFirst.contains("i")) {
      agglutininsList.add('A');
      agglutininsList.add('B');
    }
    return agglutininsList;
  }

  //
  List<String> offsprings(Genotype genotype) {
    List<String> offspringsList = [];
    var genotype1 = genotypeFirst.split('');
    var genotype2 = genotype.genotypeFirst.split('');
    List resultado = [];

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
      var splitado = i.split('');
      if (splitado[0] == splitado[1] && offspringsList.contains(i)) {
        continue;
      } else if (splitado[0] != splitado[1] && offspringsList.contains(i)) {
        continue;
      } else {
        offspringsList.add(i);
      }
    }
    return offspringsList;
  }

  bool compatible(Genotype genotype) {
    if (genotypeFirst == 'ii') {
      return true;
    }

    if (genotype.genotypeFirst == 'AB') {
      return true;
    }

    final agglutinogensList1 = agglutinogens;
    final agglutinogensList2 = genotype.agglutinogens;

    for (String antigen in agglutinogensList1) {
      if (!agglutinogensList2.contains(antigen)) {
        return false;
      }
    }

    return true;
  }
}

class Individual {
  static int _individualCounter = 1;

  final Genotype genotype;
  late String name;

  Individual(String genotypeIndiv, [String? name])
      : genotype = Genotype(genotypeIndiv),
        name = name ?? nameCreator(genotypeIndiv);

  static String nameCreator(String genotype) {
    int N = _individualCounter++;
    return "Indiv$N";
  }

  @override
  String toString() {
    return "$name(${genotype.bloodType(genotype)})";
  }
}

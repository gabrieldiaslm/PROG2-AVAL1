class Genotype {
  late final String _genotype;

  Genotype(String genotype) {
    if (validatingGenotype(genotype)) {
      _genotype = genotype;
    } else {
      throw ArgumentError(genotype);
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

  bool validatingGenotype(String genotype) {
    final validGenotypes = ["AA", "Ai", "BB", "Bi", "AB", "ii"];
    return validGenotypes.contains(genotype);
  }

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
    List<String> agglutinogensListed = [];
    if (_genotype.contains('A') && _genotype.contains("B")) {
      agglutinogensListed.add('A');
      agglutinogensListed.add('B');
    } else if (_genotype.contains('A')) {
      agglutinogensListed.add('A');
    } else if (_genotype.contains('B')) {
      agglutinogensListed.add('B');
    }  else {
      agglutinogensListed.add("");
    }

    return agglutinogensListed;
  }

  List<String> get agglutinins {
    List<String> agglutininsListed = [];
    if (_genotype.contains('A') && _genotype.contains("B")) {
      agglutininsListed.add('');
    } else if (_genotype.contains("A")) {
      agglutininsListed.add('B');
    } else if (_genotype.contains("B")) {
      agglutininsListed.add('A');
    } else if (_genotype.contains("i")) {
      agglutininsListed.add('A');
      agglutininsListed.add('B');
    }
    return agglutininsListed;
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
    if (_genotype == 'ii') {
      return true;
    }

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

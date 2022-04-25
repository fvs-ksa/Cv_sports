class ClassForSavePlayerData {
  //======= In First Screen ==========
  static String setHeight;
  static String setWeight;
  static String setNational;
  static String setWeightUnit;

  //======= In Second Screen ==========
  static String setGamePractitioner;
  static String setGameSelect;
  static String setCvText;
  static String setDateTime1SecondScreen;
  static String setDateTime2SecondScreen;
  static String setNameClub;
  static String setNameGameWhere;

  getWeightUnit() {
    print("getWeightUnit = " + setWeightUnit);
    return setWeightUnit;
  }

  getHeight() {
    if (setHeight != null) {
      print("getHeight = " + setHeight);
    }
    return setHeight;
  }

  getWeight() {
    if (setWeight != null) {
      print("getWeight = " + setWeight);
    }

    return setWeight;
  }

  getNational() {
    if (setNational != null) {
      print("getNational = " + setNational);
    }

    return setNational;
  }


  getGamePractitioner() {
    if (setGamePractitioner != null) {
      print("getGamePractitioner = " + setGamePractitioner);
    }

    return setGamePractitioner;
  }

  getGameSelect() {
    if (setGameSelect != null) {
      print("getGameSelect = " + setGameSelect);
    }

    return setGameSelect;
  }

  getCvText() {
    if (setCvText != null) {
      print("getCvText = " + setCvText);
    }

    return setCvText;
  }

  getDateTime1() {
    if (setDateTime1SecondScreen != null) {
      print("getDateTime1 = " + setDateTime1SecondScreen);
    }

    return setDateTime1SecondScreen;
  }

  getDateTime2() {
    if (setDateTime2SecondScreen != null) {
      print("getDateTime2 = " + setDateTime2SecondScreen);
    }

    return setDateTime2SecondScreen;
  }

  getNameClub() {
    if (setNameClub != null) {
      print("getNameClub = " + setNameClub);
    }

    return setNameClub;
  }

  getNameGameWhere() {
    if (setNameGameWhere != null) {
      print("getNameGameWhere = " + setNameGameWhere);
    }

    return setNameGameWhere;
  }

  removeAllValues() {
    //======= In First Screen ==========

    setHeight = null;
    setWeight = null;
    setNational = null;


    //======= In Second Screen ==========
    setGamePractitioner = null;
    setGameSelect = null;
    setCvText = null;
    setDateTime1SecondScreen = null;
    setDateTime2SecondScreen = null;
    setNameClub = null;
    setNameGameWhere = null;

    setWeightUnit = null;
  }
}

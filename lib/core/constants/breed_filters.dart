Map<String, String> breedFilters = {
  "Abyssinian": "abys",
  "Aegean": "aege",
  "American Bobtail": "abob",
  "American Curl": "acur",
  "American Shorthair": "asho",
  "Arabian Mau": "amau",
  "Australian Mist": "amis",
  "Balinese": "bali",
  "Bengal": "beng",
  "British Shorthair": "bsho",
  "Cheetoh": "chee",
};

String getKeyFromValue(String val) =>
    breedFilters.entries.firstWhere((entry) => entry.value == val).key;

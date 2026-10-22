/// "BOLT.EU", "bolt eu" and "Bolt-EU" all become "BOLT EU".
String merchantKey(String merchant) => merchant
    .toUpperCase()
    .replaceAll(RegExp(r'[^\p{L}\p{N}]+', unicode: true), ' ')
    .trim();

class Character {
  final String name;
  final String race;
  final String mainClass;
  final String background;
  final String alignment;
  final String playerName;
  final int level;
  final int proficiencyBonus;
  final int initiative;
  final int armorClass;
  final int maxHp;
  final int currentHp;
  final String hitDice;
  final int speed;
  final String vision;
  final List<AbilityScore> abilityScores;
  final List<Skill> skills;
  final List<Weapon> weapons;
  final List<Feature> features;
  final int passivePerception;

  Character({
    required this.name,
    required this.race,
    required this.mainClass,
    required this.background,
    required this.alignment,
    required this.playerName,
    required this.level,
    required this.proficiencyBonus,
    required this.initiative,
    required this.armorClass,
    required this.maxHp,
    required this.currentHp,
    required this.hitDice,
    required this.speed,
    required this.vision,
    required this.abilityScores,
    required this.skills,
    required this.weapons,
    required this.features,
    required this.passivePerception,
  });
}

class AbilityScore {
  final String name;
  final int value;
  final int modifier;
  final bool isProficient;
  AbilityScore(
      {required this.name,
      required this.value,
      required this.modifier,
      this.isProficient = false});
}

class Skill {
  final String name;
  final String ability;
  final int bonus;
  final bool isProficient;
  Skill(
      {required this.name,
      required this.ability,
      required this.bonus,
      required this.isProficient});
}

class Weapon {
  final String name;
  final String attackBonus;
  final String damage;
  final String notes;
  Weapon(
      {required this.name,
      required this.attackBonus,
      required this.damage,
      required this.notes});
}

class Feature {
  final String name;
  final String description;
  final bool hasUses;
  Feature(
      {required this.name, required this.description, this.hasUses = false});
}

final mahrMudborn = Character(
  name: "Mahr Mudborn",
  race: "Hexblood",
  mainClass: "Sorcerer 3 / Warlock 1",
  background: "Criminal (Spy)",
  alignment: "Neutral Good",
  playerName: "Fars",
  level: 4,
  proficiencyBonus: 2,
  initiative: 3,
  armorClass: 13,
  maxHp: 32,
  currentHp: 17,
  hitDice: "1d6",
  speed: 30,
  vision: "60ft - Darkvision",
  passivePerception: 15,
  abilityScores: [
    AbilityScore(name: "STR", value: 8, modifier: -1),
    AbilityScore(name: "DEX", value: 16, modifier: 3),
    AbilityScore(name: "CON", value: 16, modifier: 3, isProficient: true),
    AbilityScore(name: "INT", value: 14, modifier: 2),
    AbilityScore(name: "WIS", value: 14, modifier: 2),
    AbilityScore(name: "CHA", value: 18, modifier: 4, isProficient: true),
  ],
  skills: [
    Skill(name: "Acrobatics", ability: "DEX", bonus: 3, isProficient: false),
    Skill(name: "Stealth", ability: "DEX", bonus: 5, isProficient: true),
    Skill(name: "Investigation", ability: "INT", bonus: 4, isProficient: true),
    Skill(name: "Perception", ability: "WIS", bonus: 4, isProficient: true),
    Skill(name: "Deception", ability: "CHA", bonus: 6, isProficient: true),
    Skill(name: "Persuasion", ability: "CHA", bonus: 6, isProficient: true),
    Skill(name: "Athletics", ability: "STR", bonus: -1, isProficient: false),
    Skill(
        name: "Sleight of Hand", ability: "DEX", bonus: 3, isProficient: false),
    Skill(name: "Arcana", ability: "INT", bonus: 2, isProficient: false),
    Skill(name: "History", ability: "INT", bonus: 2, isProficient: false),
    Skill(name: "Nature", ability: "INT", bonus: 2, isProficient: false),
    Skill(name: "Religion", ability: "INT", bonus: 2, isProficient: false),
    Skill(
        name: "Animal Handling", ability: "WIS", bonus: 2, isProficient: false),
    Skill(name: "Insight", ability: "WIS", bonus: 2, isProficient: false),
    Skill(name: "Medicine", ability: "WIS", bonus: 2, isProficient: false),
    Skill(name: "Survival", ability: "WIS", bonus: 2, isProficient: false),
    Skill(name: "Intimidation", ability: "CHA", bonus: 4, isProficient: false),
    Skill(name: "Performance", ability: "CHA", bonus: 4, isProficient: false),
  ],
  weapons: [
    Weapon(
        name: "Spear",
        attackBonus: "+2",
        damage: "1d6",
        notes: "Versatile (1d8)"),
    Weapon(
        name: "Dagger x2",
        attackBonus: "+5",
        damage: "1d4 P",
        notes: "Finesse"),
    Weapon(
        name: "Light Crossbow",
        attackBonus: "+5",
        damage: "1d8 P",
        notes: "80/320, Two-handed"),
  ],
  features: [
    Feature(name: "Pact of the Chain - Sprite (flavor)", description: ''),
    Feature(name: "Eerie Token - Hair or Fingernail", description: ''),
    Feature(
        name: "Telepathic Message", description: "Action - 10 miles, 25 words"),
    Feature(
        name: "Remote Viewing",
        description: "10 miles, 1 minute - Break on incapacitate",
        hasUses: true),
    Feature(
        name: "Innate Sorcery",
        description: "Spell Save DC+1, Adv+ Spells, 2 use - bonus action",
        hasUses: true),
    Feature(name: "Meta-Magic", description: "Subtle Spell, Empowered Spell"),
    Feature(
        name: "Restore Balance",
        description: "Reaction - 60ft, cancel Adv+/Dsv-, 4 use",
        hasUses: true),
  ],
);

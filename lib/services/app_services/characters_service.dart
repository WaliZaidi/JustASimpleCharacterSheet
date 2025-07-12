import '../../models/class_model.dart';
import '../../utils/utils.dart';

class CharacterService {
  static CharacterService instance = CharacterService._();

  CharacterService._();

  List<DndClass> characterList = [];

  Future<void> initialiseDebugCharacter() async {
    final sorcererFeatures = [
      ClassFeature(
        name: 'Spellcasting',
        source: 'PHB',
        level: 1,
        entries: Utils.instance
            .stringToEntries(['Gives the ability to cast sorcerer spells.']),
      ),
      ClassFeature(
        name: 'Sorcerous Origin',
        source: 'PHB',
        level: 1,
        entries: Utils.instance
            .stringToEntries(['Choose a source for your magical power.']),
      ),
      ClassFeature(
        name: 'Font of Magic',
        source: 'PHB',
        level: 2,
        entries: Utils.instance
            .stringToEntries(['Gain Sorcery Points to manipulate magic.']),
      ),
      ClassFeature(
        name: 'Metamagic',
        source: 'PHB',
        level: 3,
        entries: Utils.instance.stringToEntries([
          'Gain two Metamagic options. This character chose Subtle Spell and Empowered Spell, as per the character sheet.'
        ]),
      ),
    ];

    final draconicBloodline = Subclass(
      name: 'Draconic Bloodline',
      shortName: 'Draconic',
      source: 'PHB',
      className: 'Sorcerer',
      classSource: 'PHB',
      page: 102,
      subclassFeatures: [
        'Dragon Ancestor|Sorcerer|PHB|1',
        'Draconic Resilience|Sorcerer|PHB|1',
      ],
    );

    final sorcererClass = DndClass(
      name: 'Sorcerer',
      source: 'PHB',
      page: 99,
      hd: HitDice(number: 1, faces: 6),
      proficiency: ['constitution', 'charisma'],
      spellcastingAbility: 'cha',
      startingProficiencies: StartingProficiencies(
        skills: [
          Choose(from: [
            'arcana',
            'deception',
            'insight',
            'intimidation',
            'persuasion',
            'religion'
          ], count: 2)
        ],
      ),
      startingEquipment: StartingEquipment(
          additionalFromBackground: true,
          defaultValue: [],
          goldAlternative: '3d4 x 10 gp'),
      multiclassing: Multiclassing(
          requirements: {'cha': 13},
          proficienciesGained: ProficienciesGained()),
      classFeatures: [
        StringFeatureReference('Spellcasting|Sorcerer|PHB|1'),
        ObjectFeatureReference(
            classFeature: 'Sorcerous Origin|Sorcerer|PHB|1',
            gainSubclassFeature: true),
        StringFeatureReference('Font of Magic|Sorcerer|PHB|2'),
        StringFeatureReference('Metamagic|Sorcerer|PHB|3'),
      ],
      subclassTitle: 'Sorcerous Origin',
      subclasses: [draconicBloodline],
      features: sorcererFeatures,
      otherSources: [],
      cantripProgression: [
        4,
        4,
        4,
        5,
        5,
        5,
        5,
        5,
        5,
        6,
        6,
        6,
        6,
        6,
        6,
        6,
        6,
        6,
        6,
        6
      ],
      optionalfeatureProgression: [],
      classTableGroups: [],
    );

    final warlockFeatures = [
      ClassFeature(
        name: 'Otherworldly Patron',
        source: 'PHB',
        level: 1,
        entries: Utils.instance
            .stringToEntries(['Strike a bargain with an otherworldly being.']),
      ),
      ClassFeature(
        name: 'Pact Magic',
        source: 'PHB',
        level: 1,
        entries: Utils.instance
            .stringToEntries(['Cast spells using your pact slots.']),
      ),
    ];

    final theFiend = Subclass(
      name: 'The Fiend',
      shortName: 'Fiend',
      source: 'PHB',
      className: 'Warlock',
      classSource: 'PHB',
      page: 109,
      subclassFeatures: ['Dark One\'s Blessing|Warlock|PHB|1'],
    );

    final warlockClass = DndClass(
      name: 'Warlock',
      source: 'PHB',
      page: 105,
      hd: HitDice(number: 1, faces: 8),
      proficiency: ['wisdom', 'charisma'],
      spellcastingAbility: 'cha',
      startingProficiencies: StartingProficiencies(
        armor: ['light armor'],
        weapons: ['simple weapons'],
        skills: [
          Choose(from: [
            'arcana',
            'deception',
            'history',
            'intimidation',
            'investigation',
            'nature',
            'religion'
          ], count: 2)
        ],
      ),
      startingEquipment: StartingEquipment(
          additionalFromBackground: true,
          defaultValue: [],
          goldAlternative: '4d4 x 10 gp'),
      multiclassing: Multiclassing(
          requirements: {'cha': 13},
          proficienciesGained: ProficienciesGained(armor: ['light armor'])),
      classFeatures: [
        ObjectFeatureReference(
            classFeature: 'Otherworldly Patron|Warlock|PHB|1',
            gainSubclassFeature: true),
        StringFeatureReference('Pact Magic|Warlock|PHB|1'),
      ],
      subclassTitle: 'Otherworldly Patron',
      subclasses: [theFiend],
      features: warlockFeatures,
      otherSources: [],
      cantripProgression: [
        2,
        2,
        2,
        3,
        3,
        3,
        3,
        3,
        3,
        4,
        4,
        4,
        4,
        4,
        4,
        4,
        4,
        4,
        4,
        4
      ],
      optionalfeatureProgression: [],
      classTableGroups: [],
    );

    characterList.addAll([sorcererClass, warlockClass]);
  }
}

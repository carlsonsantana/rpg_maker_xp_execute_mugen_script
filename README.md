# About the script

This script enables you to integrate a fighting game within **RPG Maker XP** by launching **M.U.G.E.N.** for the battle sequence. When a battle starts in **RPG Maker XP**, a window will open with the same characters from **M.U.G.E.N.**.

## Dependencies

* **RPG Maker XP** (Note: It may not work with RPG Maker VX);
* **M.U.G.E.N. 1.0** (This scripts is not compatible with 1.1b, because that version can't save the `battle.log`, which is used to track the winner).

## How to use in your game

1. On RPG Maker XP, open the **Script Editor**;
2. For every `*.rb` file in this folder, create a new script with the same name, but without the `.rb` extension (e.g., for the `MugenFight.rb` create the script named `MugenFight`) and copy the content of file and paste on the script;
3. In the `Scene_Battle 1` script, add a new line before `start_phase1` with the following content:
```ruby
MugenFight::start_fight
```
4. In the `MugenStaticCharacterResolver` script, for each **Actor** and **Enemy**, add a new line after the `@names = {}` statement with the following content:
```ruby
@names["${name_of_the_actor_or_enemy_with_spaces}"] = "${character_mugen_folder}"
```
5. In the `MugenStaticStageResolver` script, for each **Battleback Graphic**, add a new line after the `@names = {}` statement with the following content:
```ruby
@names["${battleback_graphic}"] = "${stage_mugen_folder}"
```

## Features

* Integrate M.U.G.E.N. fights into RPG Maker XP battles;
* Change the fighting stage based on the map;
* Track the winners of fights and set the battle result accordingly;
* Sync characters' HP, MP and IA level;
* Support up to 3 allies and 4 enemies.

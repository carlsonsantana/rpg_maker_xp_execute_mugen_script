# About the script

This script enables you to integrate a fighting game within **RPG Maker XP** by launching **M.U.G.E.N.** for the battle sequence. When a battle starts in **RPG Maker XP**, a window will open with the same characters from **M.U.G.E.N.**.

## Dependencies

* **RPG Maker XP** (Note: It may not work with RPG Maker VX);
* **M.U.G.E.N. 1.0** (This scripts is not compatible with 1.1b, because that version can't save the "battle.log", which is used to track the winner).

## Install

1. On RPG Maker XP, open the **Script Editor**;
2. For every `*.rb` file in this folder, create a new script with the same name, but without the `.rb` extension (e.g., for the `MugenFight.rb` create the script named `MugenFight`) and copy the content of file and paste on the script;
3. In the `Scene_Battle 1` script, create a line before `start_phase1` with the following content:
```ruby
MugenFight::start_fight
```

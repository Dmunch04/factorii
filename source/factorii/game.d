module factorii.game;

import dagon;

import factorii.data.config;
import factorii.scenes;

/++
 +
 +/
class Factorii : Game
{
    /++
     +
     +/
    this(string[] args)
    {
        super(config.window.width, config.window.height, config.window.fullscreen, "Factorii", args);

        //currentScene = New!MainMenuScene(this);
        currentScene = New!TestScene(this);
    }

    override void onQuit()
    {
        import std.stdio : writeln;

        // TODO: do some saving or something idk
        writeln("quitting");
    }
}
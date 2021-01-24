module factorii.scenes.menu;

import dagon;

/++
 +
 +/
public class MainMenuScene : Scene
{
    private Game game;

    /++
     +
     +/
    this(Game game)
    {
        super(game);

        this.game = game;
        
        // create world:
        // game.currentScene = New!GameScene(game, generateWorld("munchii").mapLayers[0].region.name));
    }
}
module factorii.scenes.game;

import dagon;

import factorii.world;

/++
 +
 +/
public class GameScene : Scene
{
    private Game game;
    private World world;

    /++
     +
     +/
    this(Game game, World world)
    {
        super(game);

        this.game = game;
        this.world = world;
    }
}
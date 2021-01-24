module factorii.scenes.test;

import dagon;

/++
 +
 +/
public class TestScene : Scene
{
    private Game game;

    private OBJAsset suzanneModel;

    /++
     +
     +/
    this(Game game)
    {
        super(game);

        this.game = game;
    }

    override void beforeLoad()
    {
        suzanneModel = addOBJAsset("data/models/suzanne.obj");
    }

    override void afterLoad()
    {
        auto camera = addCamera();
        auto freeview = New!FreeviewComponent(eventManager, camera);
        freeview.zoom(-20);
        freeview.pitch(-30.0f);
        freeview.turn(10.0f);
        game.renderer.activeCamera = camera;

        auto sun = addLight(LightType.Sun);
        sun.shadowEnabled = true;
        sun.energy = 10.0f;
        sun.pitch(-45.0f);
        
        auto suzanneMaterial = addMaterial();
        suzanneMaterial.diffuse = Color4f(1.0, 0.2, 0.2, 1.0);

        auto suzanneEntity = addEntity();
        suzanneEntity.drawable = suzanneModel.mesh;
        suzanneEntity.material = suzanneMaterial;
        suzanneEntity.position = Vector3f(0, 1, 0);
        
        auto planeEntity = addEntity();
        planeEntity.drawable = New!ShapePlane(10, 10, 1, assetManager);
    }
}
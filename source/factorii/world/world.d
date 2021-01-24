module factorii.world.world;

import factorii.data.config;

/++
 +
 +/
public struct Layer
{
    ///
    public double[512][512] noise;

    ///
    public RegionConfig region;
}

/++
 +
 +/
public class World
{
    ///
    public Layer[] mapLayers;

    /++
     +
     +/
    public this(Layer[] mapLayers)
    {
        this.mapLayers = mapLayers;
    }
}
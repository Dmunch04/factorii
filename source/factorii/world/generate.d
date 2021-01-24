module factorii.world.generate;

import factorii.data.config;
import factorii.world.world;

/++
 +
 +/
public Layer generateLayer(string seed, RegionConfig region)
{
	import factorii.util.seed : stringHashCode;
	import open_simplex_2.open_simplex_2_f : OpenSimplex2F;
	
	auto gen = new OpenSimplex2F((seed ~ "_" ~ region.name).stringHashCode());
	double[512][512] layerMap = new double[512][512];
	foreach (y; 0..512) foreach (x; 0..512)
	{
		layerMap[y][x] = gen.noise2(x, y);
	}

	return Layer(layerMap, region);
}

/++
 +
 +/
public World generateWorld(string seed)
{
	Layer[] layers;

	foreach (region; config.world.regions)
	{
		layers ~= generateLayer(seed, region);
	}

	return new World(layers);
}
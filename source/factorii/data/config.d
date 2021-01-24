module factorii.data.config;

/++
 +
 +/
public struct WindowConfig
{
    ///
    public uint width;

    ///
    public uint height;

    ///
    public bool fullscreen;
}

/++
 +
 +/
public struct ChanceConfig
{
    ///
    public float min;

    ///
    public float max;
}

/++
 +
 +/
public struct RegionConfig
{
    ///
    public string name;

    ///
    public uint priority;

    ///
    public string tileAsset;

    ///
    public ChanceConfig chance;
}

/++
 +
 +/
public struct WorldConfig
{
    ///
    public RegionConfig[] regions;
}

/++
 +
 +/
public struct Config
{
    ///
    public WindowConfig window;

    ///
    public WorldConfig world;
}

///
@property public Config config() @safe { return _config; }
private Config _config;

static this()
{
    import std.json : JSONValue, parseJSON;
    import std.file : exists, readText;
    import std.conv : to;

    string[] configPaths = ["config", "world"];

    foreach (configPath; configPaths)
    {
        string path = "data/config/" ~ configPath ~ ".json";

        if (!exists(path))
        {
            // error
            return;
        }

        string rawConfig = readText(path);
        JSONValue jsonConfig = parseJSON(rawConfig);

        final switch (configPath)
        {
            case "config":
            {
                _config.window = WindowConfig(
                    jsonConfig["window"]["width"].integer.to!uint,
                    jsonConfig["window"]["height"].integer.to!uint,
                    jsonConfig["window"]["fullscreen"].boolean,
                );

                break;
            }

            case "world":
            {
                WorldConfig world;
                RegionConfig[] regions;

                foreach (region; jsonConfig["regions"].array)
                {
                    regions ~= RegionConfig(
                        region["name"].str,
                        region["priority"].integer.to!uint,
                        region["tile"].str,
                        ChanceConfig(
                            region["chance"]["min"].floating,
                            region["chance"]["max"].floating
                        )
                    );
                }

                world.regions = regions;
                _config.world = world;
            }
        }
    }
}
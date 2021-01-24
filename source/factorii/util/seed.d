module factorii.util.seed;

/++
 +
 +/
public long stringHashCode(string s)
{
    import std.math : pow;

    long hashCode = 0;

    foreach (i, c; s)
    {
        hashCode += c * pow(31, (s.length - i + 1));
    }

    return hashCode;
}

/++
 +
 +/
public long randomSeed()
{
    import std.math : pow;
    import std.random : Random, uniform, unpredictableSeed;

    return uniform(0, pow(2, 64));
}
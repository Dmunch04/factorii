module factorii.world.noise;

import core.stdc.math : floor;
import std.math : sin, cos, PI;
import std.random : uniform, Random;

private struct Vector2
{
	float x, y;
}

/++
 +
 +/
static float lerp(immutable float a, immutable float b, immutable float v) pure nothrow
{
	return a * (1 - v) + b * v;
}

/++
 +
 +/
static float smooth(immutable float v) pure nothrow
{
	return v * v * (3 - 2 * v);
}

/++
 +
 +/
static Vector2 randomGradient(R)(ref R r)
{
	immutable random = uniform(0.0f, cast(float) PI * 2.0f, r);
	return Vector2(cos(random), sin(random));
}

/++
 +
 +/
static float gradient(immutable Vector2 original, immutable Vector2 gradient, immutable Vector2 p) pure nothrow
{
	immutable sp = Vector2(p.x - original.x, p.y - original.y);
	return gradient.x * sp.x + gradient.y * sp.y;
}

/++
 +
 +/
public class Noise2DContext
{
	///
	Vector2[] gradients;
	///
	uint[] permutations;

	/++
	 +
	 +/
	this(uint size, uint seed)
	{
		this.gradients = new Vector2[size];
		this.permutations = new uint[size];

		auto rnd = Random(seed);
		foreach (ref grad; gradients)
		{
			grad = randomGradient(rnd); 
		}

		foreach (i; 0..size)
		{
			uint j = uniform(0, cast(uint) i + 1, rnd);
			permutations[i] = permutations[j];
			permutations[j] = cast(uint) i;
		}
	}

	/++
	 +
	 +/
	public float get(immutable float x, immutable float y) nothrow
	{
		immutable p = Vector2(x, y);

		immutable gradients = getGradients(x, y);
		immutable v0 = gradient(gradients[4], gradients[0], p);
		immutable v1 = gradient(gradients[5], gradients[1], p);
		immutable v2 = gradient(gradients[6], gradients[2], p);
		immutable v3 = gradient(gradients[7], gradients[3], p);

		immutable fx = smooth(x - gradients[4].x);
		immutable vx0 = lerp(v0, v1, fx);
		immutable vx1 = lerp(v2, v3, fx);
		immutable fy = smooth(y - gradients[4].y);
		return lerp(vx0, vx1, fy);
	}

	private Vector2 getGradient(immutable int x, immutable int y) pure nothrow
	{
		immutable i = permutations[x & 255] + permutations[y & 255];
		return gradients[i & 255];
	}

	private Vector2[8] getGradients(immutable float x, immutable float y) nothrow
	{
		immutable float x0f = floor(x);
		immutable float y0f = floor(y);
		immutable int x0 = cast(int) x;
		immutable int x1 = x0 + 1;
		immutable int y0 = cast(int) y;
		immutable int y1 = y0 + 1;

		return cast(Vector2[8]) [
			getGradient(x0, y0),
			getGradient(x1, y0),
			getGradient(x0, y1),
			getGradient(x1, y1),
			Vector2(x0f + 0.0f, y0f + 0.0f),
			Vector2(x0f + 1.0f, y0f + 0.0f),
			Vector2(x0f + 0.0f, y0f + 1.0f),
			Vector2(x0f + 1.0f, y0f + 1.0f)
		];
	}
}
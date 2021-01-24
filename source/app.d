import dagon;
import factorii : Factorii;

void main(string[] args)
{
	debug enableMemoryProfiler(true);

	Factorii app = New!Factorii(args);
	app.run();
	Delete(app);

	debug printMemoryLeaks();
}
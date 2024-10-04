import peasy.*;

PeasyCam camera;
MathGalaxy mathGalaxy;

void setup()
{
  surface.setTitle("Math Galaxy");

  camera = new PeasyCam(this, 480);
  createMathGalaxy();

  fullScreen(P3D);
  colorMode(HSB, 360, 255, 255);
}

void createMathGalaxy()
{
  var density = 42; 
  mathGalaxy = new MathGalaxy(density);
}

void draw()
{
  background(0);

  mathGalaxy.render();
}

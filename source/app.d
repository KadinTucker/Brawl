module app;

import d2d;
import screens.MenuActivity;
import screens.TestGameActivity;

void main(){
	Display display = new Display(1000, 600, SDL_WINDOW_SHOWN, 0, "Brawl");
	display.activity = new TestGameActivity(display);
	display.run();
}

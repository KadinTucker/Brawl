module screens.MenuActivity;

import d2d;

import components.PanelText;
import screens.TestGameActivity;

/**
 * An activity that acts as the main menu
 * Currently unused
 */
class MenuActivity : Activity {

    /**
     * Initializes a new menu screen
     * Creates two buttons
     */
    this(Display container){
        super(container);
        this.components ~= createTextButton(container, "res/blankButton.png", new iRectangle(400, 150, 200, 50), "Play");
        this.components ~= createTextButton(container, "res/blankButton.png", new iRectangle(400, 250, 200, 50), "View Heroes");
    }

    override void draw() {
        this.container.window.renderer.clear(Color(150, 50, 50));
    }

    override void update() {
        if((cast(Button)this.components[0]).isClicked) {
            this.container.activity = new TestGameActivity(this.container);
        }
    }

}
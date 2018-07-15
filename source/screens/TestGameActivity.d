module screens.TestGameActivity;

import d2d;

import components.PanelText;
import std.datetime;
import std.math;
import logic.entity.Character;
import logic.entity.Entity;

immutable double moveRate = 0.5; //The default acceleration rate per tick for heroes

/**
 * The main game activity
 * Currently a test
 */
class TestGameActivity : Activity {

    Entity[] allEntities; //A list of all of the entities in the game

    /**
     * Initializes the game
     * Initializes a single entity (hero) to be controlled by the player
     */
    this(Display container){
        super(container);
        this.allEntities ~= new Character(100, 100, 64, 64, new Texture(loadImage("res/Taevas.png"), this.container.renderer),
                Statistics([121, 88, 143, 88, 110, 121, 88, 121], [90, 110, 130, 100, 80, 110, 90, 100], 0.8, 30, 35, 35));
    }

    override void draw() {
        this.container.renderer.clear(Color(150, 50, 50));
        foreach(ent; allEntities) {
            ent.draw(this.container);
        }
    }

    override void update() {
        double moveAmount = moveRate;
        dVector delta = new dVector(0.0, 0.0); 
        if(this.container.keyboard.allPressables[SDLK_LSHIFT].isPressed) {
            moveAmount *= 1.5;
        }
        if(this.container.keyboard.allPressables[SDLK_w].isPressed) {
            delta.y -= 1;
            delta.x += 1;
        }if(this.container.keyboard.allPressables[SDLK_a].isPressed) {
            delta.y -= 1;
            delta.x -= 1;
        }if(this.container.keyboard.allPressables[SDLK_s].isPressed) {
            delta.y += 1;
            delta.x -= 1;
        }if(this.container.keyboard.allPressables[SDLK_d].isPressed) {
            delta.y += 1;
            delta.x += 1;
        }
        if(delta.magnitude != 0) {
            delta.magnitude = moveAmount;
        }
        this.allEntities[0].motion.x += delta.x;
        this.allEntities[0].motion.y += delta.y;
        foreach(ent; allEntities) {
            ent.move();
        }
    }

    override void handleEvent(SDL_Event event) {
        if(event.type == SDL_KEYUP) {
            if(event.key.keysym.sym == SDLK_LSHIFT && Clock.currTime() - 
                    this.container.keyboard.allPressables[SDLK_LSHIFT].lastPressed < dur!"msecs"(300)) {
                this.allEntities[0].motion.magnitude = moveRate * 30;
            }
        }
    }

}
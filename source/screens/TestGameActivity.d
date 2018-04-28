module screens.TestGameActivity;

import d2d;

import components.PanelText;
import std.datetime;
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
        double moveAmount = 0.5;
        if(this.container.keyboard.allPressables[SDLK_LSHIFT].isPressed) {
            moveAmount *= 1.5;
        }
        if(this.container.keyboard.allPressables[SDLK_w].isPressed) {
            this.allEntities[0].motion.y -= moveAmount;
            if(this.container.keyboard.allPressables[SDLK_a].isPressed) {
                this.allEntities[0].motion.x += moveAmount * 0.3;
                this.allEntities[0].motion.y += moveAmount * 0.3;
            } else if(this.container.keyboard.allPressables[SDLK_d].isPressed) {
                this.allEntities[0].motion.x -= moveAmount * 0.3;
                this.allEntities[0].motion.y += moveAmount * 0.3;
            }
        }if(this.container.keyboard.allPressables[SDLK_a].isPressed) {
            this.allEntities[0].motion.x -= moveAmount;
        }if(this.container.keyboard.allPressables[SDLK_s].isPressed) {
            this.allEntities[0].motion.y += moveAmount;
            if(this.container.keyboard.allPressables[SDLK_a].isPressed) {
                this.allEntities[0].motion.x += moveAmount * 0.3;
                this.allEntities[0].motion.y -= moveAmount * 0.3;
            } else if(this.container.keyboard.allPressables[SDLK_d].isPressed) {
                this.allEntities[0].motion.x -= moveAmount * 0.3;
                this.allEntities[0].motion.y -= moveAmount * 0.3;
            }
        }if(this.container.keyboard.allPressables[SDLK_d].isPressed) {
            this.allEntities[0].motion.x += moveAmount;
        }
        foreach(ent; allEntities) {
            ent.angle = -(cast(iVector)ent.rect.initialPoint - this.container.mouse.location).directionAngles.x - 1.57;
            ent.move();
        }
    }

    override void handleEvent(SDL_Event event) {
        if(event.type == SDL_KEYUP) {
            if(event.key.keysym.sym == SDLK_LSHIFT && Clock.currTime() - 
                    this.container.keyboard.allPressables[SDLK_LSHIFT].lastPressed < dur!"msecs"(300)) {
                this.allEntities[0].motion.magnitude = 0.5 * 30;
            }
        }
    }

}
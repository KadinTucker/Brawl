module screens.TestGameActivity;

import d2d;

import components.PanelText;
import std.algorithm;
import std.datetime;
import std.math;
import logic.entity.Character;
import logic.entity.Entity;
import logic.entity.Projectile;

immutable double moveRate = 0.1; //The default acceleration rate per tick for heroes

/**
 * The main game activity
 * Currently a test
 */
class TestGameActivity : Activity {

    Entity[] allEntities; ///A list of all of the entities in the game
    Texture drawTexture; /// The draw texture for the background of the screen

    /**
     * Initializes the game
     * Initializes a single entity (hero) to be controlled by the player
     */
    this(Display container){
        super(container);
        this.allEntities ~= new Character(100, 100, 64, 64, new Texture(loadImage("res/Taevas.png"), this.container.renderer),
                Statistics([121, 88, 143, 88, 110, 121, 88, 121], [90, 110, 130, 100, 80, 110, 90, 100], 0.8, 30, 35, 35, 48));
        Surface drawSurface = new Surface(1000, 600);
        Surface bgTileImage = loadImage("res/background.png");
        for(int x = 0; x < 1000 / 96 + 1; x++) {
            for(int y = 0; y < 600 / 48 + 1; y++) {
                drawSurface.blit(bgTileImage, null, x * 96, y * 48);
            }
        }
        this.drawTexture = new Texture(drawSurface, container.renderer);
    }

    override void draw() {
        this.container.renderer.clear(Color(150, 50, 50));
        this.container.renderer.copy(drawTexture, 0, 0);
        foreach(ent; allEntities) {
            if(!ent.isDestroyed) {
                ent.draw(this.container);
            }
        }
    }

    override void update() {
        double moveAmount = moveRate;
        dVector delta = new dVector(0.0, 0.0); 
        if(this.container.keyboard.allPressables[SDLK_LSHIFT].isPressed) {
            moveAmount *= 1.5;
        }
        if(this.container.keyboard.allPressables[SDLK_w].isPressed) {
            delta.y -= moveAmount;
            delta.x += moveAmount;
        }if(this.container.keyboard.allPressables[SDLK_a].isPressed) {
            delta.y -= moveAmount;
            delta.x -= moveAmount;
        }if(this.container.keyboard.allPressables[SDLK_s].isPressed) {
            delta.y += moveAmount;
            delta.x -= moveAmount;
        }if(this.container.keyboard.allPressables[SDLK_d].isPressed) {
            delta.y += moveAmount;
            delta.x += moveAmount;
        }
        if(delta.magnitude != 0) {
            delta.magnitude = moveAmount;
        }
        this.allEntities[0].motion.x += delta.x;
        this.allEntities[0].motion.y += delta.y;
        foreach(ent; allEntities) {
            ent.move();
            if(ent.isDestroyed) {
                allEntities.remove(allEntities.countUntil(ent));
            }
        }
    }

    override void handleEvent(SDL_Event event) {
        if(event.type == SDL_KEYUP) {
            if(event.key.keysym.sym == SDLK_LSHIFT && Clock.currTime() - 
                    this.container.keyboard.allPressables[SDLK_LSHIFT].lastPressed < dur!"msecs"(300)) {
                this.allEntities[0].motion.magnitude = moveRate * 30;
            }
        } else if(event.type == SDL_MOUSEBUTTONDOWN) {
            this.allEntities ~= new Projectile(this.allEntities[0].initialPoint.x, 
                    this.allEntities[0].initialPoint.y,
                    this.allEntities[0].extent.x, this.allEntities[0].extent.y, new Texture(loadImage("res/lightningLance.png"), this.container.renderer),
                    ProjectileStats(1000, 0, 10), 0.0);
        }
    }

}
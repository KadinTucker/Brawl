module logic.entity.Entity;

import d2d;
import std.math;

/**
 * An object which moves and has position and a rectangular area
 */
class Entity {

    dRectangle rect; ///The location and dimensions of the object
    Texture texture; ///The texture which represents the entity
    dVector motion; ///The current velocity of the entity

    alias rect this;

    /**
     * Constructs a new entity at the given location,
     *      with the given dimensions and texture
     */
    this(double x, double y, double w, double h, Texture texture) {
        this.rect = new dRectangle(x, y, w, h);
        this.texture = texture;
        this.motion = new dVector(0, 0);
    }

    /**
     * Sets the location of the entity to the given location
     */
    void setLocation(dVector location) {
        this.rect.initialPoint.x = location.x;
        this.rect.initialPoint.y = location.y;
    }

    /**
     * Moves the entity according to its motion
     */
    void move() {
        this.rect = new dRectangle(this.motion.x + this.rect.initialPoint.x, 
        this.motion.y + this.rect.initialPoint.y, this.rect.extent.x, this.rect.extent.y);
    }

    /**
     * Draws the entity to the screen
     */
    void draw(Display container) {
        container.renderer.copy(this.texture, cast(int)this.initialPoint.x, cast(int)this.initialPoint.y);
    }

}
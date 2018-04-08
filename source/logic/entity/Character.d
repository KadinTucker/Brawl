module logic.entity.Character;

import d2d;
import logic.entity.Entity;

/**
 * A human person entity
 * Is always corporeal and affected by friction
 * TODO:
 */
class Character : Entity {

    /**
     * Constructs a new character
     * See Entity constructor
     */
    this(double x, double y, double w, double h, Texture texture) {
        super(x, y, w, h, texture);
    }

}
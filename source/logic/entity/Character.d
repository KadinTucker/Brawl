module logic.entity.Character;

import d2d;
import logic.entity.Entity;

struct Statistics {

    int[8] damage; ///The damage dealt for each element
    int[8] defense; ///The defense against each element
    double attackRate; ///The rate at which attacks happen
    int strength; ///The amount of health points
    int agility; ///Amount of stamina points
    int intellect; ///Amount of mana points

}

/**
 * A human person entity
 * Is always corporeal and affected by friction
 */
class Character : Entity {

    Statistics stats; ///The statistics of this character
    int[2] health; ///The amount of health the character has[0] and can have[1]
    int[2] stamina; ///The amount of stamina the character has[0] and can have[1]
    int[2] mana; ///The amount of mana the character has[0] and can have[1]

    /**
     * Constructs a new character
     * See Entity constructor
     */
    this(double x, double y, double w, double h, Texture texture, Statistics stats) {
        super(x, y, w, h, texture);
        this.stats = stats;
        this.health = [stats.strength, stats.strength];
        this.stamina = [stats.agility, stats.agility];
        this.mana = [stats.intellect, stats.intellect];
    }

    /**
     * Moves as a normal entity, but accounts for friction (mu = 0.1)
     */
    override void move() {
        super.move();
        this.motion *= 0.9;
    }

}
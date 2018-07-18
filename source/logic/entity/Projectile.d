module logic.entity.Projectile;

import d2d;
import logic.entity.Entity;

import std.datetime.stopwatch;
import std.math;

struct ProjectileStats {

    int duration; ///How long, in milliseconds, the projectile lasts
    int hits; ///How many hits, or 'pierces' the projectile has, use 0 for infinite
    int speed; ///How fast the projectile moves

}

/**
 * A projectile in the world
 */
class Projectile : Entity {

    ProjectileStats stats; ///The stats of the projectile
    StopWatch time; ///The time of origin of the projectile

    /**
     * Constructs a new projectile
     * See Entity constructor
     */
    this(double x, double y, double w, double h, Texture texture, ProjectileStats stats, double direction) {
        super(x, y, w, h, texture);
        this.stats = stats;
        this.motion = new dVector(stats.speed * cos(direction), stats.speed * sin(direction));
        this.time = StopWatch(AutoStart.yes);
    }

    override void move() {
        super.move();
        if(time.peek.total!"msecs" > this.stats.duration) {
            this.isDestroyed = true;
        }
    }

}
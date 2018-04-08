/**
 * File not currently in use
 * Shows simple and un-optimized methods of using elemental damage and resistance
 */

/**
 * DamageType order:
 * fire, ice, energy, water, earth, air, dark, light 
 */


/**
 * Gets the amount of damage dealt to the given defense attributes
 */
int getDamage(int[8] damage, int[8] defense) {
    int total;
    foreach(i; 0..8) {
        total += damage[i] * defense[i] / 100;
    }
    return total / 8;
}

int[8] getDefaultDefense() {
    return [100, 100, 100, 100, 100, 100, 100, 100];
}

int[8] getUniformDamage(int damage) {
    return [damage, damage, damage, damage, damage, damage, damage, damage];
}

struct Statistics {

    int[8] damage;
    int[8] defense;
    double attackRate;
    double moveRate;
    int strength;
    int agility;
    int intellect;

}
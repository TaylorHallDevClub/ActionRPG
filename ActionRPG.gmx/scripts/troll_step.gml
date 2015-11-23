//Move L and R
hsp = dir * moveSpeed; // is 3 or -3
vsp += grav; // iteration of 'vsp' until enemy is grounded

//Animate
if(hsp != 0) image_xscale = -dir; // dir is returning a positive or negative value. neg enemy moves left. pos the enemy moves right.
if(place_meeting(x, y + 1, obj_collider)) // check if enemy is grounded
{
    if(hsp != 0 && !isAttacking && !isDead){sprite_index = troll; image_speed = 0.3;}
    else if(isAttacking && !isDead)
    {
        sprite_index = troll_attack; 
        image_speed = 0.3; hsp = 0;
        if(obj_ply.x < obj_troll.x) obj_ply.x -= 1; // if player on the left, push him left
        else obj_ply.x += 1; // otherwise push the player right
    }
    else if(isDead){sprite_index = troll_death; image_speed = 0.3; hsp = 0;}                                      
}

//Horizontal Collision
if(place_meeting(x + hsp, y, obj_collider))
{
    while(!place_meeting(x + sign(hsp), y, obj_collider)) // sign returns -1 or 1 respective of hsp's sign
    {
        x += sign(hsp); // move until collider is 1 pixel to L or R 
    }
    hsp = 0; // after collision, jump out of while loop and move no further, hsp = 0
    dir *= -1; // flip the respective direction of the enemy
}

//Vertical Collision
if(place_meeting(x, y + vsp, obj_collider))
{
    while(!place_meeting(x, y + sign(vsp), obj_collider)) // sign returns -1 or 1 respective of vsp's sign
    {
        y += sign(vsp); // move until collider is 1 pixel below player
    }
    vsp = 0; // after collision, jump out of while loop and stop falling, vsp = 0
}

//Collision with Player
if(place_meeting(x + hsp, y, obj_ply)) // if touching player
{
    while(!place_meeting(x + sign(hsp), y, obj_ply) && !plyOn) // sign returns -1 or 1 respective of hsp's sign
    {
        x += sign(hsp); // move until collider is 1 pixel to L or R 
    }
    hsp = 0; // after collision, jump out of while loop and move no further, hsp = 0  
    if(obj_ply.y < y + 16) // if player touching top of enemy <------------------------------------------------------------------------------TODO: y - 16 needs to change 11.22.2015
    {
        plyOn = true;
        with(obj_ply) vsp = -jumpSpeed; // player will bounce. 'jumpSpeed' is a player VAR
    }
    else if(obj_ply.isAttacking == true && !isDead){health -= 20;} //<----------------------------------------------------------------------FIX: taking 20 every step. Should take 4 hits instead of 1
    else
    {
        if(place_meeting(x + 50, y, obj_ply) || place_meeting(x - 50, y, obj_ply) && !isDead)
        {
            isAttacking = true;
        }
    }
}

//Death State
if(health <= 0)
{
    isDead = true;
    if(deathCounter > 0)
    {
        deathCounter -= 1;
    }
    else instance_destroy();
}

//Apply Behavior
x += hsp;
y += vsp;

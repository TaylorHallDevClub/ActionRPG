//Move L and R
trollHsp = trollDir * trollSpeed; // is 3 or -3
trollVsp += trollGrav; // iteration of 'trollVsp' until enemy is grounded

//Animate
if(trollHsp != 0) image_xscale = -trollDir; // trollDir is returning a positive or negative value. neg enemy moves left. pos the enemy moves right.
if(place_meeting(x, y + 1, obj_collider)) // check if enemy is grounded
{
    if(trollHsp != 0 && !isTrollAttacking && !isTrollDead){sprite_index = troll; image_speed = 0.3;}
    else if(isTrollAttacking && !isTrollDead)
    {
        sprite_index = troll_attack; 
        image_speed = 0.3; trollHsp = 0;
        if(obj_ply.x < obj_troll.x) obj_ply.x -= 1; // if player on the left, push him left
        else obj_ply.x += 1; // otherwise push the player right
    }
    else if(isTrollDead){sprite_index = troll_death; image_speed = 0.3; trollHsp = 0;}                                      
}

//Horizontal Collision
if(place_meeting(x + trollHsp, y, obj_collider))
{
    while(!place_meeting(x + sign(trollHsp), y, obj_collider)) // sign returns -1 or 1 respective of trollHsp's sign
    {
        x += sign(trollHsp); // move until collider is 1 pixel to L or R 
    }
    trollHsp = 0; // after collision, jump out of while loop and move no further
    trollDir *= -1; // flip the respective trollDirection of the enemy
}

//Vertical Collision
if(place_meeting(x, y + trollVsp, obj_collider))
{
    while(!place_meeting(x, y + sign(trollVsp), obj_collider)) // sign returns -1 or 1 respective of trollVsp's sign
    {
        y += sign(trollVsp); // move until collider is 1 pixel below player
    }
    trollVsp = 0; // after collision, jump out of while loop and stop falling
}

//Collision with Player
if(place_meeting(x + trollHsp, y, obj_ply)) // if touching player
{
    while(!place_meeting(x + sign(trollHsp), y, obj_ply) && !plyOn) // sign returns -1 or 1 respective of trollHsp's sign
    {
        x += sign(trollHsp); // move until collider is 1 pixel to L or R 
    }
    trollHsp = 0; // after collision, jump out of while loop and move no further 
    
    if(obj_ply.y < y + 16) // if player touching top of enemy <------------------------------------------------------------------------------TODO: y - 16 needs to change 11.22.2015
    {
        plyOn = true;
        with(obj_ply) plyVsp = -plyJumpSpeed; // player will bounce. 'jumpSpeed' is a player VAR
    }
    else if(obj_ply.isPlyAttacking == true && !isTrollDead && !beingHit) // player attacking
    {
        trollHealth -= 20; 
        beingHit = true;
    } 
    
    if(place_meeting(x + 50, y, obj_ply) || place_meeting(x - 50, y, obj_ply) && !isTrollDead)
    {
        isTrollAttacking = true;
        beingHit    = false; // resesting the beingHit bool so that obj_troll can take another hit. 
    }
    
}

//Death State
if(trollHealth <= 0)
{
    isTrollDead = true;
    if(trollDeathCount > 0)
    {
        trollDeathCount -= 1;
    }
    else instance_destroy();
}

//Apply Behavior
x += trollHsp;
y += trollVsp;

//Move L and R
owlHsp = owlDir * owlSpeed; // is 3 or -3
//owlVsp += owlGrav; // iteration of 'owlVsp' until enemy is grounded. not used unless grounded spell cast!!!

//Animate
if(owlHsp != 0) image_xscale = -owlDir; // owlDir is returning a positive or negative value. neg enemy moves left. pos the enemy moves right.

if(owlHsp != 0 && !isOwlAttacking && !isOwlHitting && !isOwlDead){sprite_index = owl; image_speed = 0.3;}
else if(isOwlAttacking && !isOwlHitting && !isOwlDead)
{
    sprite_index = owl_attack_swoop; 
    image_speed = 0.3;
}
else if(isOwlHitting && !isOwlAttacking && !isOwlDead)
{
    sprite_index = owl_attack_hit;
    image_speed = 0.0; owlHsp = 0; owlVsp = 0;
}
else if(isOwlDead){sprite_index = owl_death; image_speed = 0.1; owlHsp = 0;}                                      


//Horizontal Collision
if(place_meeting(x + owlHsp, y, obj_collider))
{
    while(!place_meeting(x + sign(owlHsp), y, obj_collider)) // sign returns -1 or 1 respective of owlHsp's sign
    {
        x += sign(owlHsp); // move until collider is 1 pixel to L or R 
    }
    owlHsp = 0; // after collision, jump out of while loop and move no further
    owlDir *= -1; // flip the respective owlDirection of the enemy
}

//Vertical Collision
if(place_meeting(x, y + owlVsp, obj_collider))
{
    while(!place_meeting(x, y + sign(owlVsp), obj_collider)) // sign returns -1 or 1 respective of owlVsp's sign
    {
        y += sign(owlVsp); // move until collider is 1 pixel below player
    }
    owlVsp = 0; // after collision, jump out of while loop and stop falling
}
/*
//Collision with Player
if(distance_to_object(obj_ply) < 300) // if owl comes close enough with player, attack <------use distance_to_object
{
    if(distance_to_object(obj_ply) < 30)
    {
        isOwlHitting = true;
        isOwlAttacking = false;
    }
    else
    {    
        move_towards_point(obj_ply.x, obj_ply.y, 6);
        owlDir = sign(obj_ply.x - x);
        isOwlAttacking = true;
    }
}
*/
//Death State
if(owlHealth <= 0)
{
    isOwlDead = true;
    if(owlDeathCount > 0)
    {
        owlDeathCount -= 1;
    }
    else instance_destroy();
}

//Apply Behavior
x += owlHsp;
y += owlVsp;

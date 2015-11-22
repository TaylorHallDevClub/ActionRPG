
//Move L and R
hsp = dir * moveSpeed; //is 3 or -3
vsp += grav; //iteration of 'vsp' until enemy is grounded

//Animate
if(hsp != 0) image_xscale = -dir; //dir is returning a positive or negative value. neg enemy moves left. positive the enemy moves right.
if(place_meeting(x, y + 1, obj_collider)) //check if enemy is grounded
{
    if(hsp != 0){sprite_index = enemy; image_speed = 0.3;} //TODO: chagne '0.3' to VAR
                                                           //good for now. need enemy attack. when attack set 'hsp' to 0
    //else {sprite_index = enemy_attack; image_speed = 0.0;} //TODO: create ATTACK                                            
}
/*else //if not on the ground
{
    if(vsp < 0)sprite_index = ply_jump; //if player is belowe max arch i.e. on the way up
    else sprite_index = ply_fall; //other wise, he's on his way down
}*/// TODO: use only if we create a enemy jump animation

//Horizontal Collision
if(place_meeting(x + hsp, y, obj_collider))
{
    while(!place_meeting(x + sign(hsp), y, obj_collider)) //sign returns -1 or 1 respective of hsp's sign
    {
        x += sign(hsp); //move until collider is 1 pixel to L or R 
    }
    hsp = 0; //after collision, jump out of while loop and move no further, hsp = 0
    dir *= -1; //flip the respective direction of the enemy
}

//Vertical Collision
if(place_meeting(x, y + vsp, obj_collider))
{
    while(!place_meeting(x, y + sign(vsp), obj_collider)) //sign returns -1 or 1 respective of vsp's sign
    {
        y += sign(vsp); //move until collider is 1 pixel below player
    }
    vsp = 0; //after collision, jump out of while loop and stop falling, vsp = 0
}

//Attack or Collisino Check with Player Object
if(place_meeting(x, y, obj_ply)) //if touching player
{
    if(obj_ply.y < y - 16) //if player touching top of enemy
    {
        with(obj_ply) vsp = -jumpSpeed; //player will bounce. 'jumpSpeed' is a player VAR
        instance_destroy(); //TODO: death animation than destroy
    }
    else if(obj_ply.attack == true) instance_destroy(); //usinf '.' seperator to access the 'attack' VAR in obj_ply
    else
    {
        game_restart(); //TODO: replace with player health reduction
    }
}

//Apply Behavior
x += hsp;
y += vsp;

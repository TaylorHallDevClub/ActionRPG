
//Key Map
key_right = keyboard_check(vk_right); // move right , = 1 or 0
key_left  = -keyboard_check(vk_left);  // move left , = -1 or 0
key_up    = keyboard_check_pressed(vk_up); // jump, pressed doesn't allow for secondary input
key_down  = keyboard_check(vk_down);  // crouch
key_space = keyboard_check_pressed(vk_space); // attack
key_q     = keyboard_check(ord("Q")); // weapon choice left
key_e     = keyboard_check(ord("E")); // weapon choice right
key_w     = keyboard_check(ord("W")); // spell cast earth
key_a     = keyboard_check(ord("A")); // spell cast wind
key_s     = keyboard_check(ord("S")); // spell cast fire
key_d     = keyboard_check(ord("D")); // spell cast ice

//Move L or R
move = key_left + key_right; // = range(-1 : 1)
hsp  = move * moveSpeed; //consider math that is applied to 'move'
if(key_space) attack = true;

//Animate
if(move != 0) image_xscale = move; //move R = 1 while move L = -1
if(place_meeting(x, y + 1, obj_collider)) //check if player is grounded
{
    if(move != 0 && !attack){sprite_index = ply_run; image_speed = 0.3;} //run
    else if(attack){sprite_index = ply_attack; image_speed = 0.3;} //attack. end in animation_end
    else {sprite_index = ply_idle; image_speed = 0.0;} //otherwise idle                                         
}
else //if not on the ground
{
    if(vsp < 0)sprite_index = ply_jump; //if player is belowe max arch i.e. on the way up
    else sprite_index = ply_fall; //other wise, he's on the way down
}

//Gravity
if(vsp < 10) vsp += grav; //sets the max for vertical speed
if(place_meeting(x, y + 1, obj_collider)) //if surface is 1 pixel below player
{
    vsp = key_up * -jumpSpeed; // = range(-7 : 0) 0 = grounded
}

//Horizontal Collision
if(place_meeting(x + hsp, y, obj_collider))
{
    while(!place_meeting(x + sign(hsp), y, obj_collider)) //sign returns -1 or 1 respective of hsp's sign
    {
        x += sign(hsp); //move until collider is 1 pixel to L or R 
    }
    hsp = 0; //after collision, jump out of while loop and move no further, hsp = 0
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

//Apply Behavior
 x += hsp;
 y += vsp;

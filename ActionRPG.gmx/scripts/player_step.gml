
//Key Map
key_right = keyboard_check(vk_right); // move right , = 1 or 0
key_left  = -keyboard_check(vk_left);  // move left , = -1 or 0
key_up    = keyboard_check_pressed(vk_up); // jump, pressed doesn't allow for secondary input
key_down  = keyboard_check(vk_down);  // crouch, jump down through platforms
key_space = keyboard_check_pressed(vk_space); // attack
key_q     = keyboard_check(ord("Q")); // weapon choice left
key_e     = keyboard_check(ord("E")); // weapon choice right
key_w     = keyboard_check(ord("W")); // spell cast earth
key_a     = keyboard_check(ord("A")); // spell cast wind
key_s     = keyboard_check(ord("S")); // spell cast fire
key_d     = keyboard_check(ord("D")); // spell cast ice
key_r     = keyboard_check(ord("R")); //Restart Level

//Restart Level
if(key_r) room_restart(); 

//Move L or R
move = key_left + key_right; // = range(-1 : 1)
plyHsp  = move * plyMoveSpeed; // consider math that is applied to 'move'
if(key_space) isPlyAttacking = true;

//Animate
if(move != 0) image_xscale = move; // move R = 1 while move L = -1
if(place_meeting(x, y + 1, obj_collider)) // check if player is grounded
{
    if(move != 0 && !isPlyAttacking){sprite_index = ply_run; image_speed = 0.3;} // run
    else if(isPlyAttacking){sprite_index = ply_attack; image_speed = 0.3;} // attack. end in animation_end
    else {sprite_index = ply_idle; image_speed = 0.0;} // otherwise idle                                         
}
else // if not on the ground
{
    if(plyVsp < 0)sprite_index = ply_jump; // if player is belowe max arch i.e. on the way up
    else sprite_index = ply_fall; // other wise, he's on the way down
}

//Gravity
if(plyVsp < 10) plyVsp += plyGrav; // sets the max for vertical speed
if(place_meeting(x, y + 1, obj_collider)) // if surface is 1 pixel below player
{
    plyVsp = key_up * -plyJumpSpeed; // = either(-7 || 0) where 0 is grounded
}

//Horizontal Collision
if(place_meeting(x + plyHsp, y, obj_collider))
{
    while(!place_meeting(x + sign(plyHsp), y, obj_collider)) // sign returns -1 or 1 respective of plyHsp's sign
    {
        x += sign(plyHsp); // move until collider is 1 pixel to L or R 
    }
    plyHsp = 0; // after collision, jump out of while loop and move no further, plyHsp = 0
}

//Vertical Collision
if(place_meeting(x, y + plyVsp, obj_collider))
{
    while(!place_meeting(x, y + sign(plyVsp), obj_collider)) // sign returns -1 or 1 respective of plyVsp's sign
    {
        y += sign(plyVsp); // move until collider is 1 pixel below player
    }
    plyVsp = 0; // after collision, jump out of while loop and stop falling, plyVsp = 0
}

//Collision with Enemies
if(place_meeting(x + plyHsp, y, obj_troll))
{
    while(!place_meeting(x + sign(plyHsp), y, obj_troll)) // sign returns -1 or 1 respective of plyHsp's sign
    {
        x += sign(plyHsp); // move until collider is 1 pixel to L or R 
    }
    plyHsp = 0; // after collision, jump out of while loop and move no further, plyHsp = 0  
}

//Apply Behavior
 x += plyHsp;
 y += plyVsp;

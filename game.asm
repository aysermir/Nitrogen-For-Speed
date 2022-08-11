.data
    start_menu: .space 20000
displayAddress: .word 0x10008000 
start_index: .word 0 
road_colour: .word 0x696968 
inner_road_colour: .word 0x33312b
bottom_right_index: .word 16384

.text
setup_draw: 
    li $t5, 0
    li $t9, 0xb3b3b3
    la $t0, start_menu
    la $s0, start_menu
    li $s1,0
	li $s3, 0	
	li $s2, 0
    la $s4, start_menu
    addi $s4, $s4, 8048
    li $s7, 50 #s7 stores the speed of the car
    li $s5, 0 #stores progress of the car
    li $s6, 0 #stores health of the car 
    li $t6,  16380
    j draw_road  
	
draw_road:
	sw $t9, 0($t0)
	beq $t5, $t6, setup_draw_center_line
	addi $t0, $t0, 4
	addi $t5, $t5, 4
	j draw_road
	
setup_draw_center_line:
	la $t0, start_menu
	addi $t0, $t0, 128
	li $t1, 0xffffff
	sw $t1, 0($t0)
	li $t5, 0
	li $t6, 4
	j draw_center_line
	
draw_center_line:
	beq $t5, $t6, update_center_line_pixel
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t5, $t5, 4
	addi $t2, $t2, 1
	j draw_center_line
	
update_center_line_pixel: 
	addi $t7, $s0, 16384
	bgt $t0, $t7, setup_draw_left_line
	addi $t0, $t0, 252
	li $t5, 0
	j draw_center_line
	
setup_draw_left_line:
	addi $t0, $s0, 64
	li $t1, 0xffffff
	sw $t1, 0($t0)
	li $t5, 0
	li $t6, 8
	li $t8, 12
	li $t2, 0
	j draw_left_line
	
draw_left_line:
	beq $t5, $t6, update_left_line_pixel
	beq, $t2, $t8, update_left_line
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t5, $t5, 4
	addi $t2, $t2, 1
	j draw_left_line
	
update_left_line_pixel: 
	addi $t7, $s0, 16384
	bgt $t0, $t7, setup_draw_left_black_line
	addi $t0, $t0, 248
	li $t5, 0
	j draw_left_line

update_left_line:
	li $t2, 0
	addi $t0, $t0, 1536
	j draw_left_line
	
	
	
##################################
setup_draw_left_black_line:
	addi $t0, $s0, 1600
	li $t1, 0xb3b3b3
	sw $t1, 0($t0)
	li $t5, 0
	li $t6, 8
	li $t8, 12
	li $t2, 0
	j draw_left_black_line
	
draw_left_black_line:
	beq $t5, $t6, update_left_black_line_pixel
	beq, $t2, $t8, update_left_black_line
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t5, $t5, 4
	addi $t2, $t2, 1
	j draw_left_black_line
	
update_left_black_line_pixel: 
	addi $t7, $s0, 16380
	bgt $t0, $t7, setup_draw_right_line
	addi $t0, $t0, 248
	li $t5, 0
	j draw_left_black_line

update_left_black_line:
	li $t2, 0
	addi $t0, $t0, 1536
	j draw_left_black_line
################################	
setup_draw_right_line:
	addi $t0, $s0, 188
	li $t1, 0xffffff
	sw $t1, 0($t0)
	li $t5, 0
	li $t6, 8
	li $t8, 12
	li $t2, 0
	j draw_right_line
	
draw_right_line:
	beq $t5, $t6, update_right_line_pixel
	beq, $t2, $t8, update_right_line
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t5, $t5, 4
	addi $t2, $t2, 1
	j draw_right_line
	
update_right_line_pixel: 
	addi $t7, $s0, 16384
	bgt $t0, $t7, setup_draw_right_black_line
	addi $t0, $t0, 248
	li $t5, 0
	j draw_right_line

update_right_line:
	li $t2, 0
	addi $t0, $t0, 1536
	j draw_right_line
	
	
	
##################################
setup_draw_right_black_line:
	addi $t0, $s0, 1724
	li $t1, 0xb3b3b3
	sw $t1, 0($t0)
	li $t5, 0
	li $t6, 8
	li $t8, 12
	li $t2, 0
	j draw_right_black_line
	
draw_right_black_line:
	beq $t5, $t6, update_right_black_line_pixel
	beq, $t2, $t8, update_right_black_line
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t5, $t5, 4
	addi $t2, $t2, 1
	j draw_right_black_line
	
update_right_black_line_pixel: 
	addi $t7, $s0, 16380
	bgt $t0, $t7, setup_draw_h
	addi $t0, $t0, 248
	li $t5, 0
	j draw_right_black_line

update_right_black_line:
	li $t2, 0
	addi $t0, $t0, 1536
	j draw_right_black_line

	
draw_screen:
	li $t0, 0
	li $t1, 16384
	add $t3, $gp, $zero
	la $t4, start_menu
	li $t9, 0xff0000
draw:
	beq $t0, $t1, setup_redraw
	lw $t5, 0($t4)
	sw $t5, 0($t3)
	addi $t4, $t4, 4
	addi $t3, $t3, 4
	addi $t0, $t0, 4
	j draw
	
######################################################
#######################################################
setup_redraw:
	li $t5, 16100
	bgt $s3, $t5, reset_s3
	addi $s3, $s3, 256
	addi $s2, $s2, 256
	j redraww

	
reset_s3:
li $v0, 42
li $a0, 0
li $a1, 11
syscall
add $s1, $zero, $a0
li $s3, 0


redraww:	
	addi $s5, $s5, 1
	li $t5, 0
    li $t1, 0xb3b3b3
    addi $s0, $s0, 768
    addi $t0, $s0, 768
    lw $t6, bottom_right_index
    la $t3, start_menu
    addi $t4, $t3, 2304 
    beq $t4, $s0, rupdate_s
    
    add $t0, $s0, $zero
    lw $t6, bottom_right_index  
    j rdraw_road 
    
rupdate_s:
	subi $s0, $s0, 3840
	add $t0, $s0, $zero
	lw $t6, bottom_right_index 
	
rdraw_road:
	sw $t1, 0($t0)
	beq $t5, $t6, rsetup_draw_center_line
	addi $t0, $t0, 4
	addi $t5, $t5, 4
	j rdraw_road
		
rsetup_draw_center_line:
	la $t0, start_menu
	addi $t0, $t0, 2176
	li $t1, 0xffffff
	sw $t1, 0($t0)
	li $t5, 0
	li $t6, 4
	j rdraw_center_line
	
rdraw_center_line:
	beq $t5, $t6, rupdate_center_line_pixel
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t5, $t5, 4
	addi $t2, $t2, 1
	j rdraw_center_line
	
rupdate_center_line_pixel: 
	addi $t7, $s0, 16384
	bgt $t0, $t7, rsetup_draw_left_line
	addi $t0, $t0, 252
	li $t5, 0
	j rdraw_center_line
	
rsetup_draw_left_line:
	addi $t0, $s0, 64
	li $t1, 0xffffff
	sw $t1, 0($t0)
	li $t5, 0
	li $t6, 8
	li $t8, 12
	li $t2, 0
	j rdraw_left_line
	
rdraw_left_line:
	beq $t5, $t6, rupdate_left_line_pixel
	beq, $t2, $t8, rupdate_left_line
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t5, $t5, 4
	addi $t2, $t2, 1
	j rdraw_left_line
	
rupdate_left_line_pixel: 
	addi $t7, $s0, 16384
	bgt $t0, $t7, rsetup_draw_left_black_line
	addi $t0, $t0, 248
	li $t5, 0
	j rdraw_left_line

rupdate_left_line:
	li $t2, 0
	addi $t0, $t0, 1536
	j rdraw_left_line
	
	
	
##################################
rsetup_draw_left_black_line:
	addi $t0, $s0, 1600
	li $t1, 0xb3b3b3   
	sw $t1, 0($t0)
	li $t5, 0
	li $t6, 8
	li $t8, 12
	li $t2, 0
	j rdraw_left_black_line
	
rdraw_left_black_line:
	beq $t5, $t6, rupdate_left_black_line_pixel
	beq, $t2, $t8, rupdate_left_black_line
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t5, $t5, 4
	addi $t2, $t2, 1
	j rdraw_left_black_line
	
rupdate_left_black_line_pixel: 
	addi $t7, $s0, 16380
	bgt $t0, $t7, rsetup_draw_right_line
	addi $t0, $t0, 248
	li $t5, 0
	j rdraw_left_black_line

rupdate_left_black_line:
	li $t2, 0
	addi $t0, $t0, 1536
	j rdraw_left_black_line
################################	
rsetup_draw_right_line:
	addi $t0, $s0, 188
	li $t1, 0xffffff
	sw $t1, 0($t0)
	li $t5, 0
	li $t6, 8
	li $t8, 12
	li $t2, 0
	j rdraw_right_line
	
rdraw_right_line:
	beq $t5, $t6, rupdate_right_line_pixel
	beq, $t2, $t8, rupdate_right_line
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t5, $t5, 4
	addi $t2, $t2, 1
	j rdraw_right_line
	
rupdate_right_line_pixel: 
	addi $t7, $s0, 16384
	bgt $t0, $t7, rsetup_draw_right_black_line
	addi $t0, $t0, 248
	li $t5, 0
	j rdraw_right_line

rupdate_right_line:
	li $t2, 0
	addi $t0, $t0, 1536
	j rdraw_right_line
	
	
	
##################################
rsetup_draw_right_black_line:
	addi $t0, $s0, 1724
	li $t1, 0xb3b3b3
	sw $t1, 0($t0)
	li $t5, 0
	li $t6, 8
	li $t8, 12
	li $t2, 0
	j rdraw_right_black_line
	
rdraw_right_black_line:
	beq $t5, $t6, rupdate_right_black_line_pixel
	beq, $t2, $t8,rupdate_right_black_line
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t5, $t5, 4
	addi $t2, $t2, 1
	j rdraw_right_black_line
	
rupdate_right_black_line_pixel: 
	addi $t7, $s0, 16380
	bgt $t0, $t7, check_move
	addi $t0, $t0, 248
	li $t5, 0
	j rdraw_right_black_line

rupdate_right_black_line:
	li $t2, 0
	addi $t0, $t0, 1536
	j rdraw_right_black_line
	

	
	
	
	
check_move:
	li $t9, 0xffff0000
	lw $t8, 0($t9)
	beq $t8, 1, keypress_happened
	j check_collision
	
keypress_happened:
	lw $t2, 4($t9) # this assumes $t9 is set to 0xfff0000
	beq $t2, 97, respond_to_a
	beq $t2, 100, respond_to_d
	beq $t2, 115, respond_to_s
	beq $t2, 119, respond_to_w	
	
	j check_collision

respond_to_s:
	addi $t0, $s7, 25
	beq $t0, 75, draw_player
	addi $s7, $s7, 25
	j check_collision
	
respond_to_w:
	subi $t0, $s7, 25
	beq $t0, -25, draw_player
	subi $s7, $s7, 25
	j check_collision
	

	
respond_to_a:
	la $t4, start_menu
	addi $t4, $t4, 7936
	beq $s4, $t4, reduce_health
	addi $s4, $s4, -4
	j check_collision
	
respond_to_d:
	la $t4, start_menu
	addi $t4, $t4, 8168
	beq $s4, $t4, reduce_health
	addi $s4, $s4, 4
	j check_collision

reduce_health:
la $s4, start_menu
    addi $s4, $s4, 8048
	addi $s6, $s6, 8
	j draw_player
	
check_collision:
	li $t2, 0xffa500
	lw $t0, -4($s4)
	li $v0, 1
    	move $a0, $t0
    	syscall
	beq $t0, $t2, reduce_health
	lw $t0, 252($s4)
	beq $t0, $t2, reduce_health
	lw $t0, 508($s4)
	beq $t0, $t2, reduce_health
	lw $t0, 764($s4)
	beq $t0, $t2, reduce_health
	lw $t0, 1020($s4)
	beq $t0, $t2, reduce_health
	lw $t0, 1276($s4)
	beq $t0, $t2, reduce_health
	lw $t0, 1532($s4)
	beq $t0, $t2, reduce_health
	lw $t0, 1788($s4)
	beq $t0, $t2, reduce_health
	lw $t0, 2044($s4)
	beq $t0, $t2, reduce_health
	lw $t0, 2300($s4)
	beq $t0, $t2, reduce_health
	lw $t0, 2556($s4)
	beq $t0, $t2, reduce_health
	lw $t0, 2560($s4)
	beq $t0, $t2, reduce_health
	lw $t0, 2564($s4)
	beq $t0, $t2, reduce_health
	lw $t0, 2568($s4)
	beq $t0, $t2, reduce_health
	lw $t0, 2572($s4)
	beq $t0, $t2, reduce_health
	lw $t0, 2576($s4)
	beq $t0, $t2, reduce_health
	lw $t0, 2580($s4)
	beq $t0, $t2, reduce_health
	lw $t0, 2584($s4)
	beq $t0, $t2, reduce_health
	lw $t0, -260($s4)
	beq $t0, $t2, reduce_health
	lw $t0, -256($s4)
	beq $t0, $t2, reduce_health
	lw $t0, -252($s4)
	beq $t0, $t2, reduce_health
	lw $t0, -248($s4)
	beq $t0, $t2, reduce_health
	lw $t0, -244($s4)
	beq $t0, $t2, reduce_health
	lw $t0, -240($s4)
	beq $t0, $t2, reduce_health
	lw $t0, -236($s4)
	beq $t0, $t2, reduce_health
	lw $t0, -232($s4)
	beq $t0, $t2, reduce_health
	lw $t0, 24($s4)
	beq $t0, $t2, reduce_health
	lw $t0, 280($s4)
	beq $t0, $t2, reduce_health
	lw $t0, 536($s4)	
	beq $t0, $t2, reduce_health
	lw $t0, 792($s4)
	beq $t0, $t2, reduce_health
	lw $t0, 1048($s4)	
	beq $t0, $t2, reduce_health
	lw $t0, 1304($s4)
	beq $t0, $t2, reduce_health
	lw $t0, 1560($s4)	
	beq $t0, $t2, reduce_health
	lw $t0, 1816($s4)
	beq $t0, $t2, reduce_health
	lw $t0, 2072($s4)	
	beq $t0, $t2, reduce_health
	lw $t0, 2328($s4)
	beq $t0, $t2, reduce_health


	
draw_player:
	beq $s7, 25, draw_player_high
	beq $s7, 0, draw_player_highest
	li $t0, 0xff0000
	li $t1, 0x000000
	li $t2, 0xb3b3b3
	sw $t0, 4($s4)
	sw $t0, 8($s4)
	sw $t0, 12($s4)
	sw $t0, 16($s4)
	sw $t0, 256($s4)
	sw $t0, 260($s4)
	sw $t0, 264($s4)
	sw $t0, 268($s4)
	sw $t0, 272($s4)
	sw $t0, 276($s4)
	sw $t1, 512($s4)
	sw $t0, 516($s4)
	sw $t0, 520($s4)
	sw $t0, 524($s4)
	sw $t0, 528($s4)
	sw $t1, 532($s4)
	sw $t0, 768($s4)
	sw $t2, 772($s4)
	sw $t2, 776($s4)
	sw $t2, 780($s4)
	sw $t2, 784($s4)
	sw $t0, 788($s4)
	sw $t0, 1024($s4)
	sw $t0, 1028($s4)
	sw $t0, 1032($s4)
	sw $t0, 1036($s4)
	sw $t0, 1040($s4)
	sw $t0, 1044($s4)
	sw $t0, 1280($s4)
	sw $t2, 1284($s4)
	sw $t2, 1288($s4)
	sw $t2, 1292($s4)
	sw $t2, 1296($s4)
	sw $t0, 1300($s4)
	sw $t0, 1536($s4)
	sw $t0, 1540($s4)
	sw $t0, 1544($s4)
	sw $t0, 1548($s4)
	sw $t0, 1552($s4)
	sw $t0, 1556($s4)
	sw $t1, 1792($s4)
	sw $t0, 1796($s4)
	sw $t0, 1800($s4)
	sw $t0, 1804($s4)
	sw $t0, 1808($s4)
	sw $t1, 1812($s4)
	sw $t0, 1796($s4)
	sw $t0, 2048($s4)
	sw $t0, 2052($s4)
	sw $t0, 2056($s4)
	sw $t0, 2060($s4)
	sw $t0, 2064($s4)
	sw $t0, 2068($s4)
	sw $t0, 2308($s4)
	sw $t0, 2312($s4)
	sw $t0, 2316($s4)
	sw $t0, 2320($s4)
	j draw_enemy
	
draw_player_high:
	li $t0, 0xff0000
	li $t1, 0x000000
	li $t2, 0xb3b3b3
	li $t3, 0xffa500
	sw $t0, 4($s4)
	sw $t0, 8($s4)
	sw $t0, 12($s4)
	sw $t0, 16($s4)
	sw $t0, 256($s4)
	sw $t0, 260($s4)
	sw $t0, 264($s4)
	sw $t0, 268($s4)
	sw $t0, 272($s4)
	sw $t0, 276($s4)
	sw $t1, 512($s4)
	sw $t0, 516($s4)
	sw $t0, 520($s4)
	sw $t0, 524($s4)
	sw $t0, 528($s4)
	sw $t1, 532($s4)
	sw $t0, 768($s4)
	sw $t2, 772($s4)
	sw $t2, 776($s4)
	sw $t2, 780($s4)
	sw $t2, 784($s4)
	sw $t0, 788($s4)
	sw $t0, 1024($s4)
	sw $t0, 1028($s4)
	sw $t0, 1032($s4)
	sw $t0, 1036($s4)
	sw $t0, 1040($s4)
	sw $t0, 1044($s4)
	sw $t0, 1280($s4)
	sw $t2, 1284($s4)
	sw $t2, 1288($s4)
	sw $t2, 1292($s4)
	sw $t2, 1296($s4)
	sw $t0, 1300($s4)
	sw $t0, 1536($s4)
	sw $t0, 1540($s4)
	sw $t0, 1544($s4)
	sw $t0, 1548($s4)
	sw $t0, 1552($s4)
	sw $t0, 1556($s4)
	sw $t1, 1792($s4)
	sw $t0, 1796($s4)
	sw $t0, 1800($s4)
	sw $t0, 1804($s4)
	sw $t0, 1808($s4)
	sw $t1, 1812($s4)
	sw $t0, 1796($s4)
	sw $t0, 2048($s4)
	sw $t0, 2052($s4)
	sw $t0, 2056($s4)
	sw $t0, 2060($s4)
	sw $t0, 2064($s4)
	sw $t0, 2068($s4)
	sw $t3, 2304($s4)
	sw $t0, 2308($s4)
	sw $t0, 2312($s4)
	sw $t0, 2316($s4)
	sw $t0, 2320($s4)
	sw $t3, 2324($s4)
	sw $t3, 2560($s4)
	sw $t3, 2564($s4)
	sw $t3, 2576($s4)
	sw $t3, 2580($s4)
	j draw_enemy
	
draw_player_highest:
	li $t0, 0xff0000
	li $t1, 0x000000
	li $t2, 0xb3b3b3
	li $t3, 0x00feff
	sw $t0, 4($s4)
	sw $t0, 8($s4)
	sw $t0, 12($s4)
	sw $t0, 16($s4)
	sw $t0, 256($s4)
	sw $t0, 260($s4)
	sw $t0, 264($s4)
	sw $t0, 268($s4)
	sw $t0, 272($s4)
	sw $t0, 276($s4)
	sw $t1, 512($s4)
	sw $t0, 516($s4)
	sw $t0, 520($s4)
	sw $t0, 524($s4)
	sw $t0, 528($s4)
	sw $t1, 532($s4)
	sw $t0, 768($s4)
	sw $t2, 772($s4)
	sw $t2, 776($s4)
	sw $t2, 780($s4)
	sw $t2, 784($s4)
	sw $t0, 788($s4)
	sw $t0, 1024($s4)
	sw $t0, 1028($s4)
	sw $t0, 1032($s4)
	sw $t0, 1036($s4)
	sw $t0, 1040($s4)
	sw $t0, 1044($s4)
	sw $t0, 1280($s4)
	sw $t2, 1284($s4)
	sw $t2, 1288($s4)
	sw $t2, 1292($s4)
	sw $t2, 1296($s4)
	sw $t0, 1300($s4)
	sw $t0, 1536($s4)
	sw $t0, 1540($s4)
	sw $t0, 1544($s4)
	sw $t0, 1548($s4)
	sw $t0, 1552($s4)
	sw $t0, 1556($s4)
	sw $t1, 1792($s4)
	sw $t0, 1796($s4)
	sw $t0, 1800($s4)
	sw $t0, 1804($s4)
	sw $t0, 1808($s4)
	sw $t1, 1812($s4)
	sw $t0, 1796($s4)
	sw $t0, 2048($s4)
	sw $t0, 2052($s4)
	sw $t0, 2056($s4)
	sw $t0, 2060($s4)
	sw $t0, 2064($s4)
	sw $t0, 2068($s4)
	sw $t3, 2304($s4)
	sw $t0, 2308($s4)
	sw $t0, 2312($s4)
	sw $t0, 2316($s4)
	sw $t0, 2320($s4)
	sw $t3, 2324($s4)
	sw $t3, 2560($s4)
	sw $t3, 2564($s4)
	sw $t3, 2576($s4)
	sw $t3, 2580($s4)
	sw $t3, 2816($s4)
	sw $t3, 2836($s4)
	j draw_enemy
	

draw_enemy:
	beq $s1, 0, draw_set_1
	beq $s1, 1, draw_set_2
	beq $s1, 2, draw_set_3
	beq $s1, 3, draw_set_4
	beq $s1, 4, draw_set_5
	beq $s1, 5, draw_set_6
	beq $s1, 6, draw_set_7
	beq $s1, 7, draw_set_8
	beq $s1, 8, draw_set_9
	beq $s1, 9, draw_set_10
	
draw_set_1:
	jal draw_enemy_1
	jal draw_enemy_2
	j setup_draw_h
	
draw_set_2:
	jal draw_enemy_2
	jal draw_enemy_3
	j setup_draw_h
	
draw_set_3:
	jal draw_enemy_1
	jal draw_enemy_4
	j setup_draw_h
	
draw_set_4:
	jal draw_enemy_3
	jal draw_enemy_4
	j setup_draw_h
	
draw_set_5:
	jal draw_enemy_2
	jal draw_enemy_4
	j setup_draw_h

draw_set_6:
	jal draw_enemy_1
	jal draw_enemy_3
	j setup_draw_h
	
draw_set_7:
	jal draw_enemy_1
	j setup_draw_h

draw_set_8:
	jal draw_enemy_2
	j setup_draw_h
	
	
draw_set_9:
	jal draw_enemy_3
	j setup_draw_h

draw_set_10:
	jal draw_enemy_4
	j setup_draw_h
	

draw_enemy_1:
	la $t4, start_menu
	addi $t4, $t4, 2200
	add $t4, $t4,$s3
	addi $t4, $t4, -2560
	li $t0, 0xFFA500
	li $t1, 0x000000
	li $t2, 0xb3b3b3
	sw $t0, 4($t4)
	sw $t0, 8($t4)
	sw $t0, 12($t4)
	sw $t0, 16($t4)
	sw $t0, 256($t4)
	sw $t0, 260($t4)
	sw $t0, 264($t4)
	sw $t0, 268($t4)
	sw $t0, 272($t4)
	sw $t0, 276($t4)
	sw $t1, 512($t4)
	sw $t0, 516($t4)
	sw $t0, 520($t4)
	sw $t0, 524($t4)
	sw $t0, 528($t4)
	sw $t1, 532($t4)
	sw $t0, 768($t4)
	sw $t2, 772($t4)
	sw $t2, 776($t4)
	sw $t2, 780($t4)
	sw $t2, 784($t4)
	sw $t0, 788($t4)
	sw $t0, 1024($t4)
	sw $t0, 1028($t4)
	sw $t0, 1032($t4)
	sw $t0, 1036($t4)
	sw $t0, 1040($t4)
	sw $t0, 1044($t4)
	sw $t0, 1280($t4)
	sw $t2, 1284($t4)
	sw $t2, 1288($t4)
	sw $t2, 1292($t4)
	sw $t2, 1296($t4)
	sw $t0, 1300($t4)
	sw $t0, 1536($t4)
	sw $t0, 1540($t4)
	sw $t0, 1544($t4)
	sw $t0, 1548($t4)
	sw $t0, 1552($t4)
	sw $t0, 1556($t4)
	sw $t1, 1792($t4)
	sw $t0, 1796($t4)
	sw $t0, 1800($t4)
	sw $t0, 1804($t4)
	sw $t0, 1808($t4)
	sw $t1, 1812($t4)
	sw $t0, 1796($t4)
	sw $t0, 2048($t4)
	sw $t0, 2052($t4)
	sw $t0, 2056($t4)
	sw $t0, 2060($t4)
	sw $t0, 2064($t4)
	sw $t0, 2068($t4)
	sw $t0, 2308($t4)
	sw $t0, 2312($t4)
	sw $t0, 2316($t4)
	sw $t0, 2320($t4)
	jr $ra

	
draw_enemy_2:
	la $t4, start_menu
	addi $t4, $t4, 2400
	add $t4, $t4,$s3
	addi $t4, $t4, -1280
	li $t0, 0xFFA500
	li $t1, 0x000000
	li $t2, 0xb3b3b3
	sw $t0, 4($t4)
	sw $t0, 8($t4)
	sw $t0, 12($t4)
	sw $t0, 16($t4)
	sw $t0, 256($t4)
	sw $t0, 260($t4)
	sw $t0, 264($t4)
	sw $t0, 268($t4)
	sw $t0, 272($t4)
	sw $t0, 276($t4)
	sw $t1, 512($t4)
	sw $t0, 516($t4)
	sw $t0, 520($t4)
	sw $t0, 524($t4)
	sw $t0, 528($t4)
	sw $t1, 532($t4)
	sw $t0, 768($t4)
	sw $t2, 772($t4)
	sw $t2, 776($t4)
	sw $t2, 780($t4)
	sw $t2, 784($t4)
	sw $t0, 788($t4)
	sw $t0, 1024($t4)
	sw $t0, 1028($t4)
	sw $t0, 1032($t4)
	sw $t0, 1036($t4)
	sw $t0, 1040($t4)
	sw $t0, 1044($t4)
	sw $t0, 1280($t4)
	sw $t2, 1284($t4)
	sw $t2, 1288($t4)
	sw $t2, 1292($t4)
	sw $t2, 1296($t4)
	sw $t0, 1300($t4)
	sw $t0, 1536($t4)
	sw $t0, 1540($t4)
	sw $t0, 1544($t4)
	sw $t0, 1548($t4)
	sw $t0, 1552($t4)
	sw $t0, 1556($t4)
	sw $t1, 1792($t4)
	sw $t0, 1796($t4)
	sw $t0, 1800($t4)
	sw $t0, 1804($t4)
	sw $t0, 1808($t4)
	sw $t1, 1812($t4)
	sw $t0, 1796($t4)
	sw $t0, 2048($t4)
	sw $t0, 2052($t4)
	sw $t0, 2056($t4)
	sw $t0, 2060($t4)
	sw $t0, 2064($t4)
	sw $t0, 2068($t4)
	sw $t0, 2308($t4)
	sw $t0, 2312($t4)
	sw $t0, 2316($t4)
	sw $t0, 2320($t4)
	jr $ra



draw_enemy_3:
	la $t4, start_menu
	addi $t4, $t4, 2000
	add $t4, $t4,$s3
	addi $t4, $t4, -3840
	li $t0, 0xFFA500
	li $t1, 0x000000
	li $t2, 0xb3b3b3
	sw $t0, 4($t4)
	sw $t0, 8($t4)
	sw $t0, 12($t4)
	sw $t0, 16($t4)
	sw $t0, 256($t4)
	sw $t0, 260($t4)
	sw $t0, 264($t4)
	sw $t0, 268($t4)
	sw $t0, 272($t4)
	sw $t0, 276($t4)
	sw $t1, 512($t4)
	sw $t0, 516($t4)
	sw $t0, 520($t4)
	sw $t0, 524($t4)
	sw $t0, 528($t4)
	sw $t1, 532($t4)
	sw $t0, 768($t4)
	sw $t2, 772($t4)
	sw $t2, 776($t4)
	sw $t2, 780($t4)
	sw $t2, 784($t4)
	sw $t0, 788($t4)
	sw $t0, 1024($t4)
	sw $t0, 1028($t4)
	sw $t0, 1032($t4)
	sw $t0, 1036($t4)
	sw $t0, 1040($t4)
	sw $t0, 1044($t4)
	sw $t0, 1280($t4)
	sw $t2, 1284($t4)
	sw $t2, 1288($t4)
	sw $t2, 1292($t4)
	sw $t2, 1296($t4)
	sw $t0, 1300($t4)
	sw $t0, 1536($t4)
	sw $t0, 1540($t4)
	sw $t0, 1544($t4)
	sw $t0, 1548($t4)
	sw $t0, 1552($t4)
	sw $t0, 1556($t4)
	sw $t1, 1792($t4)
	sw $t0, 1796($t4)
	sw $t0, 1800($t4)
	sw $t0, 1804($t4)
	sw $t0, 1808($t4)
	sw $t1, 1812($t4)
	sw $t0, 1796($t4)
	sw $t0, 2048($t4)
	sw $t0, 2052($t4)
	sw $t0, 2056($t4)
	sw $t0, 2060($t4)
	sw $t0, 2064($t4)
	sw $t0, 2068($t4)
	sw $t0, 2308($t4)
	sw $t0, 2312($t4)
	sw $t0, 2316($t4)
	sw $t0, 2320($t4)
	jr $ra

	
draw_enemy_4:
	la $t4, start_menu
	addi $t4, $t4, 2600
	add $t4, $t4,$s3
	addi $t4, $t4, -1280
	li $t0, 0xFFA500
	li $t1, 0x000000
	li $t2, 0xb3b3b3
	sw $t0, 4($t4)
	sw $t0, 8($t4)
	sw $t0, 12($t4)
	sw $t0, 16($t4)
	sw $t0, 256($t4)
	sw $t0, 260($t4)
	sw $t0, 264($t4)
	sw $t0, 268($t4)
	sw $t0, 272($t4)
	sw $t0, 276($t4)
	sw $t1, 512($t4)
	sw $t0, 516($t4)
	sw $t0, 520($t4)
	sw $t0, 524($t4)
	sw $t0, 528($t4)
	sw $t1, 532($t4)
	sw $t0, 768($t4)
	sw $t2, 772($t4)
	sw $t2, 776($t4)
	sw $t2, 780($t4)
	sw $t2, 784($t4)
	sw $t0, 788($t4)
	sw $t0, 1024($t4)
	sw $t0, 1028($t4)
	sw $t0, 1032($t4)
	sw $t0, 1036($t4)
	sw $t0, 1040($t4)
	sw $t0, 1044($t4)
	sw $t0, 1280($t4)
	sw $t2, 1284($t4)
	sw $t2, 1288($t4)
	sw $t2, 1292($t4)
	sw $t2, 1296($t4)
	sw $t0, 1300($t4)
	sw $t0, 1536($t4)
	sw $t0, 1540($t4)
	sw $t0, 1544($t4)
	sw $t0, 1548($t4)
	sw $t0, 1552($t4)
	sw $t0, 1556($t4)
	sw $t1, 1792($t4)
	sw $t0, 1796($t4)
	sw $t0, 1800($t4)
	sw $t0, 1804($t4)
	sw $t0, 1808($t4)
	sw $t1, 1812($t4)
	sw $t0, 1796($t4)
	sw $t0, 2048($t4)
	sw $t0, 2052($t4)
	sw $t0, 2056($t4)
	sw $t0, 2060($t4)
	sw $t0, 2064($t4)
	sw $t0, 2068($t4)
	sw $t0, 2308($t4)
	sw $t0, 2312($t4)
	sw $t0, 2316($t4)
	sw $t0, 2320($t4)
	jr $ra

setup_draw_h: 
    li $t5, 0
    li $t9, 0x0000ff
    la $t0, start_menu
    li $t6,  2044
    j draw_h
	
draw_h:  
	sw $t9, 0($t0)
	beq $t5, $t6, setup_draw_progress_bar
	addi $t0, $t0, 4
	addi $t5, $t5, 4
	j draw_h

setup_draw_progress_bar: 
    li $t5, 0
    li $t9, 0x4FE34F
    la $t0, start_menu
    li $t6,  1000
    j draw_progress_bar
	
draw_progress_bar:
	sw $t9, 260($t0)
	sw $t9, 264($t0)
	sw $t9, 268($t0)
	sw $t9, 516($t0)
	sw $t9, 524($t0)
	sw $t9, 772($t0)
	sw $t9, 780($t0)
	sw $t9, 1028($t0)
	sw $t9, 1032($t0)
	sw $t9, 1036($t0)
	sw $t9, 1284($t0)
	sw $t9, 1540($t0)
	li $t9, 0x000000
	li $t8, 0xffffff
	sw $t9, 276($t0)
	sw $t8, 280($t0)
	sw $t9, 284($t0)
	sw $t8, 288($t0)
	sw $t9, 292($t0)
	sw $t8, 296($t0)
	sw $t9, 300($t0)
	sw $t8, 304($t0)
	sw $t9, 308($t0)
	sw $t8, 312($t0)
	sw $t9, 316($t0)
	sw $t8, 320($t0)
	sw $t9, 324($t0)
	sw $t8, 328($t0)
	
	sw $t9, 332($t0)
	sw $t8, 336($t0)
	
	
	sw $t8, 532($t0)
	sw $t9, 788($t0)
	sw $t8, 1044($t0)
	sw $t9, 1300($t0)
	sw $t9, 340($t0)
	sw $t8, 344($t0)
	sw $t9, 348($t0)
	sw $t8, 352($t0)
	sw $t9, 356($t0)
	sw $t8, 360($t0)
	sw $t9, 364($t0)
	sw $t8, 368($t0)
	sw $t9, 372($t0)
	
	sw $t9, 628($t0)
	sw $t8, 884($t0)
	sw $t9, 1140($t0)
	sw $t8, 1396($t0)
	sw $t9, 1556($t0)
	sw $t8, 1560($t0)
	sw $t9, 1564($t0)
	sw $t8, 1568($t0)
	sw $t9, 1572($t0)
	sw $t8, 1576($t0)
	sw $t9, 1580($t0)
	sw $t8, 1584($t0)
	sw $t9, 1588($t0)
	sw $t8, 1592($t0)
	sw $t9, 1596($t0)
	sw $t8, 1600($t0)
	sw $t9, 1604($t0)
	sw $t8, 1608($t0)
	sw $t9, 1612($t0)
	sw $t8, 1616($t0)
	sw $t9, 1620($t0)
	sw $t8, 1624($t0)
	sw $t9, 1628($t0)
	sw $t8, 1632($t0)
	sw $t9, 1636($t0)
	sw $t8, 1640($t0)
	sw $t9, 1644($t0)
	sw $t8, 1648($t0)
	sw $t9, 1652($t0)
	addi $t1, $t0, 0
	addi $t2, $t0, 0
	li $t4, 460
	bgt $s5, $t4, draw_progress_23
	li $t4, 440
	bgt $s5, $t4, draw_progress_22
	li $t4, 420
	bgt $s5, $t4, draw_progress_21
	li $t4, 400
	bgt $s5, $t4, draw_progress_20
	li $t4, 380
	bgt $s5, $t4, draw_progress_19
	li $t4, 360
	bgt $s5, $t4, draw_progress_18
	li $t4, 340
	bgt $s5, $t4, draw_progress_17
	li $t4, 320
	bgt $s5, $t4, draw_progress_16
	li $t4, 300
	bgt $s5, $t4, draw_progress_15
	li $t4, 280
	bgt $s5, $t4, draw_progress_14
	li $t4, 260
	bgt $s5, $t4, draw_progress_13
	
	li $t4, 240
	bgt $s5, $t4, draw_progress_12
	li $t4, 220
	bgt $s5, $t4, draw_progress_11
	li $t4, 200
	bgt $s5, $t4, draw_progress_10
	li $t4, 180
	bgt $s5, $t4, draw_progress_9
	li $t4, 160
	bgt $s5, $t4, draw_progress_8
	li $t4, 140
	bgt $s5, $t4, draw_progress_7
	li $t4, 120
	bgt $s5, $t4, draw_progress_6
	li $t4, 100
	bgt $s5, $t4, draw_progress_5
	li $t4, 80
	bgt $s5, $t4, draw_progress_4
	li $t4, 60
	bgt $s5, $t4, draw_progress_3
	li $t4, 40
	bgt $s5, $t4, draw_progress_2
	li $t4, 20
	bgt $s5, $t4, draw_progress_1
	
	
	j draw_progress
	#beq $t5, $t6, check_move
	#addi $t0, $t0, 4
	#addi $t5, $t5, 4
	#j draw_progress_bar

draw_progress_1:
	addi $t1, $t0, 4
	j draw_progress
draw_progress_2:	
	addi $t1, $t0, 8
	j draw_progress
draw_progress_3:
	addi $t1, $t0, 12
	j draw_progress
draw_progress_4:	
	addi $t1, $t0, 16
	j draw_progress
	
draw_progress_5:
	addi $t1, $t0, 20
	j draw_progress
draw_progress_6:	
	addi $t1, $t0, 24
	j draw_progress
draw_progress_7:
	addi $t1, $t0, 28
	j draw_progress
draw_progress_8:	
	addi $t1, $t0, 32
	j draw_progress
	
draw_progress_9:
	addi $t1, $t0, 36
	j draw_progress
draw_progress_10:	
	addi $t1, $t0, 40
	j draw_progress
draw_progress_11:
	addi $t1, $t0, 44
	j draw_progress
draw_progress_12:	
	addi $t1, $t0, 48
	j draw_progress
	
draw_progress_13:
	addi $t1, $t0, 52
	j draw_progress
draw_progress_14:	
	addi $t1, $t0, 56
	j draw_progress
draw_progress_15:
	addi $t1, $t0, 60
	j draw_progress
draw_progress_16:	
	addi $t1, $t0, 64
	j draw_progress	

draw_progress_17:
	addi $t1, $t0, 68
	j draw_progress
draw_progress_18:	
	addi $t1, $t0, 72
	j draw_progress
draw_progress_19:
	addi $t1, $t0, 76
	j draw_progress
draw_progress_20:	
	addi $t1, $t0, 80
	j draw_progress	
	
draw_progress_21:
	addi $t1, $t0, 84
	j draw_progress
draw_progress_22:	
	addi $t1, $t0, 88
	j draw_progress	
draw_progress_23:	
	addi $t1, $t0, 92
	j draw_progress	
draw_progress:
	beq $t1, $t0, draw_health_h
	li $t9, 0x4FE34F
	sw $t9, 536($t0)
	sw $t9, 792($t0)
	sw $t9, 1048($t0)
	sw $t9, 1304($t0)
	#sw $t9, 792($t0)
	#sw $t9, 1048($t0)
	#sw $t9, 1304($t0)
	addi $t0, $t0, 4
	j draw_progress
	
draw_health_h:
	la $t3, start_menu
	li $t1, 0xFF033E
	sw $t1, 392($t3)
	sw $t1, 648($t3)
	sw $t1, 904($t3)
	sw $t1, 1160($t3)
	sw $t1, 1416($t3)
	sw $t1, 1672($t3)
	sw $t1, 908($t3)
	sw $t1, 400($t3)
	sw $t1, 656($t3)
	sw $t1, 912($t3)
	sw $t1, 1168($t3)
	sw $t1, 1424($t3)
	sw $t1, 1680($t3)
	
	sw $t1, 408($t3)
	sw $t1, 412($t3)
	sw $t1, 416($t3)
	sw $t1, 420($t3)
	sw $t1, 424($t3)
	sw $t1, 428($t3)
	sw $t1, 432($t3)
	sw $t1, 436($t3)
	sw $t1, 440($t3)
	sw $t1, 444($t3)
	sw $t1, 448($t3)
	sw $t1, 452($t3)
	sw $t1, 456($t3)
	sw $t1, 460($t3)
	sw $t1, 464($t3)
	sw $t1, 468($t3)
	sw $t1, 472($t3)
	sw $t1, 476($t3)
	sw $t1, 480($t3)
	sw $t1, 484($t3)
	sw $t1, 488($t3)
	sw $t1, 492($t3)
	sw $t1, 496($t3)
	sw $t1, 500($t3)
	sw $t1, 504($t3)
	
	sw $t1, 760($t3)
	sw $t1, 1016($t3)
	sw $t1, 1272($t3)
	sw $t1, 1528($t3)
	sw $t1, 1784($t3)
	
	sw $t1, 664($t3)
	sw $t1, 920($t3)
	sw $t1, 1176($t3)
	sw $t1, 1432($t3)
	sw $t1, 1688($t3)
	
	sw $t1, 1692($t3)
	sw $t1, 1696($t3)
	sw $t1, 1700($t3)
	sw $t1, 1704($t3)
	sw $t1, 1708($t3)
	sw $t1, 1712($t3)
	sw $t1, 1716($t3)
	sw $t1, 1720($t3)
	sw $t1, 1724($t3)
	sw $t1, 1728($t3)
	sw $t1, 1732($t3)
	sw $t1, 1736($t3)
	sw $t1, 1740($t3)
	sw $t1, 1744($t3)
	sw $t1, 1748($t3)
	sw $t1, 1752($t3)
	sw $t1, 1756($t3)
	sw $t1, 1760($t3)
	sw $t1, 1764($t3)
	sw $t1, 1768($t3)
	sw $t1, 1772($t3)
	sw $t1, 1776($t3)
	sw $t1, 1780($t3)
	sw $t1, 1784($t3)
	li $t5, 92
	sub $t5, $t5, $s6
	li $t6, 0
	li $t1, 0xFF00FF
	
draw_health:
	beq $t6, $t5, redraw
	sw $t1, 668($t3)
	sw $t1, 924($t3)
	sw $t1, 1180($t3)
	sw $t1, 1436($t3)
	addi $t3, $t3, 4
	addi $t6, $t6, 4
	j draw_health

redraw: 
li $v0, 32  
add $a0, $zero, $s7
syscall
j draw_screen
	
end:
li $v0, 10 # terminate the program
syscall

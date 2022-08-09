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
    lw $s1, displayAddress
    la $s3, start_menu
    la $s4, start_menu
    addi $s4, $s4, 8048
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
j redraw
	
	
redraw: 
li $v0, 32  
li $a0, 20
syscall
j redraww

redraww:	
	li $t5, 0
    li $t1, 0xb3b3b3
    addi $s0, $s0, 256
    addi $t0, $s0, 256
    lw $t6, bottom_right_index
    addi $t4, $s3, 2048  
    beq $t4, $s0, rupdate_s
    
    add $t0, $s0, $zero
    lw $t6, bottom_right_index  
    j rdraw_road 
    
rupdate_s:
	subi $s0, $s0, 2560
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
	bgt $t0, $t7, setup_draw_h
	addi $t0, $t0, 248
	li $t5, 0
	j rdraw_right_black_line

rupdate_right_black_line:
	li $t2, 0
	addi $t0, $t0, 1536
	j rdraw_right_black_line
	
setup_draw_h: 
    li $t5, 0
    li $t9, 0x0000ff
    la $t0, start_menu
    li $t6,  2044
    j draw_h
	
draw_h:
	sw $t9, 0($t0)
	beq $t5, $t6, check_move
	addi $t0, $t0, 4
	addi $t5, $t5, 4
	j draw_h
	
check_move:
	li $t9, 0xffff0000
	lw $t8, 0($t9)
	beq $t8, 1, keypress_happened
	j draw_player
	
keypress_happened:
	lw $t2, 4($t9) # this assumes $t9 is set to 0xfff0000
	beq $t2, 0x61, respond_to_a
	beq $t2, 100, respond_to_d
	
	
	j draw_player

respond_to_a:
	la $t4, start_menu
	addi $t4, $t4, 7936
	beq $s4, $t4, draw_player
	addi $s4, $s4, -4
	j draw_player
	
respond_to_d:
	la $t4, start_menu
	addi $t4, $t4, 8168
	beq $s4, $t4, draw_player
	addi $s4, $s4, 4
	j draw_player
draw_player:
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
	j draw_screen
	
	 
	
end:
li $v0, 10 # terminate the program
syscall

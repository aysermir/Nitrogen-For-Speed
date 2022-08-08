.data
displayAddress: .word 0x10008000 
start_index: .word 0 
road_colour: .word 0x696968 
inner_road_colour: .word 0x33312b
bottom_right_index: .word 65528

.text
setup_draw: 
    li $t5, 0
    li $t1, 0x000000
    lw $s0, displayAddress
    lw $s1, displayAddress
    add $t0, $s0, $zero
    lw $t6, bottom_right_index  
    j draw_road  
	
draw_road:
	sw $t1, 0($t0)
	beq $t5, $t6, setup_draw_left_line
	addi $t0, $t0, 4
	addi $t5, $t5, 4
	j draw_road
		
	
	
setup_draw_left_line:
	addi $t0, $s0, 132
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
	addi $t7, $s0, 65532
	bgt $t0, $t7, setup_draw_left_black_line
	addi $t0, $t0, 504
	li $t5, 0
	j draw_left_line

update_left_line:
	li $t2, 0
	addi $t0, $t0, 5120
	j draw_left_line
	
	
	
##################################
setup_draw_left_black_line:
	addi $t0, $s0, 4228
	li $t1, 0x000000
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
	addi $t7, $s0, 65532
	bgt $t0, $t7, setup_draw_right_line
	addi $t0, $t0, 504
	li $t5, 0
	j draw_left_black_line

update_left_black_line:
	li $t2, 0
	addi $t0, $t0, 5120
	j draw_left_black_line
################################	
	
	
setup_draw_right_line:
	addi $t0, $s0, 376
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
	addi $t7, $s0, 65532
	bgt $t0, $t7, setup_draw_right_black_line
	addi $t0, $t0, 504
	li $t5, 0
	j draw_right_line

update_right_line:
	li $t2, 0
	addi $t0, $t0, 3072
	j draw_right_line
	
##################################
setup_draw_right_black_line:
	addi $t0, $s0, 4228
	li $t1, 0x000000
	sw $t1, 0($t0)
	li $t5, 0
	li $t6, 8
	li $t8, 12
	li $t2, 0
	j rdraw_right_black_line
	
draw_right_black_line:
	beq $t5, $t6, update_right_black_line_pixel
	beq, $t2, $t8, update_right_black_line
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t5, $t5, 4
	addi $t2, $t2, 1
	j rdraw_right_black_line
	
update_right_black_line_pixel: 
	addi $t7, $s0, 65532
	bgt $t0, $t7, rsetup_draw_center_line
	addi $t0, $t0, 504
	li $t5, 0
	j rdraw_right_black_line

update_right_black_line:
	li $t2, 0
	addi $t0, $t0, 5120
	j rdraw_right_black_line
################################
	
setup_draw_center_line:
	addi $t0, $s0, 256
	li $t1, 0xffffff
	sw $t1, 0($t0)
	li $t5, 0
	li $t6, 8
	j draw_center_line
	
draw_center_line:
	beq $t5, $t6, update_center_line_pixel
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t5, $t5, 4
	addi $t2, $t2, 1
	j draw_center_line
	
update_center_line_pixel: 
	addi $t7, $s0, 65532
	bgt $t0, $t7, setup_draw_left_yellow_line
	addi $t0, $t0, 504
	li $t5, 0
	j draw_center_line
	
setup_draw_left_yellow_line:
	addi $t0, $s0, 28
	li $t1, 0xFEDE00
	sw $t1, 0($t0)
	li $t5, 0
	li $t6, 4
	j draw_left_yellow_line
	
draw_left_yellow_line:
	beq $t5, $t6, update_left_yellow_line_pixel
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t5, $t5, 4
	addi $t2, $t2, 1
	j draw_left_yellow_line
	
update_left_yellow_line_pixel: 
	addi $t7, $s0, 65532
	bgt $t0, $t7, setup_draw_right_yellow_line
	addi $t0, $t0, 508
	li $t5, 0
	j draw_left_yellow_line
	
setup_draw_right_yellow_line:
	addi $t0, $s0, 480
	li $t1, 0xFEDE00
	sw $t1, 0($t0)
	li $t5, 0
	li $t6, 4
	j draw_right_yellow_line
	
draw_right_yellow_line:
	beq $t5, $t6, update_right_yellow_line_pixel
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t5, $t5, 4
	addi $t2, $t2, 1
	j draw_right_yellow_line
	
update_right_yellow_line_pixel: 
	addi $t7, $s0, 65532
	bgt $t0, $t7, set_up_redraw
	addi $t0, $t0, 508
	li $t5, 0
	j draw_right_yellow_line
	

set_up_redraw:
j redraw
	
	
redraw: 
li $v0, 32  
li $a0, 100
syscall
j redraww

redraww:	
	li $t5, 0
    li $t1, 0x000000 
    addi $s0, $s0, 512
    lw $t6, bottom_right_index  
    beq $t4, $s0, rupdate_s
    addi $t4, $s1, 1536
    add $t0, $s0, $zero
    lw $t6, bottom_right_index  
    j rdraw_road 
    
rupdate_s:
	subi $s0, $s0, 8192
	add $t0, $s0, $zero
	
rdraw_road:
	sw $t1, 0($t0)
	beq $t5, $t6, rsetup_draw_left_line
	addi $t0, $t0, 4
	addi $t5, $t5, 4
	j rdraw_road
		
	
	
rsetup_draw_left_line:
	addi $t0, $s0, 132
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
	addi $t7, $s0, 65532
	bgt $t0, $t7, rsetup_draw_left_black_line
	addi $t0, $t0, 504
	li $t5, 0
	j rdraw_left_line

rupdate_left_line:
	li $t2, 0
	addi $t0, $t0, 5120
	j rdraw_left_line
	
	
	
##################################
rsetup_draw_left_black_line:
	addi $t0, $s0, 4228
	li $t1, 0x000000
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
	addi $t7, $s0, 65000
	bgt $t0, $t7, rsetup_draw_right_line
	addi $t0, $t0, 504
	li $t5, 0
	j rdraw_left_black_line

rupdate_left_black_line:
	li $t2, 0
	addi $t0, $t0, 5120
	j rdraw_left_black_line
################################	
	
	
rsetup_draw_right_line:
	addi $t0, $s0, 376
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
	addi $t7, $s0, 65532
	bgt $t0, $t7, rsetup_draw_right_black_line
	addi $t0, $t0, 504
	li $t5, 0
	j rdraw_right_line
	
rupdate_right_line:
	li $t2, 0
	addi $t0, $t0, 5120
	j rdraw_right_line
	
##################################
rsetup_draw_right_black_line:
	addi $t0, $s0, 4472
	li $t1, 0x000000
	sw $t1, 0($t0)
	li $t5, 0
	li $t6, 8
	li $t8, 12
	li $t2, 0
	j rdraw_right_black_line
	
	
rdraw_right_black_line:
	beq $t5, $t6, rupdate_right_black_line_pixel
	beq, $t2, $t8, rupdate_right_black_line
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t5, $t5, 4
	addi $t2, $t2, 1
	j rdraw_right_black_line
	
rupdate_right_black_line_pixel: 
	addi $t7, $s0, 65000
	bgt $t0, $t7, rsetup_draw_center_line
	addi $t0, $t0, 504
	li $t5, 0
	j rdraw_right_black_line

rupdate_right_black_line:
	li $t2, 0
	addi $t0, $t0, 5120
	j rdraw_right_black_line
	
rsetup_draw_center_line:
	addi $t0, $s0, 256
	li $t1, 0xffffff
	sw $t1, 0($t0)
	li $t5, 0
	li $t6, 8
	j rdraw_center_line
	
rdraw_center_line:
	beq $t5, $t6, rupdate_center_line_pixel
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t5, $t5, 4
	addi $t2, $t2, 1
	j rdraw_center_line
	
rupdate_center_line_pixel: 
	addi $t7, $s0, 65532
	bgt $t0, $t7, rsetup_draw_left_yellow_line
	addi $t0, $t0, 504
	li $t5, 0
	j rdraw_center_line
	
rsetup_draw_left_yellow_line:
	addi $t0, $s0, 28
	li $t1, 0xFEDE00
	sw $t1, 0($t0)
	li $t5, 0
	li $t6, 4
	j rdraw_left_yellow_line
	
rdraw_left_yellow_line:
	beq $t5, $t6, rupdate_left_yellow_line_pixel
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t5, $t5, 4
	addi $t2, $t2, 1
	j rdraw_left_yellow_line
	
rupdate_left_yellow_line_pixel: 
	addi $t7, $s0, 65532
	bgt $t0, $t7, rsetup_draw_right_yellow_line
	addi $t0, $t0, 508
	li $t5, 0
	j rdraw_left_yellow_line
	
rsetup_draw_right_yellow_line:
	addi $t0, $s0, 480
	li $t1, 0xFEDE00
	sw $t1, 0($t0)
	li $t5, 0
	li $t6, 4
	j rdraw_right_yellow_line
	
rdraw_right_yellow_line:
	beq $t5, $t6, rupdate_right_yellow_line_pixel
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t5, $t5, 4
	addi $t2, $t2, 1
	j rdraw_right_yellow_line
	
rupdate_right_yellow_line_pixel: 
	addi $t7, $s0, 65532
	bgt $t0, $t7, redraw
	addi $t0, $t0, 508
	li $t5, 0
	j rdraw_right_yellow_line
	
	


	
end:
li $v0, 10 # terminate the program
syscall
.data
displayAddress: .word 0x10008000
start_index: .word 0 
road_colour: .word 0x696968 
inner_road_colour: .word 0x33312b
bottom_right_index: .word 65528
A: .word 65528
.text
setup_draw: 
    li $t5, 0
    li $t1, 0x696968 
    lw $s1, displayAddress
    lw $s0, displayAddress
    add $t0, $s0, $zero
    lw $t6, bottom_right_index  
    j draw_road  

redraw:
	li $v0, 32
	li $a0, 500
	syscall 
	li $t5, 0
	li $t6, 65528
	add $t0, $zero, $s1
	addi $t1, $zero, 0x000000 
	j setup_redraw
    		
    	
	
setup_redraw: 
	li $t5, 0
	addi $t1, $zero, 0x696968 
    	addi $s0, $s0, 512
    	add $t0, $s0, $zero
    	li $t6, 65528
    	j draw_road 
	
draw_road:
	sw $t1, 0($t0)
	beq $t5, $t6, setup_draw_left_lane
	addi $t0, $t0, 4
	addi $t5, $t5, 4
	j draw_road
	
setup_draw_left_lane:
	addi $t0, $s0, 0
	li $t1, 0xCCCCCC
	sw $t1, 0($t0)
	li $t5, 0
	li $t6, 256
	j draw_left_lane

draw_left_lane:
	sw $t1, 0($t0)
	beq $t5, $t6, update_left_lane_pixel
	addi $t0, $t0, 4
	addi $t5, $t5, 4
	j draw_left_lane
	
update_left_lane_pixel: 
	addi $t7, $s0, 65532
	bgt $t0, $t7, setup_draw_right_lane
	addi $t0, $t0, 256
	li $t5, 0
	j draw_left_lane
	
setup_draw_right_lane:
	addi $t0, $s0, 256
	li $t1, 0x33312B
	sw $t1, 0($t0)
	li $t5, 0
	li $t6, 120
	j draw_right_lane

draw_right_lane:
	sw $t1, 0($t0)
	beq $t5, $t6, update_right_lane_pixel
	addi $t0, $t0, 4
	addi $t5, $t5, 4
	j draw_right_lane
	
update_right_lane_pixel: 
	addi $t7, $s0, 65532
	bgt $t0, $t7, setup_draw_innermost_left_lane
	addi $t0, $t0, 392
	li $t5, 0
	j draw_right_lane
	
setup_draw_innermost_left_lane:
	addi $t0, $s0, 136
	li $t1, 0xCCC9C0
	sw $t1, 0($t0)
	li $t5, 0
	li $t6, 120
	j draw_innermost_left_lane

draw_innermost_left_lane:
	sw $t1, 0($t0)
	beq $t5, $t6, update_innerleft_lane_pixel
	addi $t0, $t0, 4
	addi $t5, $t5, 4
	j draw_innermost_left_lane
	
update_innerleft_lane_pixel: 
	addi $t7, $s0, 65532
	bgt $t0, $t7, setup_draw_left_line
	addi $t0, $t0, 392
	li $t5, 0
	j draw_innermost_left_lane
	
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
	bgt $t0, $t7, setup_draw_right_line
	addi $t0, $t0, 504
	li $t5, 0
	j draw_left_line

update_left_line:

	li $t2, 0
	addi $t0, $t0, 3072
	j draw_left_line
	
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
	bgt $t0, $t7, setup_draw_center_line
	addi $t0, $t0, 504
	li $t5, 0
	j draw_right_line

update_right_line:
	li $t2, 0
	addi $t0, $t0, 3072
	j draw_right_line
	
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
	bgt $t0, $t7, setup_draw_red_line
	addi $t0, $t0, 508
	li $t5, 0
	j draw_right_yellow_line
	
setup_draw_red_line:
	addi $t0, $s0, 0
	li $t1, 0xFF0000
	sw $t1, 0($t0)
	li $t5, 0
	li $t6, 8
	li $t8, 24
	li $t2, 0
	j draw_red_line
	
draw_red_line:
	beq $t5, $t6, update_red_line_pixel
	beq, $t2, $t8, update_red_line
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t5, $t5, 4
	addi $t2, $t2, 1
	j draw_red_line
	
update_red_line_pixel: 
	addi $t7, $s0, 65532
	bgt $t0, $t7, setup_draw_redd_line
	addi $t0, $t0, 504
	li $t5, 0
	j draw_red_line

update_red_line:
	li $t2, 0
	addi $t0, $t0, 6144
	j draw_red_line
	
setup_draw_redd_line:
	addi $t0, $s0, 504
	li $t1, 0xFF0000
	sw $t1, 0($t0)
	li $t5, 0
	li $t6, 8
	li $t8, 24
	li $t2, 0
	j draw_redd_line
	
draw_redd_line:
	beq $t5, $t6, update_redd_line_pixel
	beq, $t2, $t8, update_redd_line
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t5, $t5, 4
	addi $t2, $t2, 1
	j draw_redd_line
	
update_redd_line_pixel: 
	addi $t7, $s0, 65532
	bgt $t0, $t7, setup_draw_blue_line
	addi $t0, $t0, 504
	li $t5, 0
	j draw_redd_line

update_redd_line:
	li $t2, 0
	addi $t0, $t0, 6144
	j draw_redd_line
	
setup_draw_blue_line:
	addi $t0, $s0, 6144
	li $t1, 0x0047AB
	sw $t1, 0($t0)
	li $t5, 0
	li $t6, 8
	li $t8, 24
	li $t2, 0
	j draw_blue_line
	
draw_blue_line:
	beq $t5, $t6, update_blue_line_pixel
	beq, $t2, $t8, update_blue_line
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t5, $t5, 4
	addi $t2, $t2, 1
	j draw_blue_line
	
update_blue_line_pixel: 
	addi $t7, $s0, 65532
	bgt $t0, $t7, setup_draw_bluee_line
	addi $t0, $t0, 504
	li $t5, 0
	j draw_blue_line

update_blue_line:
	li $t2, 0
	addi $t0, $t0, 6144
	j draw_blue_line

setup_draw_bluee_line:
	addi $t0, $s0, 6648
	li $t1, 0x0047AB
	sw $t1, 0($t0)
	li $t5, 0
	li $t6, 8
	li $t8, 24
	li $t2, 0
	j draw_bluee_line
	
draw_bluee_line:
	beq $t5, $t6, update_bluee_line_pixel
	beq, $t2, $t8, update_bluee_line
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t5, $t5, 4
	addi $t2, $t2, 1
	j draw_bluee_line
	
update_bluee_line_pixel: 
	addi $t7, $s0, 65532
	bgt $t0, $t7, redraw
	addi $t0, $t0, 504
	li $t5, 0
	j draw_bluee_line

update_bluee_line:
	li $t2, 0
	addi $t0, $t0, 6144
	j draw_bluee_line


	
end:
li $v0, 10 # terminate the program
syscall

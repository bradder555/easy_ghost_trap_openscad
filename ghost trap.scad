wall_thickness=5;

module ghost_trap_body_half(){
  cube([wall_thickness, 175, 70],center=true);
  
  translate([-45/2,0, -(70 - 5)/2 ])
  cube([45, 175, wall_thickness],center=true);
  
  translate([-45/2,-(175 - 5)/2,0])
  rotate([0,0,90])
  cube([wall_thickness, 45, 70],center=true);
  
  translate([-4, -(175-wall_thickness)/2, 70/2+2.5])
  rotate([90,0,0]){
    difference(){
      union(){
        translate([0,-2.5,0])
        cube([12,wall_thickness,wall_thickness], center=true);
        cylinder(h=wall_thickness, r=6, center=true, $fn=40);
      }
      cylinder(h=wall_thickness, r=3, center=true, $fn=40);
    }
  }
}

module wedge(){
  rotate([90,90,90])
  hull(){
    cylinder(r=1, h=10, $fn=10, center=true);
    translate([0,5,0])cylinder(r=1, h=10, $fn=10, center=true);
    translate([10,0,0])cylinder(r=1, h=10, $fn=10, center=true);
  }
}

module ghost_trap_body(){
    mirror([1,0,0])
    translate([45,0,0])
    ghost_trap_body_half();
  translate([45,0,0])
  ghost_trap_body_half();
  translate([0,-(168)/2,34])
  wedge();
}

module ghost_trap_flap(){
  cube([41,170,4], center=true);
  translate([(41)/2, 0,0])
  rotate([90,0,0])
  cylinder(h=179, r=2, center=true, $fn=40);
}

module ghost_trap_end_half(){
  
  translate([29,0,0]){
    difference(){
      // beveled edge
      linear_extrude(80, center=true)
      polygon([[0,0], [8,0], [18,10], [18,18], [0,18]]);
      
      translate([11.5,16,32.5])
      rotate([90,0,0])
      cylinder(h=6, r=3, center=true, $fn=40);
    }
    // side
    translate([-12,9,-5])
    cube([34, 18, 70], center=true);
  }
}

module ghost_trap_end_display(){
  w__ = 57;
   hull(){
     translate([0,0,0])cube([w__,2,2], center=true);
     translate([0,-23,17])cube([w__,2,2], center=true);
     translate([0,-23,37])cube([w__,2,2], center=true);
     translate([0,0,20])cube([w__,2,2], center=true);
   }   
}


module ghost_trap_end(){
  ghost_trap_end_half();
  mirror([1,0,0])ghost_trap_end_half();
  translate([0,17,9])ghost_trap_end_display();
}

module caddy_wall(){
  rotate([90,0,0])
  linear_extrude(wall_thickness)
  polygon([
    [0,0],
    [200,0],
    [200,70], 
    [200-75, 70], 
    [200-75-10, 70+10],
    [-10, 70+10],
    [-10,70-(25+10)],
    [0,25]
  ]);
}

module caddy(){
    caddy_wall();
    translate([0,96 + wall_thickness,0])
    caddy_wall();
  
    translate([-2,-wall_thickness,-wall_thickness])
    cube([202,96+2*wall_thickness,wall_thickness]);
  
    translate([wall_thickness,-wall_thickness,-wall_thickness])
    rotate([0,-90,0])
    cube([70,96+2*wall_thickness,wall_thickness]);
}

module caddy_block(){
  main_width = 86;
  main_depth = 55;
  
  polygon([
    [0,0],
    [main_depth-2*10,0],
    [main_depth-10, 10],
    [main_depth-10, main_width],
    [main_depth-2*10, main_width + 10],
    [0, main_width+10]
  ]);
  
}

module caddy_handle(){
  handle_offset=50;
  handle_length=120;
  grip_diameter=20;
  
  translate([0,0,handle_offset])
  rotate([0,90,0])
  cylinder(h=handle_length, d=grip_diameter);
  
  translate([0,-grip_diameter/2,0])
  cube([grip_diameter, grip_diameter, handle_offset]);
    
}

module caddy_end(){
    linear_extrude(65)
    caddy_block();
    translate([0,48,65])
    caddy_handle();
}

ghost_trap_end();


/*
mirror([1,0,0])
caddy_end();
caddy();


ghost_trap_body();

color("blue",0.5)
translate([20.5,2,37.5])
ghost_trap_flap();

mirror([1,0,0])
translate([20.5,2,37.5])
ghost_trap_flap();


translate([0,211/2,5])
mirror([0,1,0])
ghost_trap_end();

*/



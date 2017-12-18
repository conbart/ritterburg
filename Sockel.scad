$fn=100;
difference(){
    union(){
        translate([0,0,0])cylinder(r1=25,r2=20,h=10);
        translate([0,0,10])cylinder(r1=15,r2=10,h=10);
    }
    translate([0,0,5])cylinder(r1=2.5,r2=2.5,h=20);
}
// x = breite
// y = tiefe
// z = hoehe

dicke=8;
hdicke=dicke/2;
rmdicke=dicke+2;
rm1sdicke=dicke+1;
rmhdicke=rmdicke/2;
unit=25;
hunit=unit/2;
$fn=100;

// turmseite
tsbreite=100;
tstiefe=dicke;
tshoehe=250;

// turmplatte
tpbreite=tsbreite;
tptiefe=tsbreite;
tphoehe=dicke;

// turmetage
tebreite=tsbreite-2*dicke;
tetiefe=tsbreite-2*dicke;
tehoehe=dicke;

// turmkrone
tkbreite=tpbreite+2*dicke;
tktiefe=dicke;
tkhoehe=3*unit;

//turmfenster
tfgroesse=3;
tfhoehe=190;

//turmtuer
ttgroesse=6;
tthoehe=6*unit;

// turm
tmbreite=tkbreite;
tmtiefe=tkbreite;
tmhoehe=tshoehe+tkhoehe;

// burg
bgbreite=800;
bgtiefe=800;
bghoehe=tmhoehe;


//aussenmauerseite
amsbreite=bgbreite-(2*tkbreite)+(2*dicke);
amstiefe=dicke;
amshoehe=tthoehe+2*unit;

//aussenmauerweg
amwbreite=amsbreite;
amwtiefe=tsbreite-(2*dicke);
amwhoehe=5*unit;

//aussenmauer
ambreite=amsbreite;
amtiefe=tsbreite;
amhoehe=amshoehe;

//hausdach
hdbreite=ambreite;
hdtiefe=ambreite/3;
hdhoehe=amwhoehe;

//hausmauer
hmbreite=ambreite;
hmtiefe=dicke;
hmhoehe=amwhoehe+dicke;

//treppe
trbreite=11*unit;
trtiefe=4*unit;
trhoehe=8*dicke;

//zugbruecke
zbbreite=140;
zbtiefe=dicke/2;
zbhoehe=130;

//turmfenster
module turmfenster(x=0,y=0,z=0,rot=0,groesse=0){
    // grundform
    translate([x,y,z])translate([0,(rmdicke/2),0])rotate([90,0,0])intersection(){
        translate([groesse*11,0,0])cylinder(d=groesse*30,h=rmdicke);
        translate([-groesse*11,0,0])cylinder(d=groesse*30,h=rmdicke);
        translate([0,groesse*15,(rmdicke/2)])cube([groesse*30,groesse*30,rmdicke],center=true);
    }
}

//turmtuer
module turmtuer(x=0,y=0,z=0,rot=0,groesse=0){
    translate([x,y,z])translate([0,(rmdicke/2),groesse*6-1])rotate([90,0,0])union(){
        // grunform
        intersection(){
            translate([groesse*11,0,0])cylinder(d=groesse*30,h=rmdicke);
            translate([-groesse*11,0,0])cylinder(d=groesse*30,h=rmdicke);
            translate([0,groesse*15,(rmdicke/2)])cube([groesse*30,groesse*30,rmdicke],center=true);
        }
        // verlaengerung unten
        translate([0,-groesse*3+1,(rmdicke/2)])cube([groesse*8,groesse*6,rmdicke],center=true);
    }
}

// turmseite
module turmseite(x=0,y=0,z=0,rot=0,aussen=false,special=false){
    breite=tsbreite;    
    hoehe=tshoehe;
    hhoehe=hoehe/2;
    hbreite=breite/2;
    translate([x,y,z])translate([0,0,hhoehe])rotate(rot){
        difference(){
            translate([-hbreite,-hdicke,-hhoehe])union(){
                difference(){
                    // grundform
                    cube([breite,dicke,hoehe]);
                    if (aussen){
                        if (special){
                            // ausschnitte links
                            translate([-1,-1,-1])cube([rm1sdicke,rmdicke,(unit*3)+1]);  
                            translate([-1,-1,4*unit])cube([rm1sdicke,rmdicke,unit*3]);         
                            translate([-1,-1,8*unit])cube([rm1sdicke,rmdicke,unit]);                    }
                        else {
                            // ausschnitte links
                            translate([-1,-1,-1])cube([rm1sdicke,rmdicke,unit+1]);
                            translate([-1,-1,2*unit])cube([rm1sdicke,rmdicke,unit]);  
                            translate([-1,-1,4*unit])cube([rm1sdicke,rmdicke,unit]);         
                            translate([-1,-1,6*unit])cube([rm1sdicke,rmdicke,unit]); 
                            translate([-1,-1,8*unit])cube([rm1sdicke,rmdicke,unit]);
                        }
                    }
                    else {
                        // ausschnitte links
                        translate([-1,-1,-1])cube([rm1sdicke,rmdicke,(unit*3)+1]);
                        translate([-1,-1,4*unit])cube([rm1sdicke,rmdicke,unit*3]);          
                        translate([-1,-1,8*unit])cube([rm1sdicke,rmdicke,unit]);
                    }
                    // ausschnitte rechts 
                    translate([breite-dicke,-1,1*unit])cube([rm1sdicke,rmdicke,unit]);
                    translate([breite-dicke,-1,3*unit])cube([rm1sdicke,rmdicke,unit]);  
                    translate([breite-dicke,-1,5*unit])cube([rm1sdicke,rmdicke,unit]);  
                    translate([breite-dicke,-1,7*unit])cube([rm1sdicke,rmdicke,unit]);  
                    translate([breite-dicke,-1,9*unit])cube([rm1sdicke,rmdicke,unit+1]);
                }
                // nut oben 
                translate([(breite-unit)/2,0,hoehe])cube([unit,dicke,dicke]);
            }
            translate([-hbreite,-hdicke,-hhoehe]){
                if(aussen==true){
                    turmfenster(hbreite,hdicke,tfhoehe,0,tfgroesse);
                    translate([hbreite-(unit/2),hdicke-(rmdicke/2),tthoehe-dicke])cube([unit,rmdicke,dicke]);             
                }
                else {
                    turmtuer(hbreite,hdicke,tthoehe,0,ttgroesse);
                    // ausschnitte fuer turmetage
                    translate([hbreite-hunit,hdicke-(rmdicke/2),tthoehe-dicke])cube([unit,rmdicke,rm1sdicke]);
                    // ausschnitte fuer mauer 
                    translate([hbreite-(unit/2),hdicke-(rmdicke/2),amwhoehe])cube([unit,rmdicke,dicke]);        
                }       
            }
        }

    }
 
}

// turmetage
module turmetage(x=0,y=0,z=0,rot=0){
    breite=tebreite;
    tiefe=tetiefe;      
    hoehe=tehoehe;  
    hhoehe=hoehe/2;
    htiefe=tiefe/2;
    hbreite=breite/2;
    translate([x,y,z])translate([0,0,hhoehe])rotate(rot)translate([-hbreite,-htiefe,-hhoehe])union(){
        // grundform
        cube([breite,tiefe,hoehe]);      
        // nut seitlich
        translate([((breite-unit)/2),-dicke,0])cube([unit,dicke,hoehe]);
        translate([((breite-unit)/2),tiefe,0])cube([unit,dicke,hoehe]);
        translate([-dicke,((breite-unit)/2),0])cube([dicke,unit,hoehe]);
        translate([tiefe,((breite-unit)/2),0])cube([dicke,unit,hoehe]);       
    }
}


// turmplatte
module turmplatte(x=0,y=0,z=0,rot=0){
    breite=tpbreite;
    tiefe=tptiefe;      
    hoehe=tphoehe;  
    hhoehe=hoehe/2;
    htiefe=tiefe/2;
    hbreite=breite/2;
    translate([x,y,z])translate([0,0,hhoehe])rotate(rot)translate([-hbreite,-htiefe,-hhoehe])union(){
        difference(){
            // grundform
            cube([breite,tiefe,hoehe]);
            // ausschnitte befestigung unten
            translate([(breite-unit)/2,-1,-1])cube([unit,rm1sdicke,rmdicke]);      
            translate([(breite-unit)/2,tsbreite-dicke,-1])cube([unit,rm1sdicke,rmdicke]);
            translate([tsbreite-dicke,(breite-unit)/2,-1])cube([rm1sdicke,unit,rmdicke]);
            translate([-1,(breite-unit)/2,-1])cube([rm1sdicke,unit,rmdicke]);       
        }
        // nut seitlich
        translate([0,-dicke,0])cube([unit,dicke,hoehe]);
        translate([breite-unit,-dicke,0])cube([unit,dicke,hoehe]);
        translate([0,tiefe,0])cube([unit,dicke,hoehe]);
        translate([breite-unit,tiefe,0])cube([unit,dicke,hoehe]);
        translate([-dicke,0,0])cube([dicke,unit,hoehe]);
        translate([-dicke,breite-unit,0])cube([dicke,unit,hoehe]);
        translate([tiefe,0,0])cube([dicke,unit,hoehe]);
        translate([tiefe,breite-unit,0])cube([dicke,unit,hoehe]);         
    }
}

// turmkrone
module turmkrone(x=0,y=0,z=0,rot=0){
    breite=tkbreite;
    tiefe=tktiefe;      
    hoehe=tkhoehe;  
    hhoehe=hoehe/2;
    htiefe=tiefe/2;
    hbreite=breite/2;
    translate([x,y,z])translate([0,0,hhoehe])rotate(rot)translate([-hbreite,-htiefe,-hhoehe])difference(){
        // grundform
        cube([breite,tiefe,hoehe]);
        // ausschnitte befestigung unten
        translate([dicke-1,-1,-1])cube([unit+1,rmdicke,rm1sdicke]);
        translate([breite-unit-dicke,-1,-1])cube([unit,rmdicke,rm1sdicke]); 
        // ausschnitte befestigung seitlich
        translate([-1,-1,-1])cube([rm1sdicke,rmdicke,unit+(hunit/2)+1]);  
        translate([-1,-1,unit+hunit+(hunit/2)])cube([rm1sdicke,rmdicke,unit+(hunit/2)+1]);
        translate([breite-dicke,-1,unit+(hunit/2)])cube([rm1sdicke,rmdicke,hunit]); 
         // ausschnitte oben
        translate([((breite-unit)/2)-unit,-1,hoehe-dicke])cube([unit,rmdicke,rm1sdicke]);
        translate([((breite-unit)/2)+unit,-1,hoehe-dicke])cube([unit,rmdicke,rm1sdicke]);        
    }
    
}

// turm
module turm(x=0,y=0,z=0,rot=0){
    translate([x,y,z])rotate([0,0,rot]){
        // variablen
        htshoehe=tshoehe/2;
        htsbreite=tsbreite/2;
        tsdiff=htsbreite-hdicke;
    
        htkhoehe=tkhoehe/2;
        htkbreite=tkbreite/2;
        tkdiff=htkbreite-hdicke;
    
        //turmseiten
        turmseite(0,-tsdiff,0,0,true,false);
        turmseite(tsdiff,0,0,90,false,false);
        turmseite(0,tsdiff,0,180,false,false);
        turmseite(-tsdiff,0,0,270,true,true);
        
        //turmplatte
        turmplatte(0,0,tshoehe,0);
    
        //turmkrone       
        turmkrone(0,-tkdiff,tshoehe,0);
        turmkrone(tkdiff,0,tshoehe,90);
        turmkrone(0,tkdiff,tshoehe,180);
        turmkrone(-tkdiff,0,tshoehe,270); 
     
        //turmetage
        turmetage(0,0,tthoehe-dicke,0); 
    }  
}

//aussenmauerseite
module aussenmauerseite(x=0,y=0,z=0,rot=0,aussen=true,torseite=false,rueckseite=false,rechts=false,links=false){
    breite=amsbreite;
    tiefe=amstiefe;
    hoehe=amshoehe;
    hbreite=breite/2;
    htiefe=tiefe/2;
    hhoehe=hoehe/2;
    
    translate([x,y,z])translate([0,0,hhoehe])rotate(rot)translate([-hbreite,-htiefe,-hhoehe])difference(){
        union(){
          // grundform
          cube([breite,tiefe,hoehe]);
          // nut links
          translate([-dicke,0,unit])cube([dicke,dicke,unit]);
          if (aussen) {
            translate([-dicke,0,unit*5])cube([dicke,dicke,unit]);
          }
          if (aussen) {
            // nut rechts
            translate([breite,0,unit])cube([dicke,dicke,unit]);
          }
          translate([breite,0,unit*5])cube([dicke,dicke,unit]);
        }
        // zinnen
        translate([-1,-1,hoehe-dicke])cube([unit+1,rmdicke,rm1sdicke]);
        translate([2*unit,-1,hoehe-dicke])cube([unit,rmdicke,rm1sdicke]);
        translate([4*unit,-1,hoehe-dicke])cube([unit,rmdicke,rm1sdicke]);
        translate([6*unit,-1,hoehe-dicke])cube([unit,rmdicke,rm1sdicke]);
        translate([8*unit,-1,hoehe-dicke])cube([unit,rmdicke,rm1sdicke]);
        translate([10*unit,-1,hoehe-dicke])cube([unit,rmdicke,rm1sdicke]);
        translate([12*unit,-1,hoehe-dicke])cube([unit,rmdicke,rm1sdicke]);
        translate([14*unit,-1,hoehe-dicke])cube([unit,rmdicke,rm1sdicke]);
        translate([16*unit,-1,hoehe-dicke])cube([unit,rmdicke,rm1sdicke]);
        translate([18*unit,-1,hoehe-dicke])cube([unit,rmdicke,rm1sdicke]);
        translate([20*unit,-1,hoehe-dicke])cube([unit,rmdicke,rm1sdicke]);
        translate([22*unit,-1,hoehe-dicke])cube([unit,rmdicke,rm1sdicke]); 
        // wegbefestigung
        if ((!aussen) && (rueckseite)) {
            translate([2*unit,-1,amwhoehe])cube([unit,rmdicke,rm1sdicke]);      
        }
        else {
            translate([2*unit,-1,amwhoehe])cube([unit,rmdicke,dicke]);
        }      
        translate([8*unit,-1,amwhoehe])cube([unit,rmdicke,dicke]);
        translate([14*unit,-1,amwhoehe])cube([unit,rmdicke,dicke]);        
        translate([20*unit,-1,amwhoehe])cube([unit,rmdicke,dicke]);
        if (!aussen) {
            if (rueckseite) {
                // aussparung durchgang
                translate([unit-1,-1,amwhoehe+dicke])cube([3*unit+2,rmdicke,4*unit]);
                // befestigung hausdach
                translate([4*unit,-1,amwhoehe])cube([unit,rmdicke,dicke]);
                translate([6*unit,-1,amwhoehe])cube([unit,rmdicke,dicke]);             
                translate([10*unit,-1,amwhoehe])cube([unit,rmdicke,dicke]);
                translate([12*unit,-1,amwhoehe])cube([unit,rmdicke,dicke]);
                translate([16*unit,-1,amwhoehe])cube([unit,rmdicke,dicke]); 
                translate([18*unit,-1,amwhoehe])cube([unit,rmdicke,dicke]);             
            }
            if (rechts) {
                // befestigung hausdach
                translate([16*unit,-1,amwhoehe])cube([unit,rmdicke,dicke]); 
                translate([18*unit,-1,amwhoehe])cube([unit,rmdicke,dicke]);
                // befestigung hausmauer
                translate([2*(breite/3)-dicke,-1,(hmhoehe-2*unit)/2])cube([dicke,rmdicke,2*unit]);   
            }         
            if (links) {
                // befestigung hausdach
                translate([4*unit,-1,amwhoehe])cube([unit,rmdicke,dicke]);
                translate([6*unit,-1,amwhoehe])cube([unit,rmdicke,dicke]);          
                // befestigung hausmauer
                translate([(breite/3),-1,(hmhoehe-2*unit)/2])cube([dicke,rmdicke,2*unit]);                 
            }            
        } 
        if (torseite) {
            if (aussen) {
                //tor
                translate([hbreite,dicke,60])rotate([90,0,0])translate([0,0,-1])cylinder(d=100,h=rmdicke);
                translate([hbreite-50,-1,-1])cube([100,rmdicke,60]);
                // aussparungen fuer zugbrueckenhalterung
                translate([(breite/2)-(zbbreite/2)-hdicke,-1,2*unit])cube([dicke,rmdicke,2*unit]);
                translate([(breite/2)+(zbbreite/2)-hdicke+1,-1,2*unit])cube([dicke,rmdicke,2*unit]);
            }
            else {
                //bogen
                translate([-120+hbreite,dicke,-33])rotate([90,0,0])translate([0,0,-1])cylinder(d=300,h=rmdicke);
                translate([120+hbreite,dicke,-33])rotate([90,0,0])translate([0,0,-1])cylinder(d=300,h=rmdicke);
                translate([-120+hbreite,-1,-1])cube([240,rmdicke,118]);
            }
        }
    }
}

// aussenmauerweg
module aussenmauerweg(x=0,y=0,z=0,rot=0){
    breite=amwbreite;
    tiefe=amwtiefe;
    hoehe=amwhoehe;
    hbreite=breite/2;
    htiefe=tiefe/2;
    hhoehe=hoehe/2;
    translate([x,y,z])translate([0,0,hhoehe])rotate(rot)translate([-hbreite,-htiefe,-hhoehe])union(){
        cube([breite,tiefe,dicke]);
        //nuten vorne
        translate([2*unit,-dicke,0])cube([unit,dicke,dicke]); 
        translate([8*unit,-dicke,0])cube([unit,dicke,dicke]); 
        translate([14*unit,-dicke,0])cube([unit,dicke,dicke]); 
        translate([20*unit,-dicke,0])cube([unit,dicke,dicke]);         
        //nuten hinten
        translate([2*unit,tiefe,0])cube([unit,dicke,dicke]); 
        translate([8*unit,tiefe,0])cube([unit,dicke,dicke]); 
        translate([14*unit,tiefe,0])cube([unit,dicke,dicke]); 
        translate([20*unit,tiefe,0])cube([unit,dicke,dicke]);  
        //links
        translate([-dicke,(tiefe-unit)/2,0])cube([dicke,unit,dicke]);
        //rechts
        translate([breite,(tiefe-unit)/2,0])cube([dicke,unit,dicke]);        
    }
    
}

// aussenmauer
module aussenmauer(x=0,y=0,z=0,rot=0,torseite=false,rueckseite=false,rechts=false,links=false){

    breite=ambreite;
    tiefe=amtiefe;
    hoehe=amhoehe;
    hbreite=breite/2;
    htiefe=tiefe/2;
    hhoehe=hoehe/2;
    translate([x,y,z])rotate(rot){
        aussenmauerseite(0,-(tsbreite/2)+(dicke/2),0,0,true,torseite,rueckseite,rechts,links);
        aussenmauerseite(0,(tsbreite/2)-(dicke/2),0,0,false,torseite,rueckseite,rechts,links);
        aussenmauerweg(0,0,amwhoehe,0);
    }
}

// hausdach
module hausdach(x=0,y=0,z=0,rot=0){

    breite=hdbreite;
    tiefe=hdtiefe;
    hoehe=hdhoehe;
    hbreite=breite/2;
    htiefe=tiefe/2;
    hhoehe=hoehe/2;
    translate([x,y,z])translate([0,0,hhoehe])rotate(rot)translate([-hbreite,-htiefe,-hhoehe])difference(){
        union(){
            cube([breite,tiefe,dicke]);
            // nuten hinten
            translate([breite-5*unit,tiefe,0])cube([unit,dicke,dicke]); 
            translate([breite-7*unit,tiefe,0])cube([unit,dicke,dicke]); 
            translate([breite-11*unit,tiefe,0])cube([unit,dicke,dicke]); 
            translate([breite-13*unit,tiefe,0])cube([unit,dicke,dicke]);
            translate([breite-17*unit,tiefe,0])cube([unit,dicke,dicke]); 
            translate([breite-19*unit,tiefe,0])cube([unit,dicke,dicke]); 
            // nuten rechts       
            translate([-dicke,19.66,0])cube([dicke,unit,dicke]);
            translate([-dicke,19.66+(2*unit),0])cube([dicke,unit,dicke]);   
            // nuten links     
            translate([breite,10.66,0])cube([dicke,unit,dicke]);
            translate([breite,10.66+(2*unit),0])cube([dicke,unit,dicke]);
            // nuten vorne
            translate([((breite-2*unit)/2),-dicke,0])cube([2*unit,dicke,dicke]);
            translate([((breite-2*unit)/2)+4*unit,-dicke,0])cube([2*unit,dicke,dicke]);
            translate([((breite-2*unit)/2)+8*unit,-dicke,0])cube([2*unit,dicke,dicke]);        
            translate([((breite-2*unit)/2)-4*unit,-dicke,0])cube([2*unit,dicke,dicke]);    
            translate([((breite-2*unit)/2)-8*unit,-dicke,0])cube([2*unit,dicke,dicke]);
        }
        translate([breite/2,tiefe/3-20,-1])cube([120,90,rmdicke]);
        translate([breite/2-16,tiefe/3-20-11,hdicke])cube([152,112,hdicke+1]);
    }
}

// hausmauer
module hausmauer(x=0,y=0,z=0,rot=0){

    breite=hmbreite;
    tiefe=hmtiefe;
    hoehe=hmhoehe;
    hbreite=breite/2;
    htiefe=tiefe/2;
    hhoehe=hoehe/2;
    translate([x,y,z])translate([0,0,hhoehe])rotate(rot)translate([-hbreite,-htiefe,-hhoehe])difference(){
        union(){
            cube([breite,tiefe,hoehe-dicke]);
            // nuten oben
            translate([((breite-2*unit)/2)+2*unit,0,hoehe-dicke])cube([2*unit,dicke,dicke]);
            translate([((breite-2*unit)/2)-2*unit,0,hoehe-dicke])cube([2*unit,dicke,dicke]);
            translate([((breite-2*unit)/2)+6*unit,0,hoehe-dicke])cube([2*unit,dicke,dicke]);
            translate([((breite-2*unit)/2)-6*unit,0,hoehe-dicke])cube([2*unit,dicke,dicke]);    
            translate([((breite-2*unit)/2)+10*unit,0,hoehe-dicke])cube([2*unit+17,dicke,dicke]);  
            translate([((breite-2*unit)/2)-10*unit-17,0,hoehe-dicke])cube([2*unit+17,dicke,dicke]);    // nuten links
            translate([-dicke,0,(hoehe-2*unit)/2])cube([dicke,dicke,2*unit]);   
            translate([breite,0,(hoehe-2*unit)/2])cube([dicke,dicke,2*unit]);     
        }
        // tuer
        translate([hbreite-150,dicke,60])rotate([90,0,0])translate([0,0,-1])cylinder(d=80,h=rmdicke);
        translate([hbreite-190,-1,-1])cube([80,rmdicke,60]);
    }
}


// treppe
module treppe(x=0,y=0,z=0,rot=0){

    breite=trbreite;
    tiefe=trtiefe;
    hoehe=trhoehe;
    hbreite=breite/2;
    htiefe=tiefe/2;
    hhoehe=hoehe/2;
    translate([x,y,z])translate([0,0,hhoehe])rotate(rot)translate([-hbreite,-htiefe,-hhoehe])union(){
        cube([breite,tiefe,dicke]);
        translate([0,0,dicke])cube([breite,tiefe,dicke]);        
        translate([unit,0,2*dicke])cube([breite-unit,tiefe,dicke]);
        translate([unit,0,3*dicke])cube([breite-unit,tiefe,dicke]);        
        translate([2*unit,0,4*dicke])cube([breite-(2*unit),tiefe,dicke]); 
        translate([2*unit,0,5*dicke])cube([breite-(2*unit),tiefe,dicke]);         
        translate([3*unit,0,6*dicke])cube([breite-(3*unit),tiefe,dicke]); 
        translate([3*unit,0,7*dicke])cube([breite-(3*unit),tiefe,dicke]);
        translate([4*unit,0,8*dicke])cube([breite-(4*unit),tiefe,dicke]);
        translate([4*unit,0,9*dicke])cube([breite-(4*unit),tiefe,dicke]);
        translate([5*unit,0,10*dicke])cube([breite-(5*unit),tiefe,dicke]);
        translate([5*unit,0,11*dicke])cube([breite-(5*unit),tiefe,dicke]);        
        translate([6*unit,0,12*dicke])cube([breite-(6*unit),tiefe,dicke]);  
        translate([6*unit,0,13*dicke])cube([breite-(6*unit),tiefe,dicke]);          
        translate([7*unit,0,14*dicke])cube([breite-(7*unit),tiefe,dicke]);          
        translate([7*unit,0,15*dicke])cube([breite-(7*unit),tiefe,dicke]);          

    }
}

// zugbruecke
module zugbruecke(x=0,y=0,z=0,rot=0){
    breite=zbbreite;
    tiefe=zbtiefe;
    hoehe=zbhoehe;
    hbreite=breite/2;
    htiefe=tiefe/2;
    hhoehe=hoehe/2;
    translate([x,y,z])translate([0,0,hhoehe])rotate(rot)translate([-hbreite,-htiefe,-hhoehe])union(){
        hdicke=dicke/2;
        translate([0,hdicke,70])rotate([90,0,0])translate([0,-5,13])cylinder(d=120,h=dicke);
        translate([-60,-17,5])cube([120,dicke,60]);
        translate([-90,-17,5])cube([180,dicke,dicke]);
    }    
}

module zugbrueckenhalter(x=0,y=0,z=0,rot=0){
    breite=zbbreite-10+2*dicke;
    tiefe=2*unit;
    hoehe=zbhoehe;
    hbreite=breite/2;
    htiefe=tiefe/2;
    hhoehe=hoehe/2;
    translate([x,y,z])translate([0,0,hhoehe])rotate(rot)translate([-hbreite,-htiefe,-hhoehe]){
        difference(){
            union(){
                intersection(){
                    union(){
                        translate([-1-(zbbreite/2),0,0])cube([dicke,tiefe,hoehe+20]);
                        translate([(zbbreite/2),0,0])cube([dicke,tiefe,hoehe+20]);
                    }
                    rotate([-19,0,0])translate([-5-(zbbreite/2),0,0])cube([dicke+zbbreite+10,tiefe,hoehe+30]);
                }        
                translate([-1-(zbbreite/2),2*unit,2*unit])cube([dicke,dicke,2*unit]);
                translate([(zbbreite/2),2*unit,2*unit])cube([dicke,dicke,2*unit]);
            }
            translate([-80,unit+hdicke-2,13])rotate([0,90,0])cylinder(175,dicke-2,dicke-2);
        }
    }
}

// luke
module luke(){
  translate([dicke+tsbreite+hdbreite/2-15,bgtiefe-(dicke+(hdtiefe/2)+tsbreite+(hdtiefe/3)-11.33+10),hdhoehe+hdicke])union(){
      //cube([140,110,hdicke]);
      cube([10,110,hdicke]);
      translate([20,0,0])cube([10,110,hdicke]);
      translate([40,0,0])cube([10,110,hdicke]);
      translate([60,0,0])cube([10,110,hdicke]);
      translate([80,0,0])cube([10,110,hdicke]);
      translate([100,0,0])cube([10,110,hdicke]);
      translate([120,0,0])cube([10,110,hdicke]); 
      translate([140,0,0])cube([10,110,hdicke]);   
      cube([150,10,hdicke]);
      translate([0,20,0])cube([150,10,hdicke]);      
      translate([0,40,0])cube([150,10,hdicke]);      
      translate([0,60,0])cube([150,10,hdicke]);      
      translate([0,80,0])cube([150,10,hdicke]);      
      translate([0,100,0])cube([150,10,hdicke]);            
  }
}

// burg
module burg(){
    
    // tuerme
    turm(tmbreite/2,tmtiefe/2,0,0);
    turm(bgbreite-(tmbreite/2),(tmtiefe/2),0,90);
    turm(bgbreite-(tmbreite/2),bgtiefe-(tmtiefe/2),0,180);
    turm((tmbreite/2),bgtiefe-(tmtiefe/2),0,270);
    
    // aussenmauern
    aussenmauer((ambreite/2)+dicke+tsbreite,(amtiefe/2)+dicke,0,0,true,false,false,false);
    aussenmauer((amtiefe/2)+dicke+tsbreite+ambreite,(ambreite/2)+dicke+tsbreite,0,90,false,false,true,false);
    aussenmauer((ambreite/2)+dicke+tsbreite,(amtiefe/2)+dicke+tsbreite+ambreite,0,180,false,true,false,false);
    aussenmauer((amtiefe/2)+dicke,(ambreite/2)+dicke+tsbreite,0,270,false,false,false,true);
    
    // hausdach
    hausdach((hdbreite/2)+dicke+tsbreite,bgtiefe-((hdtiefe/2)+dicke+tsbreite),hdhoehe,0);
    hausmauer((hmbreite/2)+dicke+tsbreite,bgtiefe-((hmtiefe/2)+tsbreite+hdtiefe+dicke),0,0);

    // luke
    luke();

    // treppe
    treppe((trbreite/2)+dicke+tsbreite+ambreite-trbreite,(trtiefe/2)-2+tsbreite+ambreite/2,0);

    // zugbruecke
    zugbruecke((zbbreite/2)+(bgbreite/2),0,zbtiefe);

    // zugbrueckenhalter
    zugbrueckenhalter((zbbreite/2)+(bgbreite/2),dicke-unit,0);
}

// rundeplatte
module rundeplatte(d,r) {
    translate([-((d[0])/2),-((d[1])/2),0])minkowski() {
        translate([r,r,0]) cube([d[0]-2*r, d[1]-2*r,d[2]]);
        cylinder(d[2],r,r);
    }
}

// burgplatten
module burgplatten(){
    translate([0,-10,dicke])rundeplatte([850,850,hdicke],100);
    translate([0,-10,0])rundeplatte([920,1020,hdicke],100);
    difference([]){
        translate([0,-10,dicke])rundeplatte([920,1020,hdicke],100);  
        translate([0,-10,dicke-1])rundeplatte([890,970,hdicke+1],100);
    }
}

translate([-(bgbreite/2),-(bgtiefe/2),2*dicke])burg();
burgplatten();

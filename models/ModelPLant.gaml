/***
* Name: ModelPLant
* Author: OscarHC
* Description: 
* Tags: Tag1, Tag2, TagN
***/

model ModelPLant
//variables globales
global
{ 	//variables
float vel_proteina<-0.005;
point mypoint;
int cantidad<-rnd(1,11);
float size <- 8.0;
float cont<-0.0;
bool stop<-false;
int cuenta<-10;
	float level_step <- 0.8;
	float length_max <- 100.0;
	int potacio<-20;
	//*******************************************************************************************************
	bool trace <-false;
	int cant_plant<-5 category:'Ambiente';
	//***********************Menu PLantas********************************************************************
	string tipoplant<-"Maiz" among:["Maiz","Lechuga", "Tomate"] category:'Planta';
	float edad<-1.1 category:'Planta';
	int phplant parameter:'PH'min: 0 max: 14<-7  category:'Planta';
	float timelive <-0.0 category:'Planta';
	float timeflor<-0.0 category:'Planta';
    float tempmin<-0.0 category: 'Planta';
	float tempmax<-0.0 category: 'Planta';
	float number_of_agents parameter: 'velocidad de crecimiento' min: 1.0 <- 250.0 step:10 category: 'Planta'; //asignas a una categoria de parametros
	//***********************************subcategoria*******************************************************
	int cant_Nitrogeno_plant<-10   category:'Necesidades Nutricionales';
	int cant_Fosforo_plant<-20     category:'Necesidades Nutricionales';
	int cant_Potasio_plant<-20     category:'Necesidades Nutricionales';
	int cant_Calcio_plant<-10      category:'Necesidades Nutricionales';
	int cant_Magnesio_plant<-20    category:'Necesidades Nutricionales';
	int cant_Azufre_plant<-20      category:'Necesidades Nutricionales';
	int cant_Boro_plant<-10        category:'Necesidades Nutricionales';
	int cant_Cobre_plant<-20       category:'Necesidades Nutricionales';
	int cant_Hierro_plant<-20      category:'Necesidades Nutricionales';
	int cant_Manganeso_plant<-10   category:'Necesidades Nutricionales';
	int cant_Molibdeno_plant<-20   category:'Necesidades Nutricionales';
	int cant_Zinc_plant<-20        category:'Necesidades Nutricionales';
	//***********************************Menu Biomasa********************************************************
	string typebio<-"Tierra" among:[ "Liquida", "Tierra"] category:'Biomasa';
    int humedabio<-20       category:'Biomasa';
	int cant_Nitrogeno<-10  category:'Biomasa';
	int cant_Fosforo<-10    category:'Biomasa';
	int cant_Potasio<-10    category:'Biomasa';
	int cant_Calcio<-10     category:'Biomasa';
	int cant_Magnesio<-10   category:'Biomasa';
	int cant_Azufre<-10     category:'Biomasa';
	int cant_Boro<-10       category:'Biomasa';
	int cant_Cobre<-10      category:'Biomasa';
	int cant_Hierro<-10     category:'Biomasa';
	int cant_Manganeso<-10  category:'Biomasa';
	int cant_Molibdeno<-20  category:'Biomasa';
	int cant_Zinc<-20       category:'Biomasa';
	int ph parameter:'PH'min: 0 max: 14<-7  category:'Biomasa';
	//string agentAspect <- "Potasio" among:["Calcio","Magnesio","Nitrogeno", "Sulduro","Potasio"] category: 'Biomasa';
	
	//*******************************************************************************************************
	//inicializas los agentes
	init
	{  
		
	create Nitrogeno number:cant_Nitrogeno
	{
		location<-{rnd(2,90),rnd(80,100),7};
		
	}
    create Fosforo number:cant_Fosforo
	{
		location<-{rnd(2,90),rnd(80,100),7};
		
	}
	create Potasio number:cant_Potasio
	{
		location<-{rnd(2,90),rnd(80,100),5};
		
	}
	create Magnesio number:cant_Magnesio
	{
		location<-{rnd(2,90),rnd(80,100),6};
		
	}
	create Calcio number:cant_Calcio
	{
		location<-{rnd(2,90),rnd(80,100),7};
		
	}
	create Azufre number:cant_Azufre
	{
		location<-{rnd(2,90),rnd(80,100),7};
		
	}
	create Boro number:cant_Boro
	{
		location<-{rnd(2,90),rnd(80,100),7};
		
	}
	create Cobre number:cant_Cobre
	{
		location<-{rnd(2,90),rnd(80,100),7};
	
	}
	create Hierro number:cant_Hierro
	{
		location<-{rnd(2,90),rnd(80,100),7};
		
	}
	create Manganeso number:cant_Manganeso
	{
		location<-{rnd(2,90),rnd(80,100),7};
		
	}
	create Molibdeno number:cant_Molibdeno
	{
		location<-{rnd(2,90),rnd(80,100),7};
		
	}
	create Zinc number:cant_Zinc
	{
		location<-{rnd(2,90),rnd(80,100),7};
		
	}
	
	create ramas number:potacio
	{
		location<-{50,rnd(60,90),5};
	}
	create planta number:cant_plant
		{
			
			location<-{50,75,5};
			mypoint<-location;
			//location<-{rnd(2,90),75,5};
		}


	create biomass
		{
			location<-{50,100,4};
			aa<-rectangle(100,50);
            liq<-rgb(120,60,0);
		}

	//importar imagenes 
	
	//image_file mature_corn_shape<-file("..images/mature_corn.png");
	}
	
	
}
//agente planta
species planta skills: []
{ //importar imagenes

	image_file maizstep1<-file("../images/sem0.png");
	image_file maizstep2<-file("../images/young_corn.png");
	float level <- 1.0;
	float beta <- 0.0;
	float alpha <- 0.0;
	planta parent <- nil;
	point base <- {0, 0, 0};
	point end <- {0, 0, 0};
	//su astpecto o forma
	aspect default
	{
		if(edad=1)
		{
			//aqui se programan los parametros___________________________________
		}
		//draw rectangle(1,30)color:#green;
		//dibujar maiz 
		draw maizstep1 size:2*size;
		
	}
	reflex growth when: stop=false
	{
		//size<-size+0.1;
		cont<-cont+0.1;
		 
	}
	reflex crese when:cont>100 and cont<200// and Potasio location:{12,12,12}
	{
		maizstep1<-file("../images/sem1.png");
	 
	}
	reflex crese2 when:cont>200 and cont<400
	{
		maizstep1<-file("../images/sem2.png");
	
	}
	reflex crese3 when:cont>400 and cont<500
	{
		maizstep1<-file("../images/sem3.png");
	location<-{50,69,5};
	
	size<-11.0; 
	}
	reflex crese4 when:cont>500 and cont<600
	{
		maizstep1<-file("../images/sem4.png");
	location<-{50,69,5}; 
	size<-14.5; 
	}
	reflex crese5 when:cont>600 and cont<700
	{
		maizstep1<-file("../images/sem5.png");
	location<-{50,68,5}; 
	size<-22.0; 
	}
	reflex mature when:cont>700 and cont<800
	{
		maizstep1<-file("../images/sem6.png");
	 location<-{50,68,5}; 
	}
	reflex die when:cont>1000
	{   
		maizstep1<-file("../images/sem7.png");
	location<-{50,68,5};
	stop<-true;
	}
	
}

//no funciona esto
species ramas parent: planta
{ // float length <- 0.0;
	//float width <- 0.0;
	bool can_split <- true;
	int cantidad<-rnd(1,20);
	reflex growth
	{
		//base <- parent.end;
		//float level_correction <- 1.8 * 0.3 ^ level;
		//width <- length / level_correction / 13.0;
		//length <- level_step ^ level * (length_max * (1 - min([1, exp(-2 / 1000)])));
		//end <- base + {length * cos(beta) * cos(alpha), length * cos(beta) * sin(alpha), length * sin(beta)};
	}
	aspect default
	{
		//draw line([base, end], width) color:#green;
		draw rectangle(10,1) color:(cantidad>0)?#green:#yellow border:rgb(0,150,0);
	}
	
}
//esta es la tierra no la biomasa

species biomass
{
	geometry aa;
	rgb liq;
	aspect default
	{		
              	
		draw aa color: liq;
	         
	   
	}
	
	reflex a  when: typebio="Liquida"
	{
	         aa<-rectangle(100,50);
	         liq<-rgb(212,234,237);      
	}
	reflex aaa when:typebio="Tierra"
	{
		aa<-rectangle(100,50) ;
              	liq<-rgb(120,60,0);
              	
	}
}


//particolas para la biomasa
species Nitrogeno skills:[moving] parent: biomass
{
	
	aspect default
	{
		if(typebio="Tierra"){
		draw circle(1) color:(cantidad>0)?#blue:#blue border: #darkgreen;
			//draw "N"color:#black size:1;
			}
	}
	reflex goto when: typebio="Tierra"
	{
		//mypoint<-{rnd(12),rnd(12),rnd(12)};
		do goto target: mypoint speed:vel_proteina;
		
	}
  
}
species Fosforo skills:[moving] parent: biomass
{
	
	aspect default
	{
		if(typebio="Tierra"){
		draw circle(1) color:(cantidad>0)?#aqua:#blue border: #darkgreen;
			//draw "F"color:#black size:1;
			}
	}
	reflex goto when: typebio="Tierra"
	{
		//mypoint<-{rnd(12),rnd(12),rnd(12)};
		do goto target: mypoint speed:vel_proteina;
	}

}

species Potasio skills:[moving] parent: biomass
{
	
	aspect default
	{
		if(typebio="Tierra"){
		draw circle(1) color:(cantidad>0)?#green:#blue border: #darkgreen;
			//draw "P"color:#black size:1;
			}
	}
	reflex goto when: typebio="Tierra"
	{
		//mypoint<-{rnd(12),rnd(12),rnd(12)};
		do goto target: mypoint speed:vel_proteina;
	}

}
species Calcio skills:[moving]parent: biomass
{   geometry a;
	aspect default
	{if(typebio="Tierra"){
			draw circle(1) color:(cantidad>0)?#yellow:#blue border: #black;
			//draw "C"color:#black size:1;	
	}}
	reflex goto when: typebio="Tierra"
	{
		//mypoint<-{rnd(12),rnd(12),rnd(12)};
		do goto target: mypoint speed:vel_proteina;
	}
	
}
species Magnesio skills:[moving] parent: biomass
{ 
	aspect default
	{	if(typebio="Tierra"){
		draw circle(1) color:(cantidad>0)?#brown:#blue border: #black;
			//draw "M"color:#black size:1;	
		}	
	}
	reflex goto when: typebio="Tierra"
	{
		//mypoint<-{rnd(12),rnd(12),rnd(12)};
		do goto target: mypoint speed:vel_proteina;
	}
	
}
species Azufre skills:[moving] parent: biomass
{
	
	aspect default
	{
		if(typebio="Tierra"){
		draw circle(1) color:(cantidad>0)?#pink:#blue border: #darkgreen;
			//draw "A"color:#black size:1;
			}
	}
	reflex goto when: typebio="Tierra"
	{
		//mypoint<-{rnd(12),rnd(12),rnd(12)};
		do goto target: mypoint speed:vel_proteina;
	}

}
species Boro skills:[moving] parent: biomass
{
	
	aspect default
	{
		if(typebio="Tierra"){
		draw circle(1) color:(cantidad>0)?#white:#blue border: #darkgreen;
			//draw "B"color:#black size:1;
			}
	}
	reflex goto when: typebio="Tierra"
	{
		//mypoint<-{rnd(12),rnd(12),rnd(12)};
		do goto target: mypoint speed:vel_proteina;
	}

}
species Cobre skills:[moving] parent: biomass
{
	
	aspect default
	{
		if(typebio="Tierra"){
		draw circle(1) color:(cantidad>0)?#magenta:#blue border: #darkgreen;
			//draw "C"color:#black size:1;
			}
	}
	reflex goto when: typebio="Tierra"
	{
		//mypoint<-{rnd(12),rnd(12),rnd(12)};
		do goto target: mypoint speed:vel_proteina;
	}

}
species Hierro skills:[moving] parent: biomass
{
	
	aspect default
	{
		if(typebio="Tierra"){
		draw circle(1) color:(cantidad>0)?#purple:#blue border: #darkgreen;
			//draw "H"color:#black size:1;
			}
	}
	reflex goto when: typebio="Tierra"
	{
		//mypoint<-{rnd(12),rnd(12),rnd(12)};
		do goto target: mypoint speed:vel_proteina;
	}

}
species Manganeso skills:[moving] parent: biomass
{
	
	aspect default
	{
		if(typebio="Tierra"){
		draw circle(1) color:(cantidad>0)?#black:#blue border: #darkgreen;
			//draw "Ma"color:#black size:1;
			}
	}
	reflex goto when: typebio="Tierra"
	{
		//mypoint<-{rnd(12),rnd(12),rnd(12)};
		do goto target: mypoint speed:vel_proteina;
	}

}
species Molibdeno skills:[moving] parent: biomass
{
	
	aspect default
	{
		if(typebio="Tierra"){
		draw circle(1) color:(cantidad>0)?#orange:#blue border: #darkgreen;
			//draw "M"color:#black size:1;
			}
	}
	reflex goto when: typebio="Tierra"
	{
		//mypoint<-{rnd(12),rnd(12),rnd(12)};
		do goto target: mypoint speed:vel_proteina;
	}

}
species Zinc skills:[moving] parent: biomass
{
	
	aspect default
	{
		if(typebio="Tierra"){
		draw circle(1) color:(cantidad>0)?#gray:#blue border: #darkgreen;
			//draw "Z"color:#black size:1;
			}
	}
	reflex goto when: typebio="Tierra"
	{
		//mypoint<-{rnd(12),rnd(12),rnd(12)};
		do goto target: mypoint speed:vel_proteina;
	}

}
//para la pantalla correr experimento y parametros
experiment name type: gui {
	/*General */
parameter "Simulacion" var:trace <- false;
/*Ambiente */
parameter "Cantidad_Plantas"var:cant_plant<-1;
/*Planta */
parameter "Tipo Planta" var:tipoplant<-"Maiz";
parameter "Edad"var:edad<-1.0;
parameter "Tiempo de Vida" var:timelive<-0.0;
parameter "Tiempo Florecimiento" var:timeflor<-0.0;
parameter "Temp max" var:tempmax<-0.0;
parameter "Temp min" var:tempmin<-0.0;
/*Necesidades Nutricionales */
parameter "Nitrógeno(Planta)" var:cant_Nitrogeno_plant;
parameter "Fósforo(Planta)"   var:cant_Fosforo_plant;
parameter "Potasio(Planta)"   var:cant_Potasio_plant;
parameter "Magnesio(Planta)"  var:cant_Magnesio_plant;
parameter "Calcio(Planta)"    var:cant_Calcio_plant;
parameter "Asufre(Planta)"    var:cant_Azufre_plant;
parameter "Boro(Planta)"      var:cant_Boro_plant;
parameter "Cobre(Planta)"     var:cant_Cobre_plant;
parameter "Hierro(Planta)"    var:cant_Hierro_plant;
parameter "Manganeso(Planta)" var:cant_Manganeso_plant;
parameter "Molibdeno(Planta)" var:cant_Molibdeno_plant;
parameter "Zinc(Planta)"      var:cant_Zinc_plant;
/*Biomasa */
parameter "Tipo BioMass"      var:typebio<-"Tierra";
parameter "Humedad"           var:humedabio<-20;
parameter "Nitrógeno"         var:cant_Nitrogeno<-1;
parameter "Fósforo"           var:cant_Fosforo<-1;
parameter "Potasio"           var:cant_Potasio<-1;
parameter "Magnesio"          var:cant_Magnesio<-1;
parameter "Calcio"            var:cant_Calcio<-1;
parameter "Asufre"            var:cant_Azufre<-1;
parameter "Boro"              var:cant_Boro<-1;
parameter "Cobre"             var:cant_Cobre<-1;
parameter "Hierro"            var:cant_Hierro<-1;
parameter "Manganeso"         var:cant_Manganeso<-1;
parameter "Molibdeno"         var:cant_Molibdeno<-1;
parameter "Zinc"              var:cant_Zinc<-1;

	output {

	 display map type: opengl background:rgb(204, 255, 255){ 
	
	//species ramas;
	species biomass aspect: default;
	species Nitrogeno;
	species Fosforo aspect: default;
	species Potasio;
	species Calcio aspect: default;
	species Magnesio aspect: default;
	species Azufre;
	species Boro aspect: default;
	species Cobre aspect: default;
	species Hierro aspect:default;
	species Manganeso;
	species Molibdeno aspect: default;
	species Zinc aspect: default;
	species planta aspect:default;
	 }
	}
}
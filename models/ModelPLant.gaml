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
point mypoint;
int cantidad<-rnd(1,11);
float size <- 8.0;
float cont<-0.0;
bool stop<-false;
int cant_potasio<-10;
	float level_step <- 0.8;
	float length_max <- 100.0;
	
	//*******************************************************************************************************
	int number_of_agents parameter: 'velocidad de crecimiento' min: 1 <- 250 step:10 category: 'Planta'; //asignas a una categoria de parametros
	string tipoplant<-"Maiz" among:["Maiz","Lechuga", "Tomate"] category:'Planta';
	int cuenta<-10 category:'Biomasa';
	int cant_magnesio<-20 category:'Biomasa';
	int cant_calcio<-20 category:'Biomasa';
	int cant_plant<-5 category:'Ambiente';
		bool trace <-false;
		string typebio<-"Tierra" among:[ "Liquida", "Tierra"] category:'Biomasa';
	int tempmin<-(20) category: 'Ambiente';
	int tempmax<-30 category: 'Ambiente';
	int humedad<-20 category: 'Ambiente';
	int edad<-1 category:'Planta';
	int humedabio<-20 category:'Biomasa';
	int luminosidad<-1 category:'Ambiente';
	int ph parameter:'PH'min: 0 max: 14<-7  category:'Biomasa';
	//string agentAspect <- "Potasio" among:["Calcio","Magnesio","Nitrogeno", "Sulduro","Potasio"] category: 'Biomasa';
	int potacio<-20;
	//*******************************************************************************************************
	//inicializas los agentes
	init
	{  
		
		
	create Potasio number:cant_potasio
	{
		location<-{rnd(2,90),rnd(80,100),5};
		mypoint<-{50,75,5};
	}
	create Magnesio number:cant_magnesio
	{
		location<-{rnd(2,90),rnd(80,100),6};
		mypoint<-{50,75,5};
	}
	create Calcio number:cant_calcio
	{
		location<-{rnd(2,90),rnd(80,100),7};
		mypoint<-{50,75,5};
	}
	create ramas number:potacio
	{
		location<-{50,rnd(60,90),5};
	}
	create planta number:cant_plant
		{
			
			location<-{50,75,5};
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
species Potasio skills:[moving] parent: biomass
{
	
	aspect default
	{
		if(typebio="Tierra"){
		draw circle(1) color:(cantidad>0)?#green:#blue border: #darkgreen;
			draw "P"color:#black size:1;
			}
	}
	reflex goto when: typebio="Tierra"
	{
		//mypoint<-{rnd(12),rnd(12),rnd(12)};
		do goto target: mypoint speed:0.005;
	}

}
species Calcio skills:[moving]parent: biomass
{   geometry a;
	aspect default
	{if(typebio="Tierra"){
			draw circle(1) color:(cantidad>0)?#yellow:#blue border: #black;
			draw "C"color:#black size:1;	
	}}
	reflex goto when: typebio="Tierra"
	{
		//mypoint<-{rnd(12),rnd(12),rnd(12)};
		do goto target: mypoint speed:0.005;
	}
	
}
species Magnesio skills:[moving] parent: biomass
{ 
	aspect default
	{	if(typebio="Tierra"){
		draw circle(1) color:(cantidad>0)?#brown:#blue border: #black;
			draw "M"color:#black size:1;	
		}	
	}
	reflex goto when: typebio="Tierra"
	{
		//mypoint<-{rnd(12),rnd(12),rnd(12)};
		do goto target: mypoint speed:0.005;
	}
	
}
//para la pantalla correr experimento y parametros
experiment name type: gui {
parameter "Simulacion" var:trace <- false;
parameter "Temp max" var:tempmax<-30;
parameter "Temp min" var:tempmin<-10;
//parameter "Biomasa" var:agentAspect <- "Potasio";
parameter "Tipo BioMass" var:typebio<-"Tierra";
parameter"Tipo Planta" var:tipoplant<-"Maiz";
parameter "Dias"var:edad<-1;
parameter "Potacio" var:cuenta;
parameter "Magnesio" var:cant_magnesio;
parameter "Calcio" var:cant_calcio;
parameter "Luminocidad"var:luminosidad<-1;
parameter"Humedad"var:humedad<-2;
parameter"Humedad"var:humedabio<-20;
parameter"Cantidad_Plantas"var:cant_plant<-1;

	output {

	 display map type: opengl background:rgb(204, 255, 255){ 
	
	//species ramas;
	species biomass aspect: default;
	species Potasio ;
	species Calcio aspect: default;
	species Magnesio aspect: default;
	species planta aspect:default;
	
	 }
	}
}
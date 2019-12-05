/***
* Name: ModelPLant
* Author: OscarHC
* Description: 
* Tags: Tag1, Tag2, TagN
***/

model ModelPLant
//variables globales
global
{ 	float level_step <- 0.8;
	float length_max <- 100.0;
	int number_of_agents parameter: 'velocidad de crecimiento' min: 1 <- 250 step:10 category: 'Planta'; //asignas a una categoria de parametros
	int nd_bio<-10 category:'Biomasa';
		bool trace <-false;
	int tempmin<-(20);
	int tempmax<-30;
	int humedad<-20;
	int tiemp<-1;
	int edad<-1 category:'Planta';
	int luminosidad<-1;
	int ph parameter:'PH'min: 0 max: 14<-7  category:'Biomasa';
	string agentAspect <- "Potasio" among:["Calcio","Magnesio","Nitrogeno", "Sulduro","Potasio"] category: 'Biomasa';
	int potacio<-20;
	//inicializas los agentes
	init
	{  
		create planta
		{
			location<-{50,70,5};
		}
		create biomass
		{
			location<-{50,100,5};
		}
		do skycolor;
	create biomassmin number:nd_bio
	{
		location<-{rnd(2,90),rnd(80,100),5};
	}
	create ramas number:nd_bio
	{
		location<-{50,rnd(60,90),5};
	}
	}
	//este no se para que sirve
	action skycolor
	{
		color<-°blue;
	}
}
//agente planta
species planta
{
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
		draw rectangle(1,30)color:#green;
		
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
	aspect default
	{
		draw rectangle(100,50) color:rgb(120,60,0);
	}
}
//particolas para la biomasa
species biomassmin
{int cantidad<-rnd(1,10);
	aspect default
	{
		if(agentAspect="potacio")
		{
			//aqui se programa______________________________________________________
		}
		draw circle(4) color:(cantidad>0)?#yellow:#gray border: #black;
		
	}
}
//para la pantalla correr experimento y parametros
experiment name type: gui {
parameter "Simulacion" var:trace <- false;
parameter "Temp max" var:tempmax<-30;
parameter "Temp min" var:tempmin<-10;
parameter "Biomasa" var:agentAspect <- "Planta";
parameter"tiempo"var:tiemp<-1;
parameter "Dias"var:edad<-1;
parameter "" var:nd_bio<-10;
parameter "Luminocidad"var:luminosidad<-1;
parameter"Humedad"var:humedad<-2;
	output {

	 display map type: opengl background:rgb(204, 255, 255){ 
	
	species ramas;
	species biomass;
	species planta;
	species biomassmin;
	 }
	}
}
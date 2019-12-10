/***
* Name: Emulation
* Author: Lili
* Description: 
* Tags: Tag1, Tag2, TagN
***/

model Emulation

global
{ 	//variables
	point mypoint;
	int cant_potasio<-10;
	int cantidad<-rnd(1,11);
	float size <- 8.0;
	float cont<-0.0;
	bool stop<-false;
	
	float level_step <- 0.8;
	float length_max <- 100.0;
	
	
	
	
	int 	number_of_agents parameter: 'velocidad de crecimiento' min: 1 <- 250 step:10 category: 'Planta'; //asignas a una categoria de parametros
	string 	tipoplant<-"Maiz" among:["Maiz","Lechuga", "Tomate"] category:'Planta';
	
	/* Planta */
	float edad			<-1.0 category:'Planta';
	float life_time		<-0.0 category:'Planta';
	float flourish_time	<-0.0 category:'Planta';
	float plant_min_temp<-0.0 category:'Planta';
	float plant_max_temp<-0.0 category:'Planta';
	int   plant_ph parameter:'PH'min: 0 max: 14 <- 7  category:'Planta';
	
	/* Necesidades nutricionales */
	int plant_potasio	<-10 category:'Necesidades nutricionales';
	int plant_magnesio	<-20 category:'Necesidades nutricionales';
	int plant_calcio	<-20 category:'Necesidades nutricionales';
	int plant_nitrogeno	<-20 category:'Necesidades nutricionales';
	int plant_fosforo	<-20 category:'Necesidades nutricionales';
	int plant_azufre	<-20 category:'Necesidades nutricionales';
	int plant_boro		<-20 category:'Necesidades nutricionales';
	int plant_cobre		<-20 category:'Necesidades nutricionales';
	int plant_hierro	<-20 category:'Necesidades nutricionales';
	int plant_manganeso	<-20 category:'Necesidades nutricionales';
	int plant_molibdeno	<-20 category:'Necesidades nutricionales';
	int plant_zinc		<-20 category:'Necesidades nutricionales';
	
	
	/* Biomasa */
	int cuenta			<-10 category:'Biomasa';
	int cant_magnesio	<-20 category:'Biomasa';
	int cant_calcio		<-20 category:'Biomasa';
	int cant_nitrogeno	<-20 category:'Biomasa';
	int cant_fosforo	<-20 category:'Biomasa';
	int cant_azufre		<-20 category:'Biomasa';
	int cant_boro		<-20 category:'Biomasa';
	int cant_cobre		<-20 category:'Biomasa';
	int cant_hierro		<-20 category:'Biomasa';
	int cant_manganeso	<-20 category:'Biomasa';
	int cant_molibdeno	<-20 category:'Biomasa';
	int cant_zinc		<-20 category:'Biomasa';
	int potacio	<-20;
	

	
	bool trace <-false;
	string typebio<-"Tierra" among:[ "Liquida", "Tierra"] category:'Biomasa';
	int humedabio<-20 category:'Biomasa';
	int ph parameter:'PH'min: 0 max: 14<-7  category:'Biomasa';
	
	
	/* Ambiente */
	int cant_plant<-5 category:'Ambiente';
	/* Comentados porque no son necesarios para la emulacion */
	//int tempmin<-(20) category: 'Ambiente';
	//int tempmax<-30 category: 'Ambiente';
	//int humedad<-20 category: 'Ambiente';
	//int luminosidad<-1 category:'Ambiente'; 
	
	
	//string agentAspect <- "Potasio" among:["Calcio","Magnesio","Nitrogeno", "Sulduro","Potasio"] category: 'Biomasa';

	
	
	/*Database connection ============================================================================*/
	string server 	<-'' category:'Base de datos';
	string dbType 	<-'MySQL' among:[ "MySQL", "Postgres","SQLite","SQLServer"] category:'Base de datos';
	string database <-'' category:'Base de datos';
	string port 	<-'' category:'Base de datos';
	string user 	<-'' category:'Base de datos';
	string password <-'' category:'Base de datos';
	//map<string,string> PARAMS <- ['host'::'localhost','dbtype'::'MySQL','database'::'simplant',
	//			                  'port'::'3306','user'::'root','passwd'::''];
    map<string,string> PARAMS <- ['host'::server,'dbtype'::dbType,'database'::database,
				                  'port'::port,'user'::user,'passwd'::password];
	string query <- 'select distinct 
						temp.nTemperature 	nTemperature,
						flow.nflow 			nFlow,
				        hum.nmeasure 		nHumidity,
				        light.nmeasure 		nLight
				from 		simplant.environment 	env
				inner join 	simplant.sensor 		sen on env.idenvironment = sen.idenvironment
				inner join 	(select idsensor, nTemperature  from simplant.temperature order by dMeasure desc limit 1) as temp on temp.idsensor = sen.idsensor
				left join 	(select idsensor, nflow  from simplant.airflow order by dMeasure desc limit 1) as flow on flow.idsensor = sen.idsensor
				left join 	(select idsensor, nmeasure  from simplant.humidity order by dMeasure desc limit 1) as hum on hum.idsensor = sen.idsensor
				left join 	(select idsensor, nmeasure  from simplant.light order by dMeasure desc limit 1) as light on light.idsensor = sen.idsensor';
	/* ============================================================================================== */
	
	/* ============= Environment ============== */
	float temp_env;
	float airFlow_env;
	float humidity_env;
	float light_env;
	float ph_env;
	
	
	//inicializas los agentes
	init
	{  
		create environment number:1;
		
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

/* 
	create biomass
		{
			location<-{50,100,4};
			aa<-rectangle(100,50);
            liq<-rgb(120,60,0);
		}
*/
	//importar imagenes 
	
	//image_file mature_corn_shape<-file("..images/mature_corn.png");
	}
	
	
}

/* ============= Environment =============*/
species DB_Accesor skills: [SQLSKILL];

species environment{
	float temperature;
	float humidity;
	float airFlow;
	float light;
	
	reflex update
	{
		PARAMS <- ['host'::server,'dbtype'::dbType,'database'::database,
				                  'port'::port,'user'::user,'passwd'::password];
		create DB_Accesor{
			if(testConnection(params:PARAMS))
			{
				create environment from: list(select(params:PARAMS, select:query)) with:[temperature::"nTemperature",humidity::"nHumidity",airFlow::"nFlow",light::"nLight"];
		
				loop a_temp_var over: environment { 
				     temp_env <- a_temp_var.temperature;
				     airFlow_env <- a_temp_var.airFlow;
					 humidity_env <- a_temp_var.humidity;
					 light_env <- a_temp_var.light;
				}
				
			}
			else{write "No connection";}
			
		}
	}
	
}
/* ===========================================*/


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
/* 
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
 */

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
experiment emulation type: gui {
	/* ================ Parameters ================= */
	// Ambiente
	parameter"Cantidad_Plantas"var:cant_plant<-1;
	
	/*================= Planta ======================= */
	parameter"Tipo Planta" 			var:tipoplant<-"Maiz";
	
	parameter "Edad"				var:edad;
	parameter "PH"					var:plant_ph 	<-7;
	parameter "Tiempo de vida"		var:life_time;
	parameter "Tiempo florecimiento"var:flourish_time;
	parameter "Temperatura mínima"	var:plant_min_temp;
	parameter "Temperatura máxima"	var:plant_max_temp;
	
	/*========== Necesidades nutricionales ============ */
	parameter "Nitrógeno(Planta)" 		var:plant_nitrogeno<-0;
	parameter "Fósforo(Planta)" 		var:plant_fosforo;
	parameter "Potasio(Planta)" 		var:plant_potasio;
	parameter "Calcio(Planta)" 			var:plant_calcio;
	parameter "Magnesio(Planta)" 		var:plant_magnesio;
	parameter "Azufre(Planta)" 			var:plant_azufre;
	parameter "Boro(Planta)" 			var:plant_boro;
	parameter "Cobre(Planta)" 			var:plant_cobre;
	parameter "Hierro(Planta)" 			var:plant_hierro;
	parameter "Manganeso(Planta)" 		var:plant_manganeso;
	parameter "Molibdeno(Planta)" 		var:plant_molibdeno;
	parameter "Zinc(Planta)" 			var:plant_zinc;
	
	/*================ Biomasa ======================= */
	parameter "Tipo BioMass" 	var:typebio<-"Tierra";
	parameter "Humedad"			var:humedabio<-20;
	parameter "Nitrógeno" 		var:cant_nitrogeno;
	parameter "Fósforo" 		var:cant_fosforo;
	parameter "Potasio" 		var:cuenta;
	parameter "Calcio" 			var:cant_calcio;
	parameter "Magnesio" 		var:cant_magnesio;
	parameter "Azufre" 			var:cant_azufre;
	parameter "Boro" 			var:cant_boro;
	parameter "Cobre" 			var:cant_cobre;
	parameter "Hierro" 			var:cant_hierro;
	parameter "Manganeso" 		var:cant_manganeso;
	parameter "Molibdeno" 		var:cant_molibdeno;
	parameter "Zinc" 			var:cant_zinc;
	
	
	/* ================ Database ====================== */
	parameter "Servidor" 		var:server;
	parameter "Tipo" 			var:dbType;
	parameter "Base de datos" 	var:database;
	parameter "Puerto" 			var:port;
	parameter "Usuario" 		var:user;
	parameter "Contraseña" 		var:password;
	
	
	permanent {
		display Comparison background: #white {
			chart "Temperature Changes" type: series style: spline {
				data "Env temp" value: temp_env color: #red;
			}
		}
	}


	output {
	 	display map type: opengl background:rgb(204, 255, 255){ 
	
		//species ramas;
		//species biomass aspect: default;
		species Potasio ;
		species Calcio aspect: default;
		species Magnesio aspect: default;
		species planta aspect:default;
	
	 }

	 
	 /* ============== Monitors ============== */
		monitor Temperatura value: temp_env 	refresh: every(3#cycle);
		monitor Flujo_Aire 	value: airFlow_env 	refresh: every(3#cycle);
		monitor Humedad 	value: humidity_env refresh: every(3#cycle);
		monitor Luminosidad value: light_env 	refresh: every(3#cycle);
	}
}

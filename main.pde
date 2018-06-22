// Import Libraries
import processing.opengl.*;
import org.openkinect.processing.*;

Kinect kinect = new Kinect(this);

Landscape[] layers = new Landscape[5];
Snow[] snow_layers = new Snow[7];
Clouds[] cloud_layers = new Clouds[3];

// Variables for managing the state of the project
String projectState = "homescreen";
String projectPreviousState;

// Variables for Kinect Hand Detection
int initiateHandClickTime = 2000;
int lastTimeLeftHandMoved;
int lastTimeRightHandMoved;
int lastTimeHandMoved;
boolean handOverTankWars = false;
boolean handOverPong = false;
boolean handOverPong2 = false;
boolean handOverDrawing = false;
boolean handOverCloseButton = false;
boolean handOverGamesIcon = false;
boolean handOverForwardButton = false;
boolean handOverBackButton = false;
boolean handOverPingPong = false;

// Image declarations for navigation buttons
PImage bg;
PImage closeButtonImg;
PImage gamesImg;
PImage forwardButtonImg;
PImage backButtonImg;

// Font and size declaration being used in the code
PFont font;
int headingFontSize = 32;
int subheadingFontSize = 24;
int bodyFontSize = 18;
int weatherFontSize = 14;
int newsBodySize = 12;

// Variables for weather
boolean weatherLoaded = false;
XML weatherXml;
PImage cloudImg, rainImg, sunImg, snowImg;
PImage sunriseImg, sunsetImg;
String distanceUnit, pressureUnit, speedUnit, temperatureUnit;
String city, country, region, countrycode;
String windChill, windDirection, windSpeed;
float humidity, pressure, rising, visibility;
int sunRadius = 100;
String sunrise, sunset;

// Varaiables for forecast
int forecastCount = 7;
int[] code = new int[forecastCount + 1];
String[] day = new String[forecastCount + 1];
String[] high = new String[forecastCount + 1];
String[] low = new String[forecastCount + 1];
String[] date = new String[forecastCount + 1];
String[] text = new String[forecastCount + 1];
String currentDate, currentTemp, currentText;
int currentCode;

// Variables for Rain
int rainNum = 100;
ArrayList rain = new ArrayList();
ArrayList splash = new ArrayList();
float current;
float reseed = random(0,.2);

// Variables for Snow
int quantity = 300;
float [] xPosition = new float[quantity];
float [] yPosition = new float[quantity];
int [] flakeSize = new int[quantity];
int [] direction = new int[quantity];
int minFlakeSize = 1;
int maxFlakeSize = 5;

// Variables for news
String apiKey;
JSONArray articles;
int numArticles;
String[] newsImageUrl = new String[20];
String[] newsHeadline = new String[20];
String[] newsDescription = new String[20];
String[] newsDescriptionFirstLine = new String[20];
String[] newsDescriptionSecondLine = new String[20];
String[] newsArticleUrl = new String[20];
String[] newsAuthor = new String[20];
PImage[] newsImage = new PImage[20];
PImage imgNotFound;

// Variables for Screensaver 
float rot = 0;
float radius = 2;
int initiateScreenSaverTime = 120000;
int lastTimeMouseMoved;
int screenSaverRunningTime;

// Variables for drawing application
PImage drawImg;
ArrayList<RandomArt> randomArt;
float stepSize;  // resolution, the lower the finer
float noiseScale;   // play with this value
float noiseStrength;// play with this value  
int maxAgents;  // maximum amount of agents in the screen
int liveAgents = 0;  // how many agents are alive at the moment

// variables for tankwars game
PImage tankwarsImg;
PImage upImg, downImg, leftImg, rightImg, launchImg;
float[] tankwarsGroundLevel;  // Y coordinate of the ground for each X coordinate
float tank1X, tank1Y, tank2X, tank2Y; // Positions of the two tanks
float tankDiameter = 50;  // Diameter of the tanks
float tankHeight = tankDiameter; // Height of the tanks
float player1Height, player2Height;
float cannonLength = tankDiameter;  // How long the cannon on each tank extends
float gravity = 0.05;      // Strength of gravity
float tankwarsWindSpeed; //
int playerHasWon = 0; // 1 if player 1 wins, 2 if player 2 wins, 0 if game in progress
boolean player1Turn = true;  // true if it's player 1's turn; false otherwise
float tank1CannonAngle = PI/2, tank2CannonAngle = PI/2; // Direction the tank cannons are pointing
float tank1CannonStrength = 3, tank2CannonStrength = 3; // Strength of intended projectile launch
boolean projectileInMotion = false;
float projectilePositionX, projectilePositionY;
float projectileVelocityX, projectileVelocityY;
float tankwarsGroundLevelDistX, tankwarsGroundLevelDistY, tankwarsDistance; // Variables to calculate projectile collision with tank


// Variables for stars in the sky
float[] starX = new float[200]; // Array for X Position of the background stars
float[]starY = new float[200]; // Array for Y Position of the background stars
float[] starSize = new float[200]; // Array for size of the stars

// Variables for pong game
PImage pongImg;
boolean gameStart = false;
float pong_x = 150;
float pong_y = 150;
float pong_speedX = random(3, 5);
float pong_speedY = random(3, 5);
int pong_leftColor = 128;
int pong_rightColor = 128;
int pong_diam;
int pong_rectSize = 150;
float pong_diamHit;

// Variables for PingPong Table
PImage pingpongIconImg;

void setup() {
    fullScreen(2);
    smooth();
    switch(projectState) { // Depending on the state of the project setup initialises different portions of the code
    case "homescreen":
      loadKinect();
      rectMode(CORNER);
      background(150,200,215); 
      city = "London";
      temperatureUnit = "C";
      font = createFont("HelveticaNeue", 32);
      textFont(font);
      imgNotFound = loadImage("images/imagenotfound.png");
      imgNotFound.resize(80,60); 
      loadWeatherData();
      loadHomeScreenImages();
      loadCloseButton();
      loadNewsData();
      loadStars();
      loadGrass();
      loadRain();
      loadClouds();
      loadSnow();
    break;
    case "gamescreen":
      loadKinect();
      rectMode(CORNER);
      background(150,200,215);  
      city = "London";
      temperatureUnit = "C";
      font = createFont("HelveticaNeue", 32);
      textFont(font);
      loadWeatherData();
      loadGameScreenImages();
      loadCloseButton();
      loadNavigationButtons();
      loadStars();
      loadGrass();
      loadRain();
      loadClouds();
      loadSnow();
    break;
    case "gamescreen2":
      loadKinect();
      rectMode(CORNER);
      background(150,200,215);  
      city = "London";
      temperatureUnit = "C";
      font = createFont("HelveticaNeue", 32);
      textFont(font);
      loadWeatherData();
      loadGameScreenImages();
      loadCloseButton();
      loadNavigationButtons();
      loadStars();
      loadGrass();
      loadRain();
      loadClouds();
      loadSnow();
    break;
    case "art":
      loadKinect();
      smooth();
      background(255);
      frameRate(300);
      strokeWeight(1);
      loadRandomArt();
      loadCloseButton();
    break;
    case "tankwars":
      loadKinect();
      frameRate(10000);
      loadGround();
      loadControlImages();
      loadStars();
      loadTanks();
      initializeWindSpeed();
      loadCloseButton();
    break;
    case "pong":
      loadKinect();
      background(255);
      noStroke();
      smooth();
      loadCloseButton();
      ellipseMode(CENTER);
    break;
    case "pong2":
      loadKinect();
      background(80);
      frameRate(30);
      noStroke();
      smooth();
      loadCloseButton();
      ellipseMode(CENTER);
    break;
    case "pingpong":
      loadKinect();
      noStroke();
      smooth();
      loadCloseButton();
      loadPingPongTable();
      ellipseMode(CENTER);
    break;
    case "screensaver":
      screenSaverRunningTime = millis();
      loadKinect();
      rot = 0;
      radius = 2;
      background(255);
      frameRate(300);
      noStroke();
    break;
    default:
      projectState = "homescreen";
    break;
  } 
}

void draw() {
  switch(projectState) {
    case "homescreen":
      if (currentCode >= 1 && currentCode <= 4 || currentCode >= 6 && currentCode <= 12 || currentCode >= 37 && currentCode <= 40) {
        background(44,56,69);
        drawClouds();
        drawGrass();
        drawRain();
      }
      if (currentCode >= 13 && currentCode <= 25 || currentCode == 5) {
        background(180,180,180);
        drawClouds();
        drawSnow();
      }
     if (currentCode >= 26 && currentCode <= 30) {
        if( hour() + 48 < int(sunset.charAt(0))) {
          background(144,201,221);
          drawSun();
          drawClouds();
          drawGrass();
        } else {
           background(0,20,115);
           drawMoon();
           drawClouds();
           drawStars();
           drawGrass(); 
        }
      }
      if (currentCode >= 31 && currentCode <= 36) {
        if( hour() + 48 < int(sunset.charAt(0))) {
          background(150,200,215);
          drawSun();
          drawGrass(); 
      } else {
          background(0,20,115);
          drawMoon();
          drawStars();
          drawGrass(); 
       }
      }
      displayWeatherData(); 
      displayNewsData();
      displayGames();
      hands();
      handOver(handAvgX, handAvgY);
      handSelectGames();
    break;
    case "gamescreen":
      if (currentCode >= 1 && currentCode <= 4 || currentCode >= 6 && currentCode <= 12 || currentCode >= 37 && currentCode <= 40) {
        background(44,56,69);
        drawClouds();
        drawGrass();
        drawRain();
      }
      if (currentCode >= 13 && currentCode <= 25 || currentCode == 5) {
        background(180,180,180);
        drawClouds();
        drawSnow();
      }
      if (currentCode >= 26 && currentCode <= 30) {
        if( hour() + 48 < int(sunset.charAt(0))) {
          background(144,201,221);
          drawSun();
          drawClouds();
          drawGrass();
        } else {
          background(0,20,115);
           drawMoon();
           drawClouds();
           drawStars();
          drawGrass(); 
        }
      }
      if (currentCode >= 31 && currentCode <= 36) {
        if( hour() + 48 < int(sunset.charAt(0))) {
          background(150,200,215);
          drawSun();
          drawGrass(); 
      } else {
          background(0,20,115);
          drawMoon();
          drawStars();
          drawGrass(); 
        }   
      }
      displayGamesFolder();
      closeButton(width-50,0);
      drawForwardButton(width-175,height-75);
      hands();
      handOver(handAvgX, handAvgY);
      handSelectGames();
    break;
    case "gamescreen2":
      if (currentCode >= 1 && currentCode <= 4 || currentCode >= 6 && currentCode <= 12 || currentCode >= 37 && currentCode <= 40) {
        background(44,56,69);
        drawClouds();
        drawGrass();
        drawRain();
      }
      if (currentCode >= 13 && currentCode <= 25 || currentCode == 5) {
        background(180,180,180);
        drawClouds();
        drawSnow();
      }
      if (currentCode >= 26 && currentCode <= 30) {
        if( hour() + 48 < int(sunset.charAt(0))) {
          background(144,201,221);
          drawClouds();
          drawGrass();
        } else {
           background(0,20,115);
           drawMoon();
           drawClouds();
           drawStars();
           drawGrass(); 
        }
      }
      if (currentCode >= 31 && currentCode <= 36) {
        if( hour() + 48 < int(sunset.charAt(0))) {
          background(150,200,215);
          drawSun();
          drawGrass(); 
      } else {
          background(0,20,115);
          drawMoon();
          drawStars();
          drawGrass(); 
        }   
      }
      displayGamesFolder2();
      closeButton(width-50,0);
      drawBackButton(-75,height-75);
      hands();
      handOver(handAvgX, handAvgY);
      handSelectGames();
    break;    
    case "screensaver":
      drawScreenSaver();
      hands();
      handMoved();
    break;    
    case "art":
      hands();
      closeButton(width-50,0);
      handOver(handAvgX, handAvgY);
      drawRandomArt();
      addArtAgent();
      handSelectCloseButton();
    break;
    case "tankwars":
      background(0,20,115);
      drawStars();
      drawMoon();
      drawGround();
      drawControls();
      drawTanks();
      closeButton(width-50,0);
      hands();
      handOverControls();
      updateTankWarParameters();
      drawProjectile();
      drawStatus();
      updateProjectilePositionAndCheckCollision();
      handSelectCloseButton();
    break;
    case "pong":
      pongGame();
      closeButton(0,0);
      hands();
      handOver(handAvgX, handAvgY);
      handSelectGames();
      startGame();
      handSelectCloseButton();
    break;
    case "pong2":
      pong2Game();
      closeButton(width/2 - 25,0);
      handOver(leftAvgX, leftAvgY);
      handOver(rightAvgX, rightAvgY);
      handSelectCloseButton();
    break;
    case "pingpong":
      drawPingPongTable();
      hands();
      handOver(handAvgX, handAvgY);
      closeButton(width-50,height - 50);
      handSelectCloseButton();
    break;
    default:
      reset();
    break;    
  }
 if(projectState != "screensaver") {
    if(millis() - initiateScreenSaverTime > lastTimeHandMoved ) {
      projectPreviousState = projectState;
      projectState = "screensaver";
      reset();
    }
  }
}

void loadHomeScreenImages() {
  cloudImg = loadImage("images/cloudy.png");
  cloudImg.resize(50, 50);

  rainImg = loadImage("images/lightRain.png");
  rainImg.resize(50, 50);

  sunImg = loadImage("images/sunny.png");
  sunImg.resize(50, 50);

  snowImg = loadImage("images/lightSnow.png");
  snowImg.resize(50, 50);

  sunriseImg = loadImage("images/sunriseTime.png");
  sunriseImg.resize(50, 50);

  sunsetImg = loadImage("images/sunsetTime.png");
  sunsetImg.resize(50, 50);
    
  gamesImg = loadImage("images/games.png");
  gamesImg.resize(500,100);
  gamesImg.filter(GRAY);
  
}

void loadGameScreenImages() {
  tankwarsImg = loadImage("images/tankwars.png");
  tankwarsImg.resize(160,120);
  tankwarsImg.filter(GRAY);
  
  pongImg = loadImage("images/pong.jpg");
  pongImg.resize(160,120);
  pongImg.filter(GRAY);
  
  pong2Img = loadImage("images/pong.jpg");
  pong2Img.resize(160,120);
  pong2Img.filter(GRAY);
  
  drawImg = loadImage("images/drawlogo.jpg");
  drawImg.resize(160,120);
  drawImg.filter(GRAY);
  drawImg.filter(INVERT);  
  
  pingpongIconImg = loadImage("images/pingpong.png");
  pingpongIconImg.resize(150,150);
  pingpongIconImg.filter(GRAY);
  pingpongIconImg.filter(INVERT);  
}

void loadCloseButton() {
  closeButtonImg = loadImage("images/close.png");
  closeButtonImg.resize(50,50);
}

void loadNavigationButtons() {
  forwardButtonImg = loadImage("images/forward.png");
  forwardButtonImg.resize(250,50);
  forwardButtonImg.filter(GRAY);
   
  backButtonImg = loadImage("images/back.png");
  backButtonImg.resize(250,50);
  backButtonImg.filter(GRAY);
}


void loadWeatherData() {
  try {
    // The URL for the XML document
    String locationUrl = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20u%3D%27"+temperatureUnit.toLowerCase()+"%27%20and%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22"+city.toLowerCase()+"%22)&format=xml&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys";
    // Load the XML document
    weatherXml = loadXML(locationUrl);
    // Parse the weather data
    parseWeatherData(weatherXml);
    // Indicate that the weather has successfully loaded
    weatherLoaded = true;
  }
  catch(Exception exception) {
    // Any errors will jump to this point.
    //println("Encountered an error loading the weather:");
    exception.printStackTrace();
  }
}

void parseWeatherData(XML weatherXml) {
  // Unit data
  speedUnit = weatherXml.getChildren()[0].getChildren()[0].getChildren()[0].getString("speed");
  distanceUnit = weatherXml.getChildren()[0].getChildren()[0].getChildren()[0].getString("distance");
  pressureUnit = weatherXml.getChildren()[0].getChildren()[0].getChildren()[0].getString("pressure");
  temperatureUnit = weatherXml.getChildren()[0].getChildren()[0].getChildren()[0].getString("temperature");

  //location data
  city = weatherXml.getChildren()[0].getChildren()[0].getChildren()[7].getString("city");
  country = weatherXml.getChildren()[0].getChildren()[0].getChildren()[7].getString("country");
  region = weatherXml.getChildren()[0].getChildren()[0].getChildren()[7].getString("region");

  // wind conditions
  windChill = weatherXml.getChildren()[0].getChildren()[0].getChildren()[8].getString("chill");
  windDirection = weatherXml.getChildren()[0].getChildren()[0].getChildren()[8].getString("direction");
  windSpeed = weatherXml.getChildren()[0].getChildren()[0].getChildren()[8].getString("speed");

  // atmosphere conditions
  humidity = weatherXml.getChildren()[0].getChildren()[0].getChildren()[9].getFloat("humidity");
  pressure = weatherXml.getChildren()[0].getChildren()[0].getChildren()[9].getFloat("pressure");
  rising = weatherXml.getChildren()[0].getChildren()[0].getChildren()[9].getFloat("rising");
  visibility = weatherXml.getChildren()[0].getChildren()[0].getChildren()[9].getFloat("visibility");

  //sun data
  sunrise = weatherXml.getChildren()[0].getChildren()[0].getChildren()[10].getString("sunrise");
  sunset = weatherXml.getChildren()[0].getChildren()[0].getChildren()[10].getString("sunset");

  //current weather
  currentDate = weatherXml.getChildren()[0].getChildren()[0].getChildren()[12].getChildren()[5].getString("date");
  //currentCode = weatherXml.getChildren()[0].getChildren()[0].getChildren()[12].getChildren()[5].getInt("code");
  currentTemp = weatherXml.getChildren()[0].getChildren()[0].getChildren()[12].getChildren()[5].getString("temp");
  currentText = weatherXml.getChildren()[0].getChildren()[0].getChildren()[12].getChildren()[5].getString("text");
  currentCode = 38;
  
  for (int i = 0; i < forecastCount; i++) {
    code[i] = weatherXml.getChildren()[0].getChildren()[0].getChildren()[12].getChildren()[7+i].getInt("code");
    day[i] = weatherXml.getChildren()[0].getChildren()[0].getChildren()[12].getChildren()[7+i].getString("day");
    high[i] = weatherXml.getChildren()[0].getChildren()[0].getChildren()[12].getChildren()[7+i].getString("high");
    low[i] = weatherXml.getChildren()[0].getChildren()[0].getChildren()[12].getChildren()[7+i].getString("low");
    date[i] = weatherXml.getChildren()[0].getChildren()[0].getChildren()[12].getChildren()[7+i].getString("date");
    text[i] = weatherXml.getChildren()[0].getChildren()[0].getChildren()[12].getChildren()[7+i].getString("text");
  }
  displayWeatherData();
}

void displayWeatherData() {
  noStroke();
  fill(125, 125, 125, 50);
  rect(width/20, height/10, width/4, height/3);
  fill(255);
  textSize(headingFontSize);
  textAlign(CENTER);
  text(city, width/20 + width/8, height/8);
  textSize(subheadingFontSize);
  text(region+","+country, width/20 + width/8, height/6.5);
  // To append 0 for minute
  if (minute() < 10) {
    text(day()+"/"+month()+"/"+year()+" \t "+hour()+":0"+minute(), width/20 + width/8, height/5.5);
  } else {
    text(day()+"/"+month()+"/"+year()+" \t "+hour()+":"+minute(), width/20 + width/8, height/5.5);
  }
  if (currentCode >= 1 && currentCode <= 4 || currentCode >= 6 && currentCode <= 12 || currentCode >= 37 && currentCode <= 40) {
    imageMode(CENTER);
    image(rainImg, width/4, height/4.5);
  }
  if (currentCode >= 13 && currentCode <= 25 || currentCode == 5) {
    imageMode(CENTER);
    image(snowImg, width/4, height/4.5);
  }
  if (currentCode >= 26 && currentCode <= 30) {
    imageMode(CENTER);
    image(cloudImg, width/4, height/4.5);
  }
  if (currentCode >= 31 && currentCode <= 36) {
    imageMode(CENTER);
    image(sunImg, width/4, height/4.5);
  }
  fill(255);
  textSize(headingFontSize);
  textAlign(LEFT);
  text(currentText, width/20 + 10, height/4.5);
  fill(0);
  textSize(subheadingFontSize);
  text("Temperature: "+currentTemp+"°"+temperatureUnit, width/20 + 10, height/4);
  text("Humidity: "+humidity+"%", width/20 + 10, height/4 + 30);
  text("Pressure: "+pressure+pressureUnit, width/20 + 10, height/4 + 60);
  text("Wind: "+windSpeed+" "+speedUnit, width/20 + 10, height/4 + 90);
  image(sunriseImg, width/12, height/4 + 130); 
  image(sunsetImg, width/4, height/4 + 130); 
  text(sunrise, width/20 + 20, height/4 + 180);
  text(sunset, width/4.5 + 15, height/4 + 180);
  displayWeeklyForecast();
}

void displayWeeklyForecast() {
  noStroke();
  fill(125, 125, 125, 50);
  rect(width/3, 0.1*height, 0.62*width, height/3);
  fill(255);
  textSize(headingFontSize);
  textAlign(LEFT);
  //text("Next 7 Days", width/2 + 100, height/8 + 5);
  text("Next 7 Days", (width/3 + 0.62*width/2), height/10 + headingFontSize);
  for ( int i = 0; i < forecastCount ; i++) {
    textSize(headingFontSize);
    fill(255);
    text(day[i], width/3 + 50 + i*140, height/4);
    textSize(bodyFontSize);
    text(date[i], width/3 + 50 + i*140, height/4 + 30);
    text(low[i]+"°"+temperatureUnit+" / "+high[i]+"°"+temperatureUnit, width/3 + 50 + i*140, height/4 + 60);
    textSize(weatherFontSize);
    fill(0);
    text(text[i], width/3 + 50 + i*140, height/4 + 90);
    if (code[i] >= 1 && code[i] <= 12 || code[i] >= 37 && code[i] <= 40 ) {
      imageMode(CENTER);
      image(rainImg, width/3 + 80 + i*140, height/4 + 120);
    }
    if (code[i] >= 13 && code[i] <= 25) {
      imageMode(CENTER);
      image(snowImg, width/3 + 80 + i*140, height/4 + 120);
    }
    if (code[i] >= 26 && code[i] <= 30) {
      imageMode(CENTER);
      image(cloudImg, width/3 + 80 + i*140, height/4 + 120);
    }
    if (code[i] >= 31 && code[i] <= 36) {
      imageMode(CENTER);
      image(sunImg, width/3 + 80 + i*140, height/4 + 120);
    }
  }
}


void loadNewsData() {
  JSONObject keyJson = loadJSONObject("api_key.json");
  if (keyJson == null) {
    println("api_key JSONObject could not be loaded");
  } else {
    apiKey = keyJson.getString("key");
  }  
  try{
    // URL for the JSON document
    String url = "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=" + apiKey;
    // Query for a response
    String response = join(loadStrings(url),"");
    
    // parse the string into a JSON object
    JSONObject json = parseJSONObject(response);
    if(json == null) {
      println("JSONArray could not be parsed");
    } else {
      // save the array of articles, we don't need the status code
      articles = json.getJSONArray("articles");
      // save the number of articles
      numArticles = articles.size();
    }
  }
  catch(Exception exception) {
    // Any errors will jump to this point.
    println("Encountered an error loading the news:");
    exception.printStackTrace();
  }
  for (int i=0; i < numArticles; i++) {
    newsImageUrl[i] = articles.getJSONObject(i).getString("urlToImage");
    newsHeadline[i] = articles.getJSONObject(i).getString("title");
    newsDescription[i] = articles.getJSONObject(i).getString("description");
    newsArticleUrl[i] = articles.getJSONObject(i).getString("url");
    newsAuthor[i] = articles.getJSONObject(i).getString("author");
    String[] splitDescription = split(newsDescription[i],' ');
    float n = splitDescription.length/2;
    String[] firstHalf = new String[floor(n)];
    String[] secondHalf = new String[splitDescription.length - floor(n)];
    for(int j = 0; j < splitDescription.length/2; j++) {
      firstHalf[j] = splitDescription[j];
    }
    newsDescriptionFirstLine[i] = join(firstHalf,' ');
    int k = 0;
    for(int j = floor(splitDescription.length/2); j < splitDescription.length; j++) {
      secondHalf[k] = splitDescription[j];
      k++;
    }
    newsDescriptionSecondLine[i] = join(secondHalf,' '); 
    try{
      newsImage[i] = loadImage(newsImageUrl[i]);
      newsImage[i].resize(80,60);
      newsImage[i].filter(GRAY);
    }
    catch(Exception exception) {
      // Any errors will jump to this point.
      println("Encountered an error obtaining the image:");
      exception.printStackTrace();
    }
  }
  displayNewsData();
}

void displayNewsData() {
  noStroke();
  fill(125, 125, 125, 60);
  rect(0.05*width, 0.50*height, width/1.75, 0.4*height);
  if(!(currentCode >= 13 && currentCode <= 25 || currentCode == 5))
    fill(255);
  else 
    fill(0);
  textSize(headingFontSize);
  textAlign(LEFT);
  text("Today's Top Stories", (width/1.75 - 0.05*width)/2 , 0.50*height + headingFontSize);
  //rect(0.05*width + 20,  0.50*height + 50,50,50);
  for ( int i = 0; i < numArticles/2; i++) {
    textSize(bodyFontSize);
    if(!(currentCode >= 13 && currentCode <= 25 || currentCode == 5))
      fill(255);
    else 
      fill(0);
    if(newsImage[i] != null)
      image(newsImage[i], 0.05*width + 60, 0.50*height + headingFontSize + 120 + (i-1)*75);
    else 
      image(newsImage[i], 0.05*width + 60, 0.50*height + headingFontSize + 120 + (i-1)*75);
    text(newsHeadline[i], 0.05*width + 105, 0.50*height + 140 + (i-1)*75); 
    textSize(newsBodySize);
    text(newsAuthor[i], 0.05*width + 105, 0.50*height + 155 + (i-1)*75);
    text(newsDescriptionFirstLine[i], 0.05*width + 105, 0.50*height + 170 + (i-1)*75);
    text(newsDescriptionSecondLine[i], 0.05*width + 105, 0.50*height + 180 + (i-1)*75);
  }
  for ( int j = numArticles/2 ; j < numArticles; j++) {
    imageMode(CENTER);
    textSize(bodyFontSize);
    if(!(currentCode >= 13 && currentCode <= 25 || currentCode == 5))
      fill(255);
    else 
      fill(0);
    if(newsImage[j] != null)
      image(newsImage[j], (width/1.75 + 0.05*width)/2 + 80, 0.50*height + headingFontSize + 120 + (j-(numArticles/2)-1)*75);
    else 
      image(imgNotFound, (width/1.75 + 0.05*width)/2 + 80, 0.50*height + headingFontSize + 120 + (j-(numArticles/2)-1)*75);
    text(newsHeadline[j], (width/1.75 + 0.05*width)/2 + 125, 0.50*height + 140 + (j-(numArticles/2)-1)*75); 
    textSize(newsBodySize);
    text(newsAuthor[j], (width/1.75 + 0.05*width)/2 + 125, 0.50*height + 155 + (j-(numArticles/2)-1)*75);
    text(newsDescriptionFirstLine[j], (width/1.75 + 0.05*width)/2 + 125, 0.50*height + 170 + (j-(numArticles/2)-1)*75);
    text(newsDescriptionSecondLine[j], (width/1.75 + 0.05*width)/2 + 125, 0.50*height + 180 + (j-(numArticles/2)-1)*75);
  }  
}

void loadGrass() {
  // Grass Landscape
  for(int i = 0; i < layers.length; i++){  
    int j = int(map(i,0,layers.length,height/2.5,height));
    int k = int(map(i,0,layers.length,0,100));
    int l = int(map(i,0,layers.length,.5,25));  
    layers[i] = new Landscape(j,k,l);
  }
    for(int i = 0; i < 9999; i++){
      for(int i2 = 0; i2 < layers.length; i2++){
        float j = map(i2,0,layers.length,.1,10);  
        layers[i2].update(j);
    }
  } 
}
void drawGrass() {
  // Grass Landscape
  for(int i = 0; i < layers.length; i++){
    float j = map(i,0,layers.length,.5,10);
    layers[i].update(j);
    if(i != 0){
      layers[i].display();
    }
  }
}

void loadClouds() {
  // Clouds
  for(int i = 0; i < cloud_layers.length; i++){  
    int j = int(map(i,0,cloud_layers.length,0,0.04*height));
    int k = int(map(i,0,cloud_layers.length,0,100));
    int l = int(map(i,0,cloud_layers.length,.5,25));  
    cloud_layers[i] = new Clouds(j,k,l);
  }
    for(int i = 0; i < 9999; i++){
      for(int j = 0; j < cloud_layers.length; j++){
        float k = map(j,0,cloud_layers.length,1,10);  
        cloud_layers[j].update(k);
    }
  }
}

void drawClouds() {
  fill(220);
  rect(0,0,width,0.02*height);
  for(int i = 0; i < cloud_layers.length; i++){
    float j = map(i,0,cloud_layers.length,.5,10);
    cloud_layers[i].update(j);
    if(i != 0){
      cloud_layers[i].display();
    }
  }
}

void loadSnow() {
  for(int i = 0; i < quantity; i++) {
    flakeSize[i] = round(random(minFlakeSize, maxFlakeSize));
    xPosition[i] = random(0, width);
    yPosition[i] = random(0, height);
    direction[i] = round(random(0, 1));
  }
  // Snow Landscape
  for(int i = 0; i < snow_layers.length; i++){  
    int j = int(map(i,0,snow_layers.length,height/2.5,height));
    int k = int(map(i,0,snow_layers.length,0,100));
    int l = int(map(i,0,snow_layers.length,.5,25));  
    snow_layers[i] = new Snow(j,k,l);
  }
    for(int i = 0; i < 9999; i++){
      for(int i2 = 0; i2 < snow_layers.length; i2++){
        float j = map(i2,0,snow_layers.length,.1,10);  
        snow_layers[i2].update(j);
    }
  }  
}

void drawSnow() {
  // Snow Landscape
  for(int i = 0; i < snow_layers.length; i++){
    float j = map(i,0,snow_layers.length,.5,10);
    snow_layers[i].update(j);
    if(i != 0){
      snow_layers[i].display();
    }
  }
  for(int i = 0; i < xPosition.length; i++) {
    fill(255);
    ellipse(xPosition[i], yPosition[i], flakeSize[i], flakeSize[i]);
    if(direction[i] == 0) {
      xPosition[i] += map(flakeSize[i], minFlakeSize, maxFlakeSize, .1, .5);
    } else {
      xPosition[i] -= map(flakeSize[i], minFlakeSize, maxFlakeSize, .1, .5);
    }
    yPosition[i] += flakeSize[i] + direction[i]; 
    if(xPosition[i] > width + flakeSize[i] || xPosition[i] < -flakeSize[i] || yPosition[i] > height + flakeSize[i]) {
      xPosition[i] = random(0, width);
      yPosition[i] = -flakeSize[i];
    } 
  }
}

void loadRain() {
  rain.add(new Rain());
  current = millis(); 
}

void drawRain() {
  //background(25,25,100);
  //drawGrass();
  if ((millis()-current)/1000>reseed&&rain.size()<150)
  {
    rain.add(new Rain());
    float reseed = random(0,.2);
    current = millis();
  }  
  for (int i=0 ; i<rain.size() ; i++)
  {
    Rain rainT = (Rain) rain.get(i);
    rainT.calculate();
    rainT.draw();
    if (rainT.position.y>height)
    {      
      for (int k = 0 ; k<random(5,10) ; k++)
      {
        splash.add(new Splash(rainT.position.x,height));
      }      
      rain.remove(i);
      float rand = random(0,100);
      if (rand>10&&rain.size()<150)
      rain.add(new Rain());
    }
  }  
  for (int i=0 ; i<splash.size() ; i++)
  {
    Splash spl = (Splash) splash.get(i);
    spl.calculate();
    spl.draw();
    if (spl.position.y>height)
    splash.remove(i);
  }
}

void drawSun() {
 background(150,200,215);
 drawGrass();
 fill(255, 170, 0);
 ellipse(width/2, height/10, sunRadius, sunRadius);
}

void drawMoon() {
 noStroke();
 fill(255,255,100);
 ellipse(width/6, height/6, 30, 30);
}

void drawStars() {
  for (int i=0; i < 200; i++) {
    noStroke ();
    fill(255);
    ellipse(starX[i], starY[i], starSize[i], starSize[i]);
  }
}

void drawScreenSaver() {
  if(screenSaverRunningTime > millis() - 600000) {
    fill(random(0,255),random(0,255),random(0,255));
    radius += 0.02;
    rot += (1+sqrt(5))/2; // golden ratio: (1+sqrt(5))/2
    float x = width/2 + sin(rot)*radius*10;
    float y = height/2 + cos(rot)*radius*10;
    ellipse(x,y,radius/2,radius/2);
  }
}

void displayGames() {
  noStroke();
  fill(125, 125, 125, 60);
  rect(0.65*width, 0.50*height, 0.4*width, 0.4*height);
  imageMode(CENTER);
  image(gamesImg, (0.65*width + 0.3*width/2), 0.50*height + 0.4*height/2);  
}

void displayGamesFolder() {
  noStroke();
  fill(125, 125, 125, 60);
  rect(0.05*width, 0.1*height, 0.4*width, 0.35*height);
  rect(0.5*width, 0.1*height, 0.4*width, 0.35*height);
  rect(0.05*width, 0.5*height, 0.4*width, 0.35*height);
  rect(0.5*width, 0.5*height, 0.4*width, 0.35*height);
  imageMode(CENTER);
  fill(255);
  textAlign(LEFT);
  textSize(subheadingFontSize);
  image(tankwarsImg, (0.05*width + 0.4*width/2), (0.1*height + 0.35*height/2));
  text("Tank Wars",(0.05*width + 0.4*width/2) - 80, (0.1*height + 0.35*height/2) + 120);
  image(drawImg, (0.5*width + 0.4*width/2), (0.1*height + 0.35*height/2));
  text("Random Art",(0.5*width + 0.4*width/2) - 80, (0.1*height + 0.35*height/2) + 120);
  image(pongImg, (0.05*width + 0.4*width/2), (0.5*height + 0.35*height/2));
  text("Pong - 1 Player",(0.05*width + 0.4*width/2) - 80, (0.5*height + 0.35*height/2) + 120);
  image(pong2Img, (0.5*width + 0.4*width/2), (0.5*height + 0.35*height/2));
  text("Pong - 2 Players",(0.5*width + 0.4*width/2) - 80, (0.5*height + 0.35*height/2) + 120);
}

void displayGamesFolder2() {
  noStroke();
  fill(125, 125, 125, 60);
  rect(0.05*width, 0.1*height, 0.4*width, 0.35*height);  
  imageMode(CENTER);
  fill(255);
  textAlign(LEFT);
  textSize(subheadingFontSize);
  image(pingpongIconImg, (0.05*width + 0.4*width/2), (0.1*height + 0.35*height/2));
  text("Ping Pong",(0.05*width + 0.4*width/2) - 80, (0.1*height + 0.35*height/2) + 120);
}

/* void mousePressed() {
  if(projectState == "homescreen") {
    if (handOverGamesIcon) {
      projectState = "gamescreen";
      reset();
    }
    if (handOverPong) {
      projectState = "pong";
      reset();
    }
    if (handOverDrawing) {
      projectState = "art";
      reset();
    }
  }
  if(projectState == "pong") {
    if (handOverCloseButton) {
      projectState = "homescreen";
      reset();
      handOverCloseButton = false;
    } else
    gameStart = !gameStart;
  }
  if(projectState == "tankwars") {
    if (handOverCloseButton) {
      projectState = "homescreen";
      reset();
      handOverCloseButton = false;
    } 
  }
    if(projectState == "art") {
    if (handOverCloseButton) {
      projectState = "homescreen";
      reset();
      handOverCloseButton = false;
    }
  }
} */

void closeButton(float xPosition, float yPosition) {
  imageMode(CORNER);
  image(closeButtonImg, xPosition, yPosition);
}

void drawBackButton(float xPosition, float yPosition) {
  imageMode(CORNER);
  image(backButtonImg, xPosition, yPosition);  
}

void drawForwardButton(float xPosition, float yPosition) {
  imageMode(CORNER);
  image(forwardButtonImg, xPosition, yPosition);
}

void handSelectGames() {
  // Check for Clicks in Home Sreen
  if(projectState == "homescreen") {
    if (handOverGamesIcon) {
        projectState = "gamescreen";
        reset();
    }
  }
  
  // Check for clicks in Game Screen Folder 1
  if(projectState == "gamescreen") {
    if (handOverCloseButton) {
      projectState = "homescreen";
      handOverCloseButton = false;
      reset();
    }
     if (handOverTankWars) {
      projectState = "tankwars";
      reset();
    }
    if (handOverDrawing) {
      projectState = "art";
      reset();
    }
    if (handOverPong) {
      projectState = "pong";
      reset();
    }
    if (handOverPong2) {
      projectState = "pong2";
      reset();
    }
    if (handOverForwardButton) {
      projectState = "gamescreen2";
      reset();
    }
  }
  // Check for clicks in Game Screen Folder 2
  if(projectState == "gamescreen2") {
    if (handOverCloseButton) {
      projectState = "homescreen";
      handOverCloseButton = false;
      reset();
    }
     if (handOverPingPong) {
      projectState = "pingpong";
      reset();
    }
    if (handOverBackButton) {
      projectState = "gamescreen";
      reset();
    }
  }
}

void handSelectCloseButton() {
  if(projectState == "art") {
    if (handOverCloseButton) {
      projectState = "gamescreen";
      handOverCloseButton = false;
      reset();
    }
  }
  if(projectState == "pong") {
    if (handOverCloseButton) {
      projectState = "gamescreen";
      handOverCloseButton = false;
      reset();
    }
  }
  if(projectState == "pong2") {
    if (handOverCloseButton) {
      projectState = "gamescreen";
      handOverCloseButton = false;
      reset();
    }
  }
  if(projectState == "tankwars") {
    if (handOverCloseButton) {
      projectState = "gamescreen";
      handOverCloseButton = false;
      reset();
    }
  }
  if(projectState == "pingpong") {
    if (handOverCloseButton) {
      projectState = "gamescreen2";
      handOverCloseButton = false;
      reset();
    }
  }
}

void handMoved() {
  if(projectState == "screensaver") {
   if(!Float.isNaN(handAvgX) && !Float.isNaN(handAvgY)) {
    projectState = projectPreviousState;
    reset();
   }
  }  
}

void reset() {
  setup();
}
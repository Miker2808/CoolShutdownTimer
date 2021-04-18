
<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://imgur.com/EUdrz2J"><img src="https://i.imgur.com/EUdrz2J.png" /></a>
  </a>

  <h2 align="center">CoolShutdownTimer</h2>
  <h4 align="center">A shutdown timer developed in Qt with Qml</h4>
</p>

## About the project
The CoolShutdown project was made to attempt to make a modern version of a basic software. 
The making of a shutdown timer is fairly easy, but the main focus was on the QML features.
For example, the dynamics of the gui with mouse hovering, a custom title bar, customizable colors.

## Features
### The Timer
The timer is based on custom spinbox that is made of buttons and fieldtext, Allows changing values through fieldtext and buttons
The values are validated and allow only integers from a certain value.

![Timer-Showcase](https://i.imgur.com/VJXEyC8.gif)
======
### The Action Bar

The action bar, allows the user to choose what action to perform once timer reaches zero. The action bar will change the leftmost action with whatever was clicked, and the last
action will take its place. the action can be changed while the timer runs, as the shutdown process executes only at zero seconds.

![ActionBar-Showcase](https://i.imgur.com/wEq0YUM.gif)
======
### The Custom Title Bar

The standard title bar that comes with windows 10 is very limited, to keep the modern look I used Qt's built-in features to create a custom title bar with all the features windows 10 has.
![TitleBar-Showcase](https://i.imgur.com/6fj8lMT.gif)

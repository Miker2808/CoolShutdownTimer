
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


<br />
### The Action Bar

The action bar, allows the user to choose what action to perform once timer reaches zero. The action bar will change the leftmost action with whatever was clicked, and the last
action will take its place. the action can be changed while the timer runs, as the shutdown process executes only at zero seconds.

![ActionBar-Showcase](https://i.imgur.com/wEq0YUM.gif)

<br />
### The Custom Title Bar


The standard title bar that comes with windows 10 is very limited, to keep the modern look I used Qt's built-in features to create a custom title bar with all the features windows 10 has.

![TitleBar-Showcase](https://i.imgur.com/6fj8lMT.gif)

<br />
### Settings window with preset colors

The software allows customizing your user interface by adding a settings window, allowing you to choose one of the preset color packs.

![PresetColor-Showcase](https://i.imgur.com/iGp3ae1.gif)

<br />
### Custom Color choice, with handmade color picker

The user can choose a custom color for three properties, the picking is done by choosing a color from a custom color picker.

![CustomColor-Showcase](https://i.imgur.com/jdprm42.gif)

<br />
### Save settings with configuration file

The software creates a config.ini file on first execution, the file will be placed inside the executables directory.
Having a configuration file allows the user to save his settings and get them loaded on next execution.
The settings are loaded on construction, and saved on software termination.

(For those who wish to have the source without the configuration file, there exists a branch without config)

------
## Installation

### Binaries

For those wishing for a compiled project just for use, a compiled standalone version is available.
The project was compiled with MSVC2015 x64, therefore it will run only on 64bit Windows. (Software was tested on multiple windows 10 computers)
All the dynamic Qt libraries are deployed with the executable, deployment was done using 'windeployqt'

Users may get MSVC errors, if you get dll errors, downloading the Microsoft Visual C++ 2015 redistributable may solve the issue.
If the issue persists, please file an issue.

The Built Binaries can be downloaded [Here](https://mega.nz/file/JA83xYzK#GYoo9cFnoEAI3OLArlccGhmjbfGgmzvos969N24lE0Q "Download Through mega.nz")

<br />
### Source



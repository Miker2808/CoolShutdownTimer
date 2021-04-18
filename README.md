
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


------
### The Action Bar

The action bar, allows the user to choose what action to perform once timer reaches zero. The action bar will change the leftmost action with whatever was clicked, and the last
action will take its place. the action can be changed while the timer runs, as the shutdown process executes only at zero seconds.

![ActionBar-Showcase](https://i.imgur.com/wEq0YUM.gif)

------
### The Custom Title Bar


The standard title bar that comes with windows 10 is very limited, to keep the modern look I used Qt's built-in features to create a custom title bar with all the features windows 10 has.

![TitleBar-Showcase](https://i.imgur.com/6fj8lMT.gif)

------
### Settings window with preset colors

The software allows customizing your user interface by adding a settings window, allowing you to choose one of the preset color packs.

![PresetColor-Showcase](https://i.imgur.com/iGp3ae1.gif)

------
### Custom Color choice, with handmade color picker

The user can choose a custom color for three properties, the picking is done by choosing a color from a custom color picker.

![CustomColor-Showcase](https://i.imgur.com/jdprm42.gif)

------
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

To execute, simply extract the folder to a desired location and run the executable

------
### Source
To compile the project yourself you will need the following:
* Qt 5.15 (Was developed on Qt 5.15.2)
* Desktop kit and development tools (Mingw810_64, Mingw810_32, MSVC2015_64) Project was compiled successfully with mingw810 64bit, 32bit and MSVC2015 64bit.

**Project was tested only on Windows 10, it might compile successfully on windows7, windows8, and ubuntu (using mingw)**

The steps required to compile the project:
1. Clone the project from the desired length
2. Open the project (Double clicking the .pro file) or **File -> Open Project -> {navigate the .pro file}
3. Choose the desired kit/s (Mingw x64, Mingw x32, MSVC)
4. clean project using **Build -> Clean all projects for all configurations** 
5. run qmake **Build -> Run Qmake** 
6. build project

## Licenses
Software was developed following Qts General Public License, by using Qt for open source, software must follow GNU license, and disclose the code and its source.
For more information feel free to check Qt's website [Here](https://www.qt.io "Qt website")
**Icons were developed by me, for free, unlimited use**





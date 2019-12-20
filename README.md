# Magnetic field over satellite orbit

Given orbit parameters and Universal Coordinated Time (UTC) the program calculates vector of magnetic field over number of points on the satellite orbit. This program was used as demonstration for the CubeSat program at the University of Zagreb.

![](output_example.bmp)

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

Program requires [Aerospace Toolbox](https://www.mathworks.com/products/aerospace-toolbox.html) to be already installed.

### Installing

1. Clone this repository,
2. Open `main.m` file and there you have orbit parameters to tweak.


## Running
To get some data out of the system one should:
1. Modify the orbit parameters and UTC time at the top of the `main.m` file:
```
RAAN    =  38;                % Right Ascension of Ascendent Node [deg]
w       =  35;                % Argument of perigee               [deg]
v0      =  54;                % True anomaly at the departure     [deg]
i       =  51.64;             % inclination                       [deg]
a       =  6700;              % Major semi-axis           (>6378) [km]
e       =  0.001;             % Eccentricity
start_time = datetime('now'); % UTC time of sattelite starting point
norb = 5;                     % number of orbits
time_step = 60;               % Calculate point every time_step   [s],
                              %   decrease for faster calculation
```
2. Press Run button.

## Authors

* **Ivan Vnučec** - [GitHub](https://github.com/PurpleBooth)
                  - [LinkedIn](https://www.linkedin.com/in/ivan-vnucec/)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Special thanks to Ennio Condoleo. This code is modified version of his program which can be found here: [LINK](https://www.mathworks.com/matlabcentral/fileexchange/45573-orbit3d)

* This program was used as a Project on the FER CubeSat called FERSAT at the University of Zagreb. [LINK](https://www.fer.unizg.hr/zrk/FERSAT).


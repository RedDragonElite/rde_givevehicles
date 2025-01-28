Custom Vehicles Resource for FiveM

Overview
--------
The custom_vehicles resource allows you to add custom vehicles to your FiveM server 
that are not natively supported by the game. This resource provides a way to define 
custom vehicles in a configuration file and spawn them using a command. It uses ox_lib 
for command registration and notifications.

Features
--------
Define custom vehicles in a configuration file.
Spawn custom vehicles using a command.
Uses ox_lib for command registration and notifications.

Installation
------------
Download the Resource:

Clone or download the custom_vehicles resource from the repository.
Add to Your Server:

Place the custom_vehicles folder in the resources directory of your FiveM server.
Add to server.cfg:

Open your server.cfg file and add the following line to ensure the resource is started:

ensure custom_vehicles
Start Your Server:

Start your FiveM server, and the custom_vehicles resource will be loaded.

Configuration
-------------
The custom_vehicles resource uses a configuration file to define custom vehicles. 
The configuration file is located at custom_vehicles/config.lua.

Configuration File (config.lua)

Config = {}

Config.Vehicles = {
    {name = "custom_vehicle_1", model = "customvehicle1"},
    {name = "custom_vehicle_2", model = "customvehicle2"},
    -- Add more vehicles here
}

name: The name of the vehicle as it will be used in the command.
model: The model name of the vehicle as defined in the game files.

Usage
-----
Spawning a Custom Vehicle
To spawn a custom vehicle, use the /givecustomvehicle command. The command syntax is as follows:

/givecustomvehicle [playerId] [vehicleName]
playerId: The ID of the player who will receive the vehicle.
vehicleName: The name of the custom vehicle as defined in the configuration file.
Example

/givecustomvehicle 1 custom_vehicle_1
This command will spawn the vehicle custom_vehicle_1 for the player with ID 1.

Notifications
-------------
The resource uses ox_lib to provide notifications to the players. 
Notifications are used to inform the player about the status of the command, 
such as whether the vehicle was successfully spawned or if there was an error.

Dependencies
------------
ox_lib: This resource requires ox_lib for command registration and notifications. 
Make sure ox_lib is installed and started on your server.

License
-------
This resource is released under the MIT License. 
See the LICENSE file for more details.

Support
-------
For support, please open an issue on the GitHub repository or contact the author.

Authors
-------
SerpentsByte: Initial work and maintenance.

Acknowledgments
---------------
Special thanks to the ox_lib developers for providing a robust
library for command handling and notifications.
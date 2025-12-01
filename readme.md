# Project Overview


# Project Structure
res://Addons/
res://Assets/
res://Blueprints/
res://Editor/
res://Libraries/
res://Materials/
res://Scenes/
res://Scripts/

# Technical Decisions
## Model data format
Currently I have weight the pros and cons of differnt formats for 3D models and essentially there are
two possible formats that suite the needs of this project.  GLB is the format largely recommended for
Godot, however this requires manual exporting of the files from an external program.  Mean while Godot
allows for the direct importing of .blend files with a few minor downsides.  The project becomes a bit
less portable, as it requires anyone wishing to import a model to have blender installed, and imports
from .blend files take longer them .glb files.  With the downsides being seemingly so minor I have
decided to use .blend files, at least for the time being.  The convenience that comes from being able
to pop open blender and directly edit the files is really nice and keeps all my files for the project
in a single place.  With that being said it may become more partical in the future to start using GLB
however I think the migration to this format may take some work.  For 3D models I tend to create a
scene that inherits from the imported model, for example the model humanoid_male has an inherited scene
called humanoid_male_export.  This makes it easier to implement features such as inverse kinematics
that need to directly work with some of the nodes inside of the imported scene without exposing the
entire entity as part of the scene, and allows for reimporting to serve it's purpose correctly.

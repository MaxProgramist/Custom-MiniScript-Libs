How to use each lib:

--------Particles.ms--------

initialParticleSystem(position, rotation, spread, duration, countOfParticles, size, speed, lifetime, gravityForce, timeBtwParticles, texture, color)

+----------------------------------------------------------------------------------+
|                                       Input                                      |
+-----------------------+----------------++-----------------------+----------------+
| position              | [x,y]          || lifetime              | [min, max]     |
| rotation              | angle          || gravityForce          | force          |
| spread                | [left, right]  || timeBtwParticles      | seconds        |
| duration              | seconds        || texture               | image          |
| countOfParticles      | [min, max]     || color                 | string         |
| size                  | [min, max]     ||                       |                |
+-----------------------+----------------++-----------------------+----------------+
|                                      Return                                      |
+-----------------------+----------------++----------------------------------------+
| particle System       | custom class   ||                                        |
+-----------------------+----------------++----------------------------------------+

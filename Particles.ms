import "mathUtil"

Vector2 = {"x":0, "y":0}

localDisplay = new SpriteDisplay
localDisplay.clear

Particle = {"speed": 0, "direction": new Vector2, "lifetime": 0,
    "gravityForce": 0, "sprite": null, "startLifeTime":0}

Particle.update = function()
	self.sprite.x += self.direction.x * self.speed
	self.sprite.y += self.direction.y * self.speed
	
	self.direction.y -= self.gravityForce
	
	if time-self.startLifeTime > self.lifetime and
	  (display(4).sprites.indexOf(self.sprite) != null) then
		
	end if
end function

ParticleSystem = {"position": new Vector2, "rotation": 0, 
  "spread": [0,0], "duration": 0, 
  "countOfParticles_min": 0, "countOfParticles_max": 0,
  "size_min": 0, "size_max": 0, 
  "speed_min": 0, "speed_max":0, 
  "lifetime_min": 0, "lifetime_max": 0, 
  "gravityForce": 0,
  "texture": null, "color": "#FFFFFFFF",
  "particles":[], "timeBtwParticles":0, 
  "lastTimeBtwParticles":0, "startParticleSystem":0,
  "spriteDisplay": new SpriteDisplay, "countOfUsed":0}

ParticleSystem.update = function()
	
	for curentParticle in self.particles
		curentParticle.update()
		if time-curentParticle.startLifeTime >= curentParticle.lifetime then
			self.spriteDisplay.sprites.remove self.spriteDisplay.sprites.indexOf(curentParticle.sprite)
			self.particles.remove self.particles.indexOf(curentParticle)
		end if
	end for
	
	if time - self.startParticleSystem > self.duration then return
	
	if time - self.lastTimeBtwParticles > self.timeBtwParticles then
		self.countOfParticles = random(self.countOfParticles_min, self.countOfParticles_max)
		for i in range(1, self.countOfParticles)
			self.makeParticle()
		end for
		self.lastTimeBtwParticles = time
	end if
	
	print "!!! Update!"
end function

ParticleSystem.makeParticle = function()
	self.sizeOfParticle = random(self.size_min, self.size_max,4)
	
	self.particleDirection = new Vector2
	self.rotationOfParticle = mathUtil.degToRad(random(self.rotation-self.spread[0]+90, self.rotation+self.spread[1]+90, 4))
	self.particleDirection.x = cos(self.rotationOfParticle)
	self.particleDirection.y = sin(self.rotationOfParticle)
	
	self.speedOfParticle = random(self.speed_min, self.speed_max, 4)
	
	self.lifetimeOfParticle = random(self.lifetime_min, self.lifetime_max, 4)
	
	self.newParticle = new Particle
	self.particles.push self.newParticle
	
	self.newParticle.speed = self.speedOfParticle
	self.newParticle.direction = self.particleDirection
	self.newParticle.lifetime = self.lifetimeOfParticle
	self.newParticle.gravityForce = self.gravityForce
	self.newParticle.curentLifeTime = time
	self.newParticle.startLifeTime = time
	
	self.newParticle.sprite = new Sprite
	self.newParticle.sprite.image = self.texture
	self.newParticle.sprite.scale = self.sizeOfParticle
	self.newParticle.sprite.tint = self.color
	self.newParticle.sprite.x = self.position.x
	self.newParticle.sprite.y = self.position.y
	self.spriteDisplay.sprites.push self.newParticle.sprite
end function


initialParticleSystem = function(position = null, rotation = 0, spread = null, duration = 0, countOfParticles = null, size = null, speed = null, lifetime = null, gravityForce = 0, timeBtwParticles = 0, texture = null, color = "#FFFFFFFF")
	
	if position == null then position = [0,0]
	if spread == null then spread = [0,0]
	if countOfParticles == null then countOfParticles = [0,0]
	if size == null then size = [1,1]
	if speed == null then speed = [0,0]
	if lifetime == null then lifetime = [0,0]
	if texture == null then texture = file.loadImage("/sys/pics/shapes/Circle.png")
	if timeBtwParticles == 0 then timeBtwParticles = 1/60
	CurentParticleSystem = new ParticleSystem
	
	tempVector2_1 = new Vector2
	tempVector2_1.x = position[0]
	tempVector2_1.y = position[1]
	CurentParticleSystem.position = tempVector2_1
	
	CurentParticleSystem.rotation = rotation
	CurentParticleSystem.spread = spread
	CurentParticleSystem.duration = duration
	CurentParticleSystem.countOfParticles_min = countOfParticles[0]
	CurentParticleSystem.countOfParticles_max = countOfParticles[1]
	CurentParticleSystem.size_min = size[0]
	CurentParticleSystem.size_max = size[1]
	CurentParticleSystem.speed_min = speed[0]
	CurentParticleSystem.speed_max = speed[1]
	CurentParticleSystem.lifetime_min = lifetime[0]
	CurentParticleSystem.lifetime_max = lifetime[1]
	CurentParticleSystem.gravityForce = gravityForce
	CurentParticleSystem.timeBtwParticles = 1/60
	
	CurentParticleSystem.texture = texture
	
	CurentParticleSystem.color = color
	
	CurentParticleSystem.particles = []
	CurentParticleSystem.curentTimeBtwParticles = time
	CurentParticleSystem.lastTimeBtwParticles = time
	CurentParticleSystem.startParticleSystem = time
	CurentParticleSystem.spriteDisplay = localDisplay
	
	return CurentParticleSystem
end function

random = function(a,b,t)
	return round((rnd()*(b-a))+a, t)
end function

testFunction1 = function
	clear
	localDisplay.clear
	FPS = time
	testPS = initialParticleSystem([200,200], -45, [15,15], 5, [4,6], [0.1,0.2], [5,6], [5,6], 0.01, 1/360, null, "#FFFFFFFF")
	testPS1 = initialParticleSystem([400,200], 45, [15,15], 5, [4,6], [0.1,0.2], [5,6], [5,6], 0.01, 1/360, null, "#FFFFFFFF")
	localDisplay.install 1
	
	while true
		display(3).clear
		print (time - FPS) + "/" + (1/60) + " Dif:" + ((time - FPS)-(1/60))
		if time - testPS.startParticleSystem < testPS.duration or testPS.particles != [] then
			testPS.update()
			testPS1.update()
		end if
		
		FPS = time
		yield
	end while
end function



if locals == globals then testFunction1
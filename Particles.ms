import "mathUtil"

Vector2 = {"x":0, "y":0}

Particle = {"speed": 0, "direction": new Vector2, "lifetime": 0,
    "gravityForce": 0, "sprite": null, "curentLifeTime":0, "startLifeTime":0}

Particle.update = function()
	self.sprite.x += self.direction.x * self.speed
	self.sprite.y += self.direction.y * self.speed
	
	self.direction.y -= self.gravityForce
	
	self.curentLifeTime = time
	
	if self.curentLifeTime-self.startLifeTime >= self.lifetime then
		display(4).sprites.remove display(4).sprites.indexOf(self.sprite)
	end if
end function

ParticleSystem = {"position": new Vector2, "rotation": 0, 
  "spread": new Vector2, "duration": 0, 
  "countOfParticles_min": 0, "countOfParticles_max": 0,
  "size_min": 0, "size_max": 0, 
  "speed_min": 0, "speed_max":0, 
  "lifetime_min": 0, "lifetime_max": 0, 
  "gravityForce": 0,
  "texture": null, "color": color.white,
  "particles":[], "timeBtwParticles":0, 
  "curentTimeBtwParticles":0, "lastTimeBtwParticles":0}

ParticleSystem.update = function()
	if self.curentTimeBtwParticles - self.lastTimeBtwParticles >= self.timeBtwParticles then
		self.countOfParticles = mathUtil.randRange(self.countOfParticles_min, self.countOfParticles_max)
		for i in range(0, self.countOfParticles)
			self.makeParticle()
		end for
		self.lastTimeBtwParticles = time
		print "!!! ----SPAWN!"
	end if
	
	for curentParticle in self.particles
		curentParticle.update()
		if curentParticle.curentLifeTime-curentParticle.startLifeTime >= curentParticle.lifetime then
			self.particles.remove self.particles.indexOf(curentParticle)
		end if
	end for
	
	print "!!! "+self.particles.len+" PARTICLES!!"
	
	self.curentTimeBtwParticles = time
	
	print "!!! Update!"
end function

ParticleSystem.makeParticle = function()
	self.sizeOfParticle = mathUtil.randRange(self.size_min, self.size_max)
	
	self.particleDirection = new Vector2
	self.rotationOfParticle = mathUtil.degToRad(mathUtil.randRange(self.rotation-self.spread.x, self.rotation+self.spread.y))
	self.particleDirection.x = cos(self.rotationOfParticle)
	self.particleDirection.y = sin(self.rotationOfParticle)
	
	self.speedOfParticle = mathUtil.randRange(self.speed_min, self.speed_max)
	
	self.lifetimeOfParticle = mathUtil.randRange(self.lifetime_min, self.lifetime_max)
	
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
	self.newParticle.sprite.size = self.sizeOfParticle
	self.newParticle.sprite.tint = self.color
	self.newParticle.sprite.x = self.position.x
	self.newParticle.sprite.y = self.position.y
	display(4).sprites.push self.newParticle.sprite
	
	print "!!! Made new Particle!"
end function


initialParticleSystem = function(position = null, rotation = 0, spread = null, duration = 0, countOfParticles = null, size = null, speed = null, lifetime = null, gravityForce = 0, texture = null, color = "#FFFFFFFF")
	
	if position == null then position = [0,0]
	if spread == null then spread = [0,0]
	if countOfParticles == null then countOfParticles = [0,0]
	if size == null then size = [0,0]
	if speed == null then speed = [0,0]
	if lifetime == null then lifetime = [0,0]
	if texture == null then texture = file.loadImage("/sys/pics/shapes/Circle.png")
	
	CurentParticleSystem = new ParticleSystem
	
	tempVector2_1 = new Vector2
	tempVector2_1.x = position[0]
	tempVector2_1.y = position[1]
	CurentParticleSystem.position = tempVector2_1
	
	CurentParticleSystem.rotation = rotation
	
	tempVector2_2 = new Vector2
	tempVector2_2.x = spread[0]
	tempVector2_2.y = spread[1]
	CurentParticleSystem.position = tempVector2_2
	
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
	
	CurentParticleSystem.texture = texture
	
	CurentParticleSystem.color = color
	
	CurentParticleSystem.particles = []
	CurentParticleSystem.timeBtwParticles = 1/60
	CurentParticleSystem.curentTimeBtwParticles = time
	CurentParticleSystem.lastTimeBtwParticles = time
	
	print "!!! Done Initialization!"
	
	return CurentParticleSystem
end function

testFunction1 = function
	clear
	testPS = initialParticleSystem([600,600], 45, [45,45], 5, [5,7], [0.3,0.4], [0.2,0.3], [6,10], 0, null, "#FFFFFFFF")
	
	while true
		display(3).clear
		testPS.update()
		
		yield
	end while
end function

testFunction1
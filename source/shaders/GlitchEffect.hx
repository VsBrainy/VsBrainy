package shaders;

import flixel.system.FlxAssets.FlxShader;

class GlitchEffect {
	public var shader(default, null):GlitchEffectShader = new GlitchEffectShader();
	public var amplitude(default, set):Float = 0;
    public var frequency(default, set):Float = 0;
    public var speed(default, set):Float = 0;

	private function set_amplitude(value:Float) {
		amplitude = value;
		shader.uWaveAmplitude.value = [amplitude];
		return amplitude;
	}

    private function set_frequency(value:Float) {
		frequency = value;
		shader.uFrequency.value = [frequency];
		return frequency;
	}

    private function set_speed(value:Float) {
		speed = value;
		shader.uSpeed.value = [speed];
		return speed;
	}

    private var time:Float = 0;
    
    public function update(elapsed:Float)
    {
        time += elapsed;
        shader.uTime.value = [time/2];
    }

	public function new()
	{
		shader.uTime.value = [0];
		amplitude = 0.1;
        frequency = 5;
        speed = 2.25;
	}
}

class GlitchEffectShader extends FlxShader {
	@:glFragmentSource('
            		#pragma header
		//uniform float tx, ty; // x,y waves phase
		uniform float uTime;
		
		const int EFFECT_TYPE_DREAMY = 1;
		const int EFFECT_TYPE_WAVY = 2;
		const int EFFECT_TYPE_HEAT_WAVE_HORIZONTAL = 3;
		const int EFFECT_TYPE_HEAT_WAVE_VERTICAL = 4;
		const int EFFECT_TYPE_FLAG = 0;
		
		uniform int effectType;
		
		/**
		 * How fast the waves move over time
		 */
		uniform float uSpeed;
		
		/**
		 * Number of waves over time
		 */
		uniform float uFrequency;
		
		/**
		 * How much the pixels are going to stretch over the waves
		 */
		uniform float uWaveAmplitude;

		vec2 sineWave(vec2 pt)
		{
			float x = 0.0;
			float y = 0.0;
			
			if (effectType == EFFECT_TYPE_DREAMY) 
			{
				float offsetX = sin(pt.y * uFrequency + uTime * uSpeed) * uWaveAmplitude;
                pt.x += offsetX; // * (pt.y - 1.0); // <- Uncomment to stop bottom part of the screen from moving
			}
			else if (effectType == EFFECT_TYPE_WAVY) 
			{
				float offsetY = sin(pt.x * uFrequency + uTime * uSpeed) * uWaveAmplitude;
				pt.y += offsetY; // * (pt.y - 1.0); // <- Uncomment to stop bottom part of the screen from moving
			}
			else if (effectType == EFFECT_TYPE_HEAT_WAVE_HORIZONTAL)
			{
				x = sin(pt.x * uFrequency + uTime * uSpeed) * uWaveAmplitude;
			}
			else if (effectType == EFFECT_TYPE_HEAT_WAVE_VERTICAL)
			{
				y = sin(pt.y * uFrequency + uTime * uSpeed) * uWaveAmplitude;
			}
			else if (effectType == EFFECT_TYPE_FLAG)
			{
				y = sin(pt.y * uFrequency + 10.0 * pt.x + uTime * uSpeed) * uWaveAmplitude;
				x = sin(pt.x * uFrequency + 5.0 * pt.y + uTime * uSpeed) * uWaveAmplitude;
			}
			
			return vec2(pt.x + x, pt.y + y);
		}

		void main()
		{
			vec2 uv = sineWave(openfl_TextureCoordv);
			gl_FragColor = texture2D(bitmap, uv);
		}
		')

	public function new()
	{
		super();
	}
}
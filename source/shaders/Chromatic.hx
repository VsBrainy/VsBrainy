package shaders;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxShader;
import openfl.geom.Point;

class ChromaticAbberEffect {
    public var shader(default, null):ChromaticAbber;
    private var sprite:FlxSprite;

    public function new(target:FlxSprite) {
        sprite = target;
        shader = new ChromaticAbber();
        sprite.shader = shader;
    }

    public function destroy() {
        sprite.shader = null;
    }
}

class ChromaticAbber extends FlxShader {
    @:glFragmentSource('
#pragma header
vec2 uv = openfl_TextureCoordv.xy;
vec4 col = vec4(0.0);

col.r = texture2D(bitmap, vec2(uv.x + 0.01, uv.y)).r;
col.g = texture2D(bitmap, vec2(uv.x, uv.y)).g;
col.b = texture2D(bitmap, vec2(uv.x - 0.01, uv.y)).b;
col.a = clamp(texture2D(bitmap, vec2(uv.x + 0.01, uv.y)).a +
              texture2D(bitmap, vec2(uv.x - 0.01, uv.y)).a, 0.0, 1.0);

gl_FragColor = col;
')
}

class ChromaticRadialBlurEffect {
    public var shader(default, null):ChromaticRadialBlur;
    private var sprite:FlxSprite;

    public function new(target:FlxSprite) {
        sprite = target;
        shader = new ChromaticRadialBlur();
        sprite.shader = shader;
    }

    public function destroy() {
        sprite.shader = null;
    }
}

class ChromaticRadialBlur extends FlxShader {
    @:glFragmentSource('
#pragma header
int sampleCount = 50;
float blur = 0.25; 
float falloff = 3.0; 

#define INPUT bitmap

void main(void) {
    vec2 destCoord = openfl_TextureCoordv.xy;

    vec2 direction = normalize(destCoord - 0.5); 
    vec2 velocity = direction * blur * pow(length(destCoord - 0.5), falloff);
    float inverseSampleCount = 1.0 / float(sampleCount); 
    
    mat3x2 increments = mat3x2(velocity * 1.0 * inverseSampleCount,
                               velocity * 2.0 * inverseSampleCount,
                               velocity * 4.0 * inverseSampleCount);

    vec4 accumulator = vec4(0);
    mat3x2 offsets = mat3x2(0); 
    
    for (int i = 0; i < sampleCount; i++) {
        accumulator.r += texture2D(INPUT, destCoord + offsets[0]).r; 
        accumulator.g += texture2D(INPUT, destCoord + offsets[1]).g; 
        accumulator.b += texture2D(INPUT, destCoord + offsets[2]).b; 
        accumulator.a += (texture2D(INPUT, destCoord + offsets[0]).a + texture2D(INPUT, destCoord + offsets[1]).a + texture2D(INPUT, destCoord + offsets[2]).a)/3.0; 
        
        offsets -= increments;
    }

    gl_FragColor = vec4(accumulator / float(sampleCount));
}')
}

class Chromatic {}
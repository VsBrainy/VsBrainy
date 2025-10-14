package shaders;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxShader;

import shaders.GlitchEffect.GlitchEffectShader;

class GlitchEffectAlt {
    public var shader(default, null):GlitchEffectShader;
    public var amplitude(default, set):Float = 0;
    public var frequency(default, set):Float = 0;
    public var speed(default, set):Float = 0;

    private var target:FlxSprite;
    private var time:Float = 0;

    public function new(target:Dynamic) {
        if (Reflect.hasField(target, "shader")) {
            target.shader = shader;
        } else {
            trace("Warning: target does not have a shader property!");
        }

        shader = new GlitchEffectShader();
        target.shader = shader;

        shader.uTime.value = [0];
    }

    private function set_amplitude(value:Float):Float {
        amplitude = value;
        shader.uWaveAmplitude.value = [amplitude];
        return amplitude;
    }

    private function set_frequency(value:Float):Float {
        frequency = value;
        shader.uFrequency.value = [frequency];
        return frequency;
    }

    private function set_speed(value:Float):Float {
        speed = value;
        shader.uSpeed.value = [speed];
        return speed;
    }

    public function update(elapsed:Float):Void {
        amplitude = 0.1;
        frequency = 5;
        speed = 2.25;

        time += elapsed;
        shader.uTime.value = [time/2];
        shader.uWaveAmplitude.value = [amplitude];
        shader.uFrequency.value = [frequency];
        shader.uSpeed.value = [speed];
        
        target.shader = shader;
    }

    public function destroy():Void {
        target.shader = null;
    }
}
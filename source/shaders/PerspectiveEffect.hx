package shaders;

import flixel.system.FlxAssets.FlxShader;

class PerspectiveEffect
{
    public var shader(default, null):PerspectiveShader;
    private var sprite:FlxSprite;
    private var depth:Float;
    private var vanishOffset:FlxPoint = new FlxPoint();
    private var originalX:Float;
    private var originalY:Float;
    private var originalScaleX:Float;
    private var originalScaleY:Float;

    public function new(target:FlxSprite, depth:Float = 1)
    {
        this.sprite = target;
        this.depth = depth;

        originalX = sprite.x;
        originalY = sprite.y;
        originalScaleX = sprite.scale.x;
        originalScaleY = sprite.scale.y;

        shader = new PerspectiveShader();
        sprite.shader = shader;
        shader.u_top.value = [0, 1];
    }

    public function setVanishOffset(x:Float = 0, y:Float = 0)
    {
        vanishOffset.set(x, y);
    }

    public function update(elapsed:Float, camX:Float, camY:Float)
    {
        var vanishX = (camX - originalX) / sprite.width;
        var vanishY = 1 - (camY - originalY) / sprite.height;

        var topX = depth * vanishX;
        var topY = depth * (vanishX - 1) + 1;

        if (topY > 1)
            sprite.scale.set(originalScaleX * (1 + depth * (vanishX - 1)), originalScaleY * (depth * vanishY));
        else if (topX < 0)
        {
            sprite.scale.set(originalScaleX * (1 - depth * vanishX), originalScaleY * (depth * vanishY));
            sprite.x = originalX + sprite.width * depth * vanishX;
        }
        else
            sprite.scale.set(originalScaleX, originalScaleY * (depth * vanishY));

        sprite.y = originalY + sprite.height * (1 - depth * Math.max(vanishY, 0));

        shader.u_top.value = [topX, topY];
    }

    public function destroy()
    {
        sprite.shader = null;
        sprite.scale.set(originalScaleX, originalScaleY);
        sprite.x = originalX;
        sprite.y = originalY;
    }
}

class PerspectiveShader extends FlxShader {

    @:glFragmentSource('
#pragma header
uniform vec2 u_top;
void main() {
    vec2 uv = vec2(openfl_TextureCoordv.x, 1.0 - openfl_TextureCoordv.y);

    vec2 bottom = vec2(0.0, 1.0), top = u_top;
    if (top.y > 1.0) {
        top.x /= top.y;
        bottom.y /= top.y;
        top.y = 1.0;
    } else if (top.x < 0.0) {
        top.x = 1.0 - top.x;
        top.y = 1.0 - (1.0 - top.y) / top.x;
        bottom.x = 1.0 - (1.0 - bottom.x) / top.x;
        top.x = 0.0;
    }

    vec2 side = mix(bottom, top, uv.y);
    uv = vec2((uv.x - side.x) / (side.y - side.x), 1.0 - uv.y);
    gl_FragColor = (uv.x < 0.0 || uv.x > 1.0 || uv.y < 0.0 || uv.y > 1.0) ? vec4(0.0) : flixel_texture2D(bitmap, uv);
}
    ')

    public function new() {
        super();
    }
}
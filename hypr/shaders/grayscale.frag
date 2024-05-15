/*
 * Grayscale
 */

precision highp float;
varying vec2 v_texcoord;
uniform sampler2D tex;

// Enum for type of grayscale conversion
const int LUMINOSITY = 0;
const int LIGHTNESS = 1;
const int AVERAGE = 2;

/**
 * Type of grayscale conversion.
 */
const int Type = 1;

// Enum for selecting luma coefficients
const int PAL = 0;
const int HDTV = 1;
const int HDR = 2;

/**
 * Standard for calculating luma component.
 */
const int LuminosityType = 2;

void main() {
    vec4 pixColor = texture2D(tex, v_texcoord);

    float gray;
    if (Type == 1) {
        // https://en.wikipedia.org/wiki/Grayscale#Luma_coding_in_video_systems
        if (LuminosityType == PAL) {
            gray = dot(pixColor.rgb, vec3(0.299, 0.587, 0.114));
        } else if (LuminosityType == HDTV) {
            gray = dot(pixColor.rgb, vec3(0.2126, 0.7152, 0.0722));
        } else if (LuminosityType == HDR) {
            gray = dot(pixColor.rgb, vec3(0.2627, 0.6780, 0.0593));
        }
    }else if (Type == 2) {
        float maxPixColor = max(pixColor.r, max(pixColor.g, pixColor.b));
        float minPixColor = min(pixColor.r, min(pixColor.g, pixColor.b));
        gray = (maxPixColor + minPixColor) / 2.0;
    } else if (Type == 3) {
        gray = (pixColor.r + pixColor.g + pixColor.b) / 3.0;
    }
    vec3 grayscale = vec3(gray);

    gl_FragColor = vec4(grayscale, pixColor.a);
}

// vim: ft=glsl
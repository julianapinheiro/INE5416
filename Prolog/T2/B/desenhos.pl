%xylast - ultimo Id e coodenada inserida
%angle  - angulo atual
%active - controle do 'uselapis' -- active(1) -- e 'usenada' -- active(0)

:- dynamic xy/3.
:- dynamic xylast/3.
:- dynamic angle/1.
:- dynamic active/1.

xylast(1, 500, 500).
%xy(1, 500, 500).
angle(90).
active(1).
